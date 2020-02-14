//
//  WebsocketManager.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Starscream

/// This is basic implementation which will be common for most of websocket managers.
/// Subclasses should provide detailed informations like credentials etc.
class WebsocketManager: WebsocketManagerProtocol {

    // MARK: - Properties
    var socket: WebSocketProtocol?

    // MARK: - Get-only Properties
    var secrets: SecretsProtocol {
        fatalError("Create configurations where each API will have its own websocket manager")
    }

    // MARK: - Private Properties
    private let webSocketType: WebSocketProtocol.Type = inject()

    // MARK: - Public Instance Methods
    func connect(didConnect: WebsocketConnectCompletion? = nil) {
        socket = webSocketType.init(url: secrets.apiUrl)

        socket?.onConnect = {
            didConnect?(true)
        }

        socket?.onDisconnect = { _ in
            didConnect?(false)
        }

        socket?.connect()
    }

    func disconnect(_ didDisconnect: WebsocketDisconnectCompletion?) {
        socket?.onDisconnect = { [weak self] error in
            guard let strongSelf = self else {
                return
            }

            strongSelf.socket = nil
            didDisconnect?(error)
        }

        socket?.disconnect()
    }

}
