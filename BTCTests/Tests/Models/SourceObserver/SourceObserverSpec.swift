//
//  SourceObserverSpec.swift
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

class SourceObserverSpec: QuickSpec {

    override func spec() {

        describe("SourceObserver") {

            var sut: SourceObserverProtocol!
            var delegate: Delegate!
            var queue: DispatchQueue!
            var operationDelegate: OperationDelegate!
            var operationQueue: SourceOperationQueueProtocol!

            beforeEach {
                delegate = Delegate()
                operationDelegate = OperationDelegate()
                queue = DispatchQueue(label: "SourceObserverSpec", qos: .userInteractive)
                operationQueue = SourceOperationQueue(queue: queue)

                DependencyInjection.container.register { operationQueue as SourceOperationQueueProtocol }
                DependencyInjection.container.register { Date.formatter as DateFormatter }

                sut = SourceObserver()

                sut.delegate = delegate
                sut.operationDelegate = operationDelegate
            }

            context("Should add first source") {

                var firstSource: FirstTradeSource!

                beforeEach {
                    firstSource = FirstTradeSource()
                    sut.add(source: firstSource)
                    queue.sync {}
                }

                it("Should send cellItem to delegate with correct price text") {
                    expect(operationDelegate.cellItems.first!.BTCtoUSDPriceText).to(equal(1.0.usdText))
                }

                it("Should have firstSource's delegate set to sut") {
                    expect(firstSource.delegate).to(be(sut))
                }

                it("Should have 1 source") {
                    expect(sut.sources).to(haveCount(1))
                }

                it("Should have first source equal to firstSource") {
                    expect(sut.sources.first).to(be(firstSource))
                }

                context("Should add second source") {

                    var secondSource: SecondTradeSource!

                    beforeEach {
                        secondSource = SecondTradeSource()
                        sut.add(source: secondSource)
                        queue.sync {}
                    }

                    it("Should have 2 cellItems") {
                        expect(operationDelegate.cellItems).to(haveCount(2))
                    }

                    it("Should send cellItem to delegate with correct price text") {
                        expect(operationDelegate.cellItems.last!.BTCtoUSDPriceText).to(equal(2.0.usdText))
                    }

                    it("Should have 1 source because SecondTradeSource calls sourceDidFinish(source:)") {
                        expect(sut.sources).to(haveCount(1))
                    }

                    context("Should add failing source") {

                        var failingSource: FailingSource!

                        beforeEach {
                            failingSource = FailingSource()
                            sut.add(source: failingSource)
                            queue.sync {}
                        }

                        it("Should still have 1 source because FailingSource calls sourceDidFinish(source:)") {
                            expect(sut.sources).to(haveCount(1))
                        }

                        it("Should detect failure") {
                            expect(delegate.didDetectFailure).to(beTrue())
                        }
                    }
                }
            }
        }
    }
}

private extension SourceObserverSpec {

    class Delegate: SourceObserverDelegate {

        // MARK: - Mock Properties
        var didDetectFailure = false

        // MARK: - Implementation
        func sourceObserver(_ observer: SourceObserverProtocol, didDetectSourceFailure source: SourceProtocol) {
            didDetectFailure = true
        }

    }

    class OperationDelegate: LiveTradeOperationDelegate {

        // MARK: - Mock Properties
        var cellItems: [LiveTradeCellItem] = []

        // MARK: - Implementation
        func liveTradeOperationDelegate(_ operation: LiveTradeOperation, didProduce cellItem: LiveTradeCellItem) {
            cellItems.append(cellItem)
        }

    }

    class FirstTradeSource: SourceProtocol {

        // MARK: - Properties
        let id: String = UUID().uuidString

        // MARK: - Weak Properties
        weak var delegate: SourceDelegate? {
            didSet {
                let trade = Trade(timestamp: .init(), priceStr: "1.0", price: 1.0)
                delegate?.source(self, didProduce: trade)
            }
        }

    }

    class SecondTradeSource: SourceProtocol {

        // MARK: - Properties
        let id: String = UUID().uuidString

        // MARK: - Weak Properties
        weak var delegate: SourceDelegate? {
            didSet {
                let trade = Trade(timestamp: .init(), priceStr: "2.0", price: 2.0)
                delegate?.source(self, didProduce: trade)
                delegate?.sourceDidFinish(self)
            }
        }

    }

    class FailingSource: SourceProtocol {

        // MARK: - Properties
        let id: String = UUID().uuidString
        
        // MARK: - Weak Properties
        weak var delegate: SourceDelegate? {
            didSet {
                delegate?.sourceDidFail(self)
                delegate?.sourceDidFinish(self)
            }
        }

    }

}
