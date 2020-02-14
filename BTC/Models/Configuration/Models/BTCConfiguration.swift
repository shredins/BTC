//
//  BTCConfiguration.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

struct BTCConfiguration: BTCConfigurationProtocol {
    let numberOfTradesFromREST: Int = 25
    let loadFromRESTFrequency: Int = 100
    let storeTradesFrequency: Int = 1000
    let numberOfStoredTrades: Int = 1000
}
