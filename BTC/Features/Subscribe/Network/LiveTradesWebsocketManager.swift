//
//  LiveTradesWebsocketManager.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

protocol LiveTradesWebsocketManagerProtocol: WebsocketDisconnectProtocol {
    func listenLiveTrades(_ completion: @escaping (Result<TradeResponse, Error>) -> Void)
    func subscribe(_ completion: @escaping (Result<WSSubscriptionAck, Error>) -> Void)
}

class LiveTradesWebsocketManager: BitstampWebsocketManager, LiveTradesWebsocketManagerProtocol {

    func subscribe(_ completion: @escaping (Result<WSSubscriptionAck, Error>) -> Void) {
        // Channel type is already set since requirement is to listen only this event
        let msg = WSSubscribeMsg(event: .subscribe, channel: .BTCtoUSD)
        send(input: msg, completion: completion)
    }

    func listenLiveTrades(_ completion: @escaping (Result<TradeResponse, Error>) -> Void) {
        listen(completion)
    }

}
