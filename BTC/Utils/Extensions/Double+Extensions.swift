//
//  Double+Extensions.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

extension Double {

    var usdText: String {
        let value = NSNumber(value: self)
        return NumberFormatter.btcDollars.string(from: value) ?? "\(self)"
    }

    var sentimentText: String {
        let value = NSNumber(value: self)
        return NumberFormatter.btcSentiment.string(from: value) ?? "\(self)"
    }

}
