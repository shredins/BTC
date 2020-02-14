//
//  RestoreSourceAlert.swift
//  BTC
//
//  Created by Tomasz Korab on 13/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

extension AlertBuilder {

    static func restoreSource(_ restore: @escaping () -> Void) -> UIAlertController {
        let config = AlertConfiguration(title: .title, description: .description)
        return AlertBuilder()
            .styled(with: config)
            .addAction(title: .no)
            .addAction(title: .yes, preferred: true, handler: restore)
            .build()
    }

}

private extension String {
    static let title = "restore.source.title"
    static let description = "restore.source.description"
    static let yes = "restore.source.yes"
    static let no = "restore.source.no"
}
