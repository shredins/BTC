//
//  BitstampRestorerSpec.swift
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

class BitstampRestorerSpec: QuickSpec {

    override func spec() {

        describe("BitstampRestorer") {

            var sut: SourceRestorerProtocol!
            var delegate: Delegate!
            var websocketManager: WebsocketManager!

            beforeEach {
                delegate = Delegate()
                websocketManager = WebsocketManager()

                DependencyInjection.container.register { websocketManager as LiveTradesWebsocketManagerProtocol }

                sut = BitstampRestorer()
                sut.delegate = delegate
            }

            it("Should successfully restore source") {
                websocketManager.shouldSucceed = true
                sut.restore()
                expect(delegate.restoredSource).to(beAKindOf(BitstampSource.self))
            }

            it("Should fail restoring source") {
                websocketManager.shouldSucceed = false
                sut.restore()
                expect(delegate.didFail).to(beTrue())
            }
        }
    }
}

private extension BitstampRestorerSpec {

    class Delegate: SourceRestorerDelegate {

        // MARK: - Mock Properties
        var didFail = false
        var restoredSource: SourceProtocol?

        // MARK: - Implementation
        func bitstampRestorerDidFailRestoring(_ restorer: BitstampRestorer) {
            didFail = true
        }

        func bitstampRestorer(_ restorer: BitstampRestorer, didRestore source: SourceProtocol) {
            restoredSource = source
        }

    }

    class WebsocketManager: LiveTradesWebsocketManagerProtocol {

        // MARK: - Mock Properties
        var shouldSucceed = true

        // MARK: - Implementation
        func subscribe(_ completion: @escaping (Result<WSSubscriptionAck, Error>) -> Void) {
            if shouldSucceed {
                let response = WSSubscriptionAck(event: .subscriptionSucceeded, channel: .BTCtoUSD)
                completion(.success(response))
            } else {
                let error = WebsocketManagerError.disconnected
                completion(.failure(error))
            }
        }

        func listenLiveTrades(_ completion: @escaping (Result<TradeResponse, Error>) -> Void) {}
        func disconnect(_ didDisconnect: WebsocketDisconnectCompletion?) {}

    }

}
