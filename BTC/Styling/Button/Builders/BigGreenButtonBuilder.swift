//
//  BigGreenButtonBuilder.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

struct BigGreenButtonBuilder: ButtonBuilder {
    let title: String
    let font: UIFont = .btcBigGreen
    let width: CGFloat? = nil
    let height: CGFloat? = 40
    let tintColor: UIColor = .btcGreen
    let borderWidth: CGFloat = 2
    let borderColor: UIColor = .btcGreen
    let backgroundColor: UIColor = .clear
    let cornerRadius: CGFloat = 20
    let contentEdgeInsets: UIEdgeInsets = .init(top: 0, left: 24, bottom: 0, right: 24)
}
