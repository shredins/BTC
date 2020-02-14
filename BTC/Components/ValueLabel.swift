//
//  ValueLabel.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

class ValueLabel: UILabel {

    // MARK: - Inits
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Instance Methods
    private func setup() {
        font = .btcValue
        textColor = .btcBlack
    }

}

