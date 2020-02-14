//
//  ShadowBuilder+Extensions.swift
//  BTC
//
//  Created by Tomasz Korab on 13/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

extension ShadowBuilder {

    func set(to view: UIView) {
        let layer = view.layer
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }

}
