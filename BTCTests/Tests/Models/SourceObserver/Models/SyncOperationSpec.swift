//
//  SyncOperationSpec.swift
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

class SyncOperationSpec: QuickSpec {

    override func spec() {

        describe("SyncOperation") {

            var sut: BaseOperation!

            beforeEach {
                sut = SyncOperation()
            }

            it("Should have isAsynchronous == false") {
                expect(sut.isAsynchronous).to(beFalse())
            }
        }
    }
}
