//
//  LiveTradeCellItem.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit
import FDTTableViewManager

class LiveTradeCellItem: TableViewCellItem<LiveTradeCell> {

    // MARK: - Properties
    let dateText: String
    let BTCtoUSDPriceText: String
    let sentimentText: String?
    let sentimentColor: UIColor?
    var isScrolledTop = false

    // MARK: - Inits
    init(dateText: String, BTCtoUSDPriceText: String, sentiment: Double?) {
        self.dateText = dateText
        self.BTCtoUSDPriceText = BTCtoUSDPriceText

        if let sentiment = sentiment {
            self.sentimentText = sentiment.sentimentText
            self.sentimentColor = sentiment >= .sentimentMiddle ? .btcGreen : .btcRed
        } else {
            self.sentimentText = nil
            self.sentimentColor = nil
        }
    }

    // MARK: - Overridden Methods
    override func setLayout(of cell: LiveTradeCell) {
        cell.dateLabel.text = dateText
        cell.priceLabel.text = BTCtoUSDPriceText

        if let sentimentText = sentimentText, let sentimentColor = sentimentColor {
            cell.showSentiment(with: sentimentText, backgroundColor: sentimentColor)
        } else {
            cell.hideSentiment()
        }

        isScrolledTop ? cell.animateScrollingTop() : cell.animateScrollingBottom()
    }

}

private extension Double {
    static let sentimentMiddle = 0.5
}
