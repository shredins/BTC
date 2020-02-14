//
//  DropShadowBuilder.swift
//  BTC
//
//  Created by Tomasz Korab on 13/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

struct DropShadowBuilder: ShadowBuilder {
    let color: UIColor = .btcBlack
    let opacity: Float = 0.15
    let radius: CGFloat = 6
    let offset: CGSize = .init(width: 0, height: 1)
}
