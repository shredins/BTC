//
//  BTCConfigurationSpec.swift
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

class BTCConfigurationSpec: QuickSpec {

    override func spec() {

        describe("BTCConfiguration") {

            var sut: BTCConfigurationProtocol!

            beforeEach {
                sut = BTCConfiguration()
            }

            it("Should have numberOfTradesFromREST default to 25") {
                expect(sut.numberOfTradesFromREST).to(equal(25))
            }

            it("Should have loadFromRESTFrequency default to 100") {
                expect(sut.loadFromRESTFrequency).to(equal(100))
            }

            it("Should have storeTradesFrequency default to 1000") {
                expect(sut.storeTradesFrequency).to(equal(1000))
            }

            it("Should have numberOfStoredTrades default to 1000") {
                expect(sut.numberOfStoredTrades).to(equal(1000))
            }

        }
    }
}
