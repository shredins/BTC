//
//  AlertBuilder.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

class AlertBuilder {

    // MARK: - Properties
    private var alert: UIAlertController?

    // MARK: - Public Instance Methods
    func build() -> UIAlertController {
        guard let alert = alert else {
            fatalError("Trying to use variable before being initialized")
        }

        return alert
    }

    @discardableResult func styled(with style: AlertConfiguration) -> AlertBuilder {
        alert = UIAlertController(title: style.title.localized,
                                  message: style.description.localized,
                                  preferredStyle: .alert)
        alert?.view.tintColor = .btcGreen
        return self
    }

    @discardableResult func addAction(title: String,
                                      style: UIAlertAction.Style = .default,
                                      preferred: Bool = false,
                                      handler: (() -> Void)? = nil) -> AlertBuilder {

        let action = UIAlertAction(title: title.localized, style: style, handler: { _ in
            handler?()
        })

        alert?.addAction(action)

        if preferred {
            alert?.preferredAction = action
        }

        return self
    }

}
