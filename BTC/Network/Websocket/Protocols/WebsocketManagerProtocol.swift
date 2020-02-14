//
//  WebsocketNetworkManager.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Starscream

typealias WebsocketConnectCompletion = (Bool) -> Void

protocol WebsocketManagerProtocol: WebsocketDisconnectProtocol {

    var secrets: SecretsProtocol { get }

    func connect(didConnect: WebsocketConnectCompletion?)

}
