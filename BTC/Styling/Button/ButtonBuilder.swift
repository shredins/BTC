//
//  ButtonStyle.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

protocol ButtonBuilder {

    // You can pass localizedKey which will be automatically converted depending on the language
    var title: String { get }
    var font: UIFont { get }
    var width: CGFloat? { get }
    var height: CGFloat? { get }
    var tintColor: UIColor { get }
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var backgroundColor: UIColor { get }
    var contentEdgeInsets: UIEdgeInsets { get }

    func build(of button: UIButton)

}
