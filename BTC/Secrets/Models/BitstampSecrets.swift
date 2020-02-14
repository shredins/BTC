//
//  BitstampSecrets.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation
import Keys

struct BitstampSecrets: SecretsProtocol {

    // MARK: - Private Properties
    private let storage = BTCKeys()

    // MARK: - Get-only Properties
    var apiUrl: URL {
        guard let url = URL(string: storage.websocketPath) else {
            fatalError("Used before being initialized")
        }

        return url
    }

}
