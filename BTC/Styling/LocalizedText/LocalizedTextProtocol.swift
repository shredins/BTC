//
//  LocalizedTextProtocol.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

// MARK: - Definition
protocol LocalizedTextProtocol {
    var localizedText: String { get set }
}

// MARK: - Default Implementations
extension UIButton {

    var localizedText: String {
        get {
            currentTitle ?? ""
        }
        set {
            setTitle(newValue.localized, for: .normal)
        }
    }

}

extension UILabel {

    var localizedText: String {
        get {
            text ?? ""
        }
        set {
            text = newValue.localized
        }
    }

}

extension UINavigationItem {

    var localizedText: String {
        get {
            title ?? ""
        }
        set {
            title = newValue.localized
        }
    }

}
