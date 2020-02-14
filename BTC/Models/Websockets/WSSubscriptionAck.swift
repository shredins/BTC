//
//  WSSubscriptionAck.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

struct WSSubscriptionAck: Decodable {
    let event: WSEvent
    let channel: WSSubscriptionChannel
}
