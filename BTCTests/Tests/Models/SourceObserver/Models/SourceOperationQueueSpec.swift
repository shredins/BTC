//
//  SourceOperationQueueSpec.swift
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

class SourceOperationQueueSpec: QuickSpec {

    override func spec() {

        describe("SourceOperationQueue") {

            var sut: SourceOperationQueueProtocol!
            var queue: DispatchQueue!
            var delegate: Delegate!

            beforeEach {
                queue = DispatchQueue(label: "SourceOperationQueueSpec", qos: .userInitiated)
                delegate = Delegate()

                DependencyInjection.container.register { Date.formatter as DateFormatter }

                sut = SourceOperationQueue(queue: queue)
            }

            it("Should have maxConcurrentOperationCount == 1") {
                expect(sut.maxConcurrentOperationCount).to(equal(1))
            }

            context("Should add operations to the queue") {

                beforeEach {
                    [
                        Trade(timestamp: .init(), priceStr: "1.0", price: 1.0),
                        Trade(timestamp: .init(), priceStr: "2.0", price: 2.0),
                        Trade(timestamp: .init(), priceStr: "3.0", price: 3.0)
                    ].forEach {
                        sut.process(trade: $0, delegate: delegate)
                        queue.sync {}
                    }
                }

                it("Should pass 3 cellItems to delegate") {
                    expect(delegate.producedCellItems).to(haveCount(3))
                }

                it("Should have 1 cell item with correct price text") {
                    expect(delegate.producedCellItems[0].BTCtoUSDPriceText).to(equal(1.0.usdText))
                }

                it("Should have 2 cell item with correct price text") {
                    expect(delegate.producedCellItems[1].BTCtoUSDPriceText).to(equal(2.0.usdText))
                }

                it("Should have 3 cell item with correct price text") {
                    expect(delegate.producedCellItems[2].BTCtoUSDPriceText).to(equal(3.0.usdText))
                }
            }
        }
    }
}

private extension SourceOperationQueueSpec {

    class Delegate: LiveTradeOperationDelegate {

        // MARK: - Mock Properties
        var producedCellItems: [LiveTradeCellItem] = []

        // MARK: - Implementations
        func liveTradeOperationDelegate(_ operation: LiveTradeOperation, didProduce cellItem: LiveTradeCellItem) {
            producedCellItems.append(cellItem)
        }

    }

}
