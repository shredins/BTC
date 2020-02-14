//
//  BitstampSourceSpec.swift
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

class BitstampSourceSpec: QuickSpec {

    override func spec() {

        describe("BitstampSource") {

            var sut: SourceProtocol!
            var delegate: Delegate!
            var websocketManager: WebsocketManager!

            beforeEach {
                delegate = Delegate()
                websocketManager = WebsocketManager()

                sut = BitstampSource(liveTradesWebsocketManager: websocketManager)
            }

            context("Should receive response") {

                beforeEach {
                    websocketManager.shouldSucceed = true
                    sut.delegate = delegate
                }

                it("Should return  trade having price == 1.0") {
                    expect(delegate.producedTrade?.price).to(equal(1.0))
                }

            }

            context("Should fail receiving response") {

                beforeEach {
                    websocketManager.shouldSucceed = false
                    sut.delegate = delegate
                }

                it("Should call sourceDidFail") {
                    expect(delegate.didFail).to(beTrue())
                }

                it("Should call sourceDidFinish") {
                    expect(delegate.didFail).to(beTrue())
                }

            }
        }
    }
}

private extension BitstampSourceSpec {

    class Delegate: SourceDelegate {

        // MARK: - Mock Properties
        var didFail = false
        var didFinish = false
        var producedTrade: Trade?

        // MARK: - Implementation
        func sourceDidFail(_ source: SourceProtocol) {
            didFail = true
        }

        func sourceDidFinish(_ source: SourceProtocol) {
            didFinish = true
        }

        func source(_ source: SourceProtocol, didProduce trade: Trade) {
            producedTrade = trade
        }

    }

    class WebsocketManager: LiveTradesWebsocketManagerProtocol {

        // MARK: - Mock Properties
        var shouldSucceed = true

        // MARK: - Implementation
        func listenLiveTrades(_ completion: @escaping (Result<TradeResponse, Error>) -> Void) {
            if shouldSucceed {
                let trade = Trade(timestamp: .init(), priceStr: "1.0", price: 1.0)
                let response = TradeResponse(data: trade, event: .trade, channel: .BTCtoUSD)
                completion(.success(response))
            } else {
                let error = WebsocketManagerError.disconnected
                completion(.failure(error))
            }
        }

        func subscribe(_ completion: @escaping (Result<WSSubscriptionAck, Error>) -> Void) {}
        func disconnect(_ didDisconnect: WebsocketDisconnectCompletion?) {}

    }

}
