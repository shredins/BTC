//
//  TradeResponse.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

struct TradeResponse: Decodable {
    let data: Trade
    let event: WSEvent
    let channel: WSSubscriptionChannel
}
