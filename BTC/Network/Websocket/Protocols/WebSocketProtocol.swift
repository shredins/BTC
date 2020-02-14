//
//  WebSocketProtocol.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Starscream

protocol WebSocketProtocol: class {

    var onConnect: (() -> Void)? { get set }
    var onDisconnect: ((Error?) -> Void)? { get set }
    var onText: ((String) -> Void)? { get set }

    init(url: URL)

    func connect()
    func disconnect()
    func write(string: String)

}


