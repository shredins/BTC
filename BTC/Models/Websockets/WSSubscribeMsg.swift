//
//  WSSubscribeMsg.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

struct WSSubscribeMsg: Encodable {

    let event: WSEvent
    let data: WSChannel

    init(event: WSEvent, channel: WSSubscriptionChannel) {
        self.event = event
        self.data = WSChannel(channel: channel)
    }

}
