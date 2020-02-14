//
//  BTCConfigurationProtocol.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

protocol BTCConfigurationProtocol: RESTSourceConfigurationProtocol, LiveTradesConfigurationProtocol {
    var loadFromRESTFrequency: Int { get }
    var storeTradesFrequency: Int { get }
}
