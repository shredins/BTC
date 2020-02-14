//
//  NumberFormatter+Extensions.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

extension NumberFormatter {

    static let btcDollars: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        if #available(iOS 13, *) {
            formatter.currencySymbol = .currencyCode
        } else {
            formatter.currencyCode = .currencyCode
        }

        formatter.minimumIntegerDigits = .minimumIntegerDigits
        formatter.minimumFractionDigits = .minimumFractionDigits
        formatter.maximumFractionDigits = .dollarMaximumFractionDigits
        return formatter
    }()

    static let btcSentiment: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.roundingMode = .down
        formatter.minimumIntegerDigits = .minimumIntegerDigits
        formatter.minimumFractionDigits = .sentimentFractionDigits
        formatter.maximumFractionDigits = .sentimentFractionDigits
        return formatter
    }()

}

private extension String {
    static let currencyCode = "USD"
}

private extension Int {
    static let minimumIntegerDigits = 1
    static let minimumFractionDigits = 0
    static let dollarMaximumFractionDigits = 2
    static let sentimentFractionDigits = 3
}
