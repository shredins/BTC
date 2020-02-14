//
//  SendWebsocketManagerSpec.swift
//  BTCTests
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable
import BTC

class BitstampWebsocketManagerSpec: QuickSpec {

    override func spec() {

        describe("BitstampWebsocketManager") {

            var sut: BitstampWebsocketManager!

            context("Should use disconnected WebSocket") {

                var disconnectedWebSocket: DisconnectedWebSocket!

                beforeEach {
                    DependencyInjection.container.register { DisconnectedWebSocket.self as WebSocketProtocol.Type }
                    DependencyInjection.container.register { JSONDecoder() as JSONDecoderProtocol }
                    DependencyInjection.container.register { JSONEncoder() as JSONEncoderProtocol }
                    sut = BitstampWebsocketManager()
                }

                context("Should fail because of disconnection") {

                    var result: Result<WSSubscriptionAck, Error>!

                    beforeEach {
                        let msg = WSSubscribeMsg(event: .subscribe, channel: .BTCtoUSD)
                        sut.send(input: msg) { (response: Result<WSSubscriptionAck, Error>) in
                            result = response
                        }
                        disconnectedWebSocket = sut.socket as? DisconnectedWebSocket
                    }

                    it("Should call websocket's connect()") {
                        expect(disconnectedWebSocket.didCallConnect).to(beTrue())
                    }

                    it("Should set onText") {
                        expect(disconnectedWebSocket.didSetOnText).to(beFalse())
                    }

                    it("Should return failure") {
                        switch result {
                        case .failure(let error):
                            if let error = error as? WebsocketManagerError {
                                expect(error).to(equal(.disconnected))
                            } else {
                                fail()
                            }
                        default:
                            fail()
                        }
                    }
                }
            }

            context("Should use connected WebSocket") {

                var websocket: SendWebSocket!

                beforeEach {
                    DependencyInjection.container.register { SendWebSocket.self as WebSocketProtocol.Type }
                    DependencyInjection.container.register { JSONDecoder() as JSONDecoderProtocol }
                    DependencyInjection.container.register { JSONEncoder() as JSONEncoderProtocol }
                    sut = BitstampWebsocketManager()
                }

                context("Should send correctly with ack handling") {

                    var result: Result<WSSubscriptionAck, Error>!

                    beforeEach {
                        let msg = WSSubscribeMsg(event: .subscribe, channel: .BTCtoUSD)
                        sut.send(input: msg) { (response: Result<WSSubscriptionAck, Error>) in
                            result = response
                        }
                        websocket = sut.socket as? SendWebSocket
                    }

                    it("Should call websocket's connect()") {
                        expect(websocket.didCallConnect).to(beTrue())
                    }

                    it("Should call websocket's write()") {
                        expect(websocket.didCallWrite).to(beTrue())
                    }

                    it("Should set onText") {
                        expect(websocket.didSetOnText).to(beTrue())
                    }

                    it("Should return success") {
                        switch result {
                        case .success(let ack):
                            expect(ack.event).to(equal(.subscriptionSucceeded))
                        default:
                            fail()
                        }
                    }

                }

                context("It should correctly setup socket when connect called") {

                    beforeEach {
                        sut.connect()
                        websocket = sut.socket as? SendWebSocket
                    }

                    it("Should set onConnect") {
                        expect(websocket.didSetOnConnect).to(beTrue())
                    }

                    it("Should set onDisconnect") {
                        expect(websocket.didSetOnDisconnect).to(beTrue())
                    }

                    it("Should call websocket's connect()") {
                        expect(websocket.didCallConnect).to(beTrue())
                    }

                    context("It should correctly clean up socket when disconnect called") {

                        beforeEach {
                            websocket.didSetOnDisconnect = false
                            sut.disconnect(nil)
                        }

                        it("Should set onDiconnect") {
                            expect(websocket.didSetOnDisconnect).to(beTrue())
                        }

                        it("Should call websocket's disconnect()") {
                            expect(websocket.didCallDisconnect).to(beTrue())
                        }

                    }
                }
            }
        }
    }
}

private extension BitstampWebsocketManagerSpec {

    class SendWebSocket: MockWebSocket {

        var didCallWrite: Bool = false

        override func connect() {
            super.connect()
            onConnect?()
        }

        override func write(string: String) {
            didCallWrite = true
            let response = "{\"event\":\"bts:subscription_succeeded\",\"channel\":\"live_trades_btcusd\",\"data\":{}}"
            onText?(response)
        }

    }

}
