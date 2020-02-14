//
//  MockWebSocket.swift
//  BTCTests
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

@testable import BTC

class MockWebSocket: WebSocketProtocol {

    // MARK: - Mock Properties
    var didSetOnConnect = false
    var didSetOnDisconnect = false
    var didSetOnText = false
    var didCallConnect = false
    var didCallDisconnect = false
    var message: String?

    // MARK: - Requirements
    var onConnect: (() -> Void)? {
        didSet {
            didSetOnConnect = true
        }
    }

    var onDisconnect: ((Error?) -> Void)? {
        didSet {
            didSetOnDisconnect = true
        }
    }

    var onText: ((String) -> Void)? {
        didSet {
            didSetOnText = true
        }
    }

    required init(url: URL) {

    }

    func connect() {
        didCallConnect = true
    }

    func disconnect() {
        didCallDisconnect = true
    }

    func write(string: String) {
        message = string
    }

}
