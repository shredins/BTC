//
//  LiveTradeOperationSpec.swift
//  BTCTests
//
//  Created by Tomasz Korab on 13/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable
import BTC

class LiveTradeOperationSpec: QuickSpec {

    override func spec() {

        describe("LiveTradeOperation") {

            var sut: BaseOperation!
            var delegate: Delegate!

            beforeEach {
                let date = Date(timeIntervalSince1970: 1577916000) // 01/01/2020 @ 10:00pm (UTC)
                let trade = Trade(timestamp: date, priceStr: "3000.0", price: 3000.0)
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en")

                delegate = Delegate()

                DependencyInjection.container.register { formatter as DateFormatter }

                sut = LiveTradeOperation(trade: trade, delegate: delegate)
            }

            context("Should produce cellItem when main start()") {

                var cellItem: LiveTradeCellItem!

                beforeEach {
                    sut.start()
                    cellItem = delegate.producedCellItem
                }

                it("Should have not nil cellItem") {
                    expect(cellItem).toNot(beNil())
                }

                it("Should have dateText equal to '01 Jan at 23:00'") {
                    expect(cellItem!.dateText).to(equal("01 Jan at 23:00"))
                }

                it("Should have correct BTCtoUSDPriceText") {
                    // Must be checked this way because iOS <= 12 styles tests styles it different than iOS 13
                    let correctValue = 3000.0.usdText
                    expect(cellItem!.BTCtoUSDPriceText).to(equal(correctValue))
                }
            }
        }
    }
}

private extension LiveTradeOperationSpec {

    class Delegate: LiveTradeOperationDelegate {

        // MARK: - Mock Properties
        var producedCellItem: LiveTradeCellItem?

        // MARK: - Implementation
        func liveTradeOperationDelegate(_ operation: LiveTradeOperation, didProduce cellItem: LiveTradeCellItem) {
            producedCellItem = cellItem
        }

    }

}
