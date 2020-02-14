//
//  WebSocketAdapter.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Starscream

class WebsocketAdapter: WebSocket, WebSocketProtocol {

    required init(url: URL) {
        let request = URLRequest(url: url)
        super.init(request: request)
    }

}
