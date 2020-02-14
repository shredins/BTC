//
//  RestorerFactorySpec.swift
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

class RestorerFactorySpec: QuickSpec {

    override func spec() {

        describe("RestorerFactory") {

            it("Should return BitstampRestorer for BitstampSource") {
                let websocketManager = WebsocketManager()
                let source = BitstampSource(liveTradesWebsocketManager: websocketManager)
                expect(RestorerFactory.restorer(for: source)).to(beAKindOf(BitstampRestorer.self))
            }

            it("Should return nil for Source") {
                let source = Source()
                expect(RestorerFactory.restorer(for: source)).to(beNil())
            }
        }
    }
}

private extension RestorerFactorySpec {

    class WebsocketManager: LiveTradesWebsocketManagerProtocol {
        func listenLiveTrades(_ completion: @escaping (Result<TradeResponse, Error>) -> Void) {}
        func subscribe(_ completion: @escaping (Result<WSSubscriptionAck, Error>) -> Void) {}
        func disconnect(_ didDisconnect: WebsocketDisconnectCompletion?) {}
    }

    class Source: SourceProtocol {

        // MARK: - Properties
        let id: String = UUID().uuidString

        // MARK: - Weak Properties
        weak var delegate: SourceDelegate?

    }

}
