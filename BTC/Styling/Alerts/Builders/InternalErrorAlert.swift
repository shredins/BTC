//
//  InternalErrorAlert.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

extension AlertBuilder {

    static func internalError() -> UIAlertController {
        let config = AlertConfiguration(title: .title, description: .description)
        return AlertBuilder()
            .styled(with: config)
            .addAction(title: .ok)
            .build()
    }

}

private extension String {
    static let title = "internal.error.alert.title"
    static let description = "internal.error.alert.description"
    static let ok = "internal.error.alert.ok"
}
