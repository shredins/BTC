//
//  Trade.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

// I've cut model to only needed properties
struct Trade: Decodable {
    let timestamp: Date
    let priceStr: String
    let price: Double
}
