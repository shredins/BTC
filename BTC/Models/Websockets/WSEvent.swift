//
//  WSEvent.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

enum WSEvent: String, Codable {
    case trade = "trade"
    case subscribe = "bts:subscribe"
    case subscriptionSucceeded = "bts:subscription_succeeded"
}
