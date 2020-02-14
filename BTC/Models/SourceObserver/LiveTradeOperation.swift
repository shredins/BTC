//
//  LiveTradeOperation.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

class LiveTradeOperation: SyncOperation {

    // MARK: - Properties
    let trade: Trade

    // MARK: - Weak Properties
    weak var delegate: LiveTradeOperationDelegate?

    // MARK: - Inits
    init(trade: Trade, delegate: LiveTradeOperationDelegate) {
        self.trade = trade
        self.delegate = delegate
    }

    // MARK: - Overridden Methods
    override func main() {
        var sentiment: Double?
        let sentimentModel = BitcoinSentiment()
        let date = trade.timestamp.text(format: .ddMMMHHmm)

        if trade.price >= .minPrice && trade.price <= .maxPrice {
            sentiment = try? sentimentModel.prediction(Price: trade.price).Sentiment
        }

        let newCellItem = LiveTradeCellItem(dateText: date,
                                            BTCtoUSDPriceText: trade.price.usdText,
                                            sentiment: sentiment)

        delegate?.liveTradeOperationDelegate(self, didProduce: newCellItem)

        finish()
    }

}

private extension Double {
    static let minPrice = 2000.0
    static let maxPrice = 18000.0
}
