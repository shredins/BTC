//
//  LiveTradesViewControllerSpec.swift
//  BTCTests
//
//  Created by Tomasz Korab on 14/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable
import BTC

class LiveTradesViewControllerSpec: QuickSpec {

    override func spec() {

        describe("LiveTradesViewController") {

            var sut: LiveTradesViewController!

            beforeEach {
                DependencyInjection.container.register { ViewModel() as LiveTradesViewModelProtocol }
                DependencyInjection.container.register { BTCConfiguration() as BTCConfigurationProtocol }
                DependencyInjection.container.register { SourceOperationQueue() as SourceOperationQueueProtocol }

                sut = LiveTradesViewController(websocketManager: WebsocketManager())

                sut.view.layoutIfNeeded()
            }

            it("Should have view equal to sut") {
                expect(sut.view).to(be(sut.liveTradesView))
            }

            it("Should have viewModel's delegate equal to sut") {
                expect(sut.viewModel.delegate).to(be(sut))
            }

            it("Should have viewModel's uiDelegate equal to liveTradesView") {
                expect(sut.viewModel.uiDelegate).to(be(sut.liveTradesView))
            }
        }
    }
}

private extension LiveTradesViewControllerSpec {

    class ViewModel: LiveTradesViewModelProtocol {

        // MARK: - Implementation
        let title: String = "Title"
        let analyzer: EventAnalyzerProtocol = EventAnalyzer()
        let tradesStorage: TradesStorageProtocol = TradesStorage()
        let sourceObserver: SourceObserverProtocol = SourceObserver()
        let config: LiveTradesConfigurationProtocol = BTCConfiguration()

        weak var delegate: LiveTradesViewModelDelegate?
        weak var uiDelegate: LiveTradesViewModelUIDelegate?

        func viewWillAppear() {

        }

        func set(tableView: UITableView) {

        }

        func set(websocketManager: LiveTradesWebsocketManagerProtocol) {

        }

        func liveTradeOperationDelegate(_ operation: LiveTradeOperation, didProduce cellItem: LiveTradeCellItem) {

        }

        func eventAnalyzer(_ analyzer: EventAnalyzerProtocol, didCommand order: EventAnalyzerOrder) {

        }

        func sourceObserver(_ observer: SourceObserverProtocol, didDetectSourceFailure source: SourceProtocol) {

        }

    }

    class WebsocketManager: LiveTradesWebsocketManagerProtocol {
        func listenLiveTrades(_ completion: @escaping (Result<TradeResponse, Error>) -> Void) {}
        func subscribe(_ completion: @escaping (Result<WSSubscriptionAck, Error>) -> Void) {}
        func disconnect(_ didDisconnect: WebsocketDisconnectCompletion?) {}
    }

}
