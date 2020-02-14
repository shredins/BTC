//
//  WebsocketManagerSpec.swift
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

class WebsocketManagerSpec: QuickSpec {

    override func spec() {

        describe("WebsocketManager") {

            var sut: MockWebsocketManager!
            var websocket: MockWebSocket!

            beforeEach {
                DependencyInjection.container.register { MockWebSocket.self as WebSocketProtocol.Type }
                sut = MockWebsocketManager()
            }

            context("It should correctly setup socket when connect called") {

                beforeEach {
                    sut.connect()
                    websocket = sut.socket as? MockWebSocket
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

extension WebsocketManagerSpec {

    class MockWebsocketManager: WebsocketManager {

        override var secrets: SecretsProtocol {
            MockSecrets()
        }

    }

}
