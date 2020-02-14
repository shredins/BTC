//
//  LiveTradesViewModelSpec.swift
//  BTCTests
//
//  Created by Tomasz Korab on 14/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import XCTest
import Quick
import Nimble
import FDTTableViewManager

@testable
import BTC

class LiveTradesViewModelSpec: QuickSpec {

    override func spec() {

        describe("LiveTradesViewModel") {

            var sut: LiveTradesViewModelProtocol!
            var queue: DispatchQueue!
            var delegate: Delegate!
            var uiDelegate: UIDelegate!
            var analyzer: Analyzer!
            var tableView: UITableView!
            var storage: Storage!
            var tableViewManager: TableViewManager!
            var sourceObserver: MockSourceObserver!

            beforeEach {
                queue = DispatchQueue(label: "LiveTradesViewModelSpec", qos: .userInitiated)
                delegate = Delegate()
                analyzer = Analyzer()
                uiDelegate = UIDelegate()
                tableView = UITableView()
                storage = Storage()
                tableViewManager = TableViewManager()
                sourceObserver = MockSourceObserver()

                DependencyInjection.container.register { storage as TradesStorageProtocol }
                DependencyInjection.container.register { BTCConfiguration() as LiveTradesConfigurationProtocol }
                DependencyInjection.container.register { analyzer as EventAnalyzerProtocol }
                DependencyInjection.container.register { BTCConfiguration() as BTCConfigurationProtocol }
                DependencyInjection.container.register { tableViewManager as TableViewManager }
                DependencyInjection.container.register { sourceObserver as SourceObserverProtocol }
                DependencyInjection.container.register { BTCConfiguration() as RESTSourceConfigurationProtocol }
                DependencyInjection.container.register { Last25TradesManager() as Last25LiveTradesRESTManagerProtocol}

                sut = MockLiveTradesViewModel(cleanUpTitleDuration: 0, uiQueue: queue)

                sut.delegate = delegate
                sut.uiDelegate = uiDelegate
                sut.set(tableView: tableView)
            }

            it("Should have analyzer's delegate equal to sut") {
                expect(sut.analyzer.delegate).to(be(sut))
            }

            it("Should have sourceObserver's delegate equal to sut") {
                expect(sut.sourceObserver.delegate).to(be(sut))
            }

            it("Should have sourceObserver's operationDelegate equal to sut") {
                expect(sut.sourceObserver.operationDelegate).to(be(sut))
            }

            it("Should show indicator if viewWillAppear() called") {
                sut.viewWillAppear()
                expect(uiDelegate.shouldHideIndicator).to(beFalse())
            }

            it("Should add source when set(websocketManager:) called") {
                sut.set(websocketManager: WebsocketManager())
                expect(sourceObserver.didCallAddSource).to(beTrue())
            }

            it("Should ask to show alert when source failure detected") {
                let source = BitstampSource(liveTradesWebsocketManager: WebsocketManager())
                sut.sourceObserver(sourceObserver, didDetectSourceFailure: source)
                expect(delegate.alert).toNot(beNil())
            }

            it("Should add source when .loadFromREST order passed") {
                sut.eventAnalyzer(analyzer, didCommand: .loadFromREST)
                expect(sourceObserver.didCallAddSource).to(beTrue())
            }

            it("Should store cellItems when .storeLastTrades order passed") {
                sut.eventAnalyzer(analyzer, didCommand: .storeLastTrades)
                expect(storage.didCallToStore).to(beTrue())
            }

            context("Should produce cellItem") {

                beforeEach {
                    let trade = Trade(timestamp: .init(), priceStr: "1.0", price: 1.0)
                    let operation = LiveTradeOperation(trade: trade, delegate: sut)
                    let cellItem = LiveTradeCellItem(dateText: "Date", BTCtoUSDPriceText: "Price", sentiment: nil)
                    sut.liveTradeOperationDelegate(operation, didProduce: cellItem)
                    queue.sync {}
                }

                it("Should hide indicator") {
                    expect(uiDelegate.shouldHideIndicator).to(beTrue())
                }

                it("Should call analyzer's liveTradeAdded()") {
                    expect(analyzer.didCallTradeAdded).to(beTrue())
                }

                it("Should add cell item") {
                    let SUT = sut as! MockLiveTradesViewModel
                    expect(SUT.didAdd).to(beTrue())
                }
            }
        }
    }
}

private extension LiveTradesViewModelSpec {

    class MockLiveTradesViewModel: LiveTradesViewModel {

        // MARK: - Mock Properties
        var didAdd = false

        // MARK: - Implementation
        override func add(cellItem: LiveTradeCellItem) {
            cellItems = [cellItem]
            didAdd = true
        }

    }

    class Delegate: LiveTradesViewModelDelegate {

        // MARK: - Mock Properties
        var title: String?
        var alert: UIAlertController?

        // MARK: - Implementation
        func liveTradesViewModel(_ viewModel: LiveTradesViewModelProtocol, didChange title: String) {
            self.title = title
        }

        func liveTradesViewModel(_ viewModel: LiveTradesViewModelProtocol, didAskToPresent alert: UIAlertController) {
            self.alert = alert
        }
    }

    class UIDelegate: LiveTradesViewModelUIDelegate {

        // MARK: - Mock Properties
        var shouldHideIndicator: Bool?

        // MARK: - Implementation
        func liveTradesViewModel(_ viewModel: LiveTradesViewModelProtocol, askToHideIndicator indicatorIsHidden: Bool) {
            shouldHideIndicator = indicatorIsHidden
        }

    }

    class MockSourceObserver: SourceObserverProtocol {

        // MARK: - Mock Properties
        var didCallAddSource = false

        // MARK: - Implementation
        var sources: [SourceProtocol] = []
        var queue: SourceOperationQueueProtocol = SourceOperationQueue()

        weak var delegate: SourceObserverDelegate?
        weak var operationDelegate: LiveTradeOperationDelegate?

        func add(source: SourceProtocol) {
            didCallAddSource = true
        }

        func sourceDidFail(_ source: SourceProtocol) {}
        func sourceDidFinish(_ source: SourceProtocol) {}
        func source(_ source: SourceProtocol, didProduce trade: Trade) {}

    }

    class WebsocketManager: LiveTradesWebsocketManagerProtocol {
        func listenLiveTrades(_ completion: @escaping (Result<TradeResponse, Error>) -> Void) {}
        func subscribe(_ completion: @escaping (Result<WSSubscriptionAck, Error>) -> Void) {}
        func disconnect(_ didDisconnect: WebsocketDisconnectCompletion?) {}
    }

    class Source: SourceProtocol {

        // MARK: - Properties
        let id: String = UUID().uuidString

        // MARK: - Weak Properties
        weak var delegate: SourceDelegate?

    }

    class Analyzer: EventAnalyzerProtocol {

        // MARK: - Mock Properties
        var didCallTradeAdded = false

        // MARK: - Implementation
        var config: BTCConfigurationProtocol = BTCConfiguration()

        weak var delegate: EventAnalyzerDelegate?

        func liveTradeAdded() {
            didCallTradeAdded = true
        }

    }

    class Storage: TradesStorageProtocol {

        // MARK: - Mock Properties
        var didCallToStore = false

        // MARK: - Public Instance Methods
        func store(cellItems: [LiveTradeCellItem]) {
            didCallToStore = true
        }

    }

    class Last25TradesManager: Last25LiveTradesRESTManagerProtocol {
        func getLast25LiveTrades(_ completion: @escaping (Result<[Trade], Error>) -> Void) {}
    }

}
