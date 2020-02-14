//
//  ShadowBuilder.swift
//  BTC
//
//  Created by Tomasz Korab on 13/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

protocol ShadowBuilder {

    var color: UIColor { get }
    var opacity: Float { get }
    var radius: CGFloat { get }
    var offset: CGSize { get }

    func set(to view: UIView)

}
