//
//  SentimentLabel.swift
//  BTC
//
//  Created by Tomasz Korab on 13/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

class SentimentLabel: ValueLabel {

    // MARK: - Inits
    override init() {
        super.init()
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Instance Methods
    private func setup() {
        textColor = .btcWhite
    }

}
