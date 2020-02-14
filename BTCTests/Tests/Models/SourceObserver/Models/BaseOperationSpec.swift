//
//  BaseOperationSpec.swift
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

class BaseOperationSpec: QuickSpec {

    override func spec() {

        describe("BaseOperation") {

            var sut: MockBaseOperation!
            var queue: DispatchQueue!

            beforeEach {
                queue = DispatchQueue(label: "BaseOperationSpec", qos: .userInitiated)
                sut = MockBaseOperation(queue: queue)
            }

            it("Should start with isReady == true") {
                let isReady = sut.isReady
                queue.sync {}
                expect(isReady).to(beTrue())
            }

            it("Should set isFinished == true when finish() called") {
                sut.finish()
                let isFinished = sut.isFinished
                queue.sync {}
                expect(isFinished).to(beTrue())
            }

            it("Should set isExecuting == true when start() called") {
                sut.shouldFinishInMain = false
                sut.start()
                let isExecuting = sut.isExecuting
                queue.sync {}
                expect(isExecuting).to(beTrue())
            }

            it("Should set isFinished == true when start() called and main() executed inside it") {
                sut.shouldFinishInMain = true
                sut.start()
                let isFinished = sut.isFinished
                queue.sync {}
                expect(isFinished).to(beTrue())
            }
        }
    }
}

extension BaseOperationSpec {

    class MockBaseOperation: BaseOperation {

        // MARK: - Mock Properties
        var shouldFinishInMain = true

        // MARK: - Implementation
        override func main() {
            if shouldFinishInMain {
                finish()
            }
        }

    }

}
