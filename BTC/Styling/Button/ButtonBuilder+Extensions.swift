//
//  ButtonBuilder+Extensions.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit
import SnapKit

extension ButtonBuilder {

    func build(of button: UIButton) {
        button.localizedText = title
        button.titleLabel?.font = font
        button.tintColor = tintColor
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = borderColor.cgColor
        button.layer.cornerRadius = cornerRadius
        button.contentEdgeInsets = contentEdgeInsets
        button.backgroundColor = backgroundColor

        if let height = height {
            button.snp.makeConstraints {
                $0.height.equalTo(height)
            }
        }

        if let width = width {
            button.snp.makeConstraints {
                $0.width.equalTo(width)
            }
        }
    }

}
