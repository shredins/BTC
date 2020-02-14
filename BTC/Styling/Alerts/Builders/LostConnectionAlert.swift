//
//  LostConnectionAlert.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

extension AlertBuilder {

    static func lostConnection() -> UIAlertController {
        let config = AlertConfiguration(title: .title, description: .description)
        return AlertBuilder()
            .styled(with: config)
            .addAction(title: .ok)
            .build()
    }

}

private extension String {
    static let title = "lost.connection.alert.title"
    static let description = "lost.connection.alert.description"
    static let ok = "lost.connection.alert.ok"
}
