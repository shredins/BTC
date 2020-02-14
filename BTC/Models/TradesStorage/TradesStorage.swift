//
//  TradesStorage.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

// The local storage can be for now implemented as printing trades descriptions to the console
struct TradesStorage: TradesStorageProtocol {

    // MARK: - Public Instance Methods
    func store(cellItems: [LiveTradeCellItem]) {
        cellItems.forEach {
            let text = [String.first.localized, $0.dateText,
                        String.second.localized, $0.BTCtoUSDPriceText].joined(separator: " ")
            print(text)
        }
    }

}

private extension String {
    static let first = "trades.storage.removal.first.part"
    static let second = "trades.storage.removal.second.part"
}
