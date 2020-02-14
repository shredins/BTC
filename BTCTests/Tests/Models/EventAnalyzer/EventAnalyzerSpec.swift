//
//  EventAnalyzerSpec.swift
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

class EventAnalyzerSpec: QuickSpec {

    override func spec() {

        describe("EventAnalyzer") {

            var sut: EventAnalyzerProtocol!
            var delegate: Delegate!

            beforeEach {
                delegate = Delegate()

                DependencyInjection.container.register { Config() as BTCConfigurationProtocol }

                sut = EventAnalyzer()
                sut.delegate = delegate
            }

            it("Should send .loadFromREST every 5 events") {
                for _ in 0...4 {
                    sut.liveTradeAdded()
                }
                expect(delegate.order).to(equal(.loadFromREST))
            }

            it("Should send .storeLastTrades every 5 events") {
                for _ in 0...8 {
                    sut.liveTradeAdded()
                }
                expect(delegate.order).to(equal(.storeLastTrades))
            }

        }
    }
}

private extension EventAnalyzerSpec {

    class Delegate: EventAnalyzerDelegate {

        // MARK: - Mock Properties
        var order: EventAnalyzerOrder?

        // MARK: - Implementation
        func eventAnalyzer(_ analyzer: EventAnalyzerProtocol, didCommand order: EventAnalyzerOrder) {
            self.order = order
        }

    }

    struct Config: BTCConfigurationProtocol {
        let loadFromRESTFrequency: Int = 5
        let storeTradesFrequency: Int = 9
        let numberOfTradesFromREST: Int = 0
        let numberOfStoredTrades: Int = 0
    }

}
