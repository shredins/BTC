//
//  UIButton+Extensions.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

extension UIButton {

    static func builded(using builder: ButtonBuilder) -> UIButton {
        let button = UIButton(type: .system)
        builder.build(of: button)
        return button
    }

}
