//
//  EventAnalyzer.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

class EventAnalyzer: EventAnalyzerProtocol {

    // MARK: - Properties
    var counter = 0
    let config: BTCConfigurationProtocol = inject()

    // MARK: - Weak Properties
    weak var delegate: EventAnalyzerDelegate?

    // MARK: - Public Instance Methods
    func liveTradeAdded() {
        counter += 1

        if counter % config.loadFromRESTFrequency == 0 {
            delegate?.eventAnalyzer(self, didCommand: .loadFromREST)
        }

        if counter % config.storeTradesFrequency == 0 {
            delegate?.eventAnalyzer(self, didCommand: .storeLastTrades)
        }
    }

}
