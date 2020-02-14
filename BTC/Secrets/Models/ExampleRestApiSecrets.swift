//
//  ExampleRestApiSecrets.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation
import Keys

// This is just an example file of how implementation of it would look like
// Such secrets are provided in subprotocols on RequestProtocol e.g. ExampleRestApiSecretsRequestProtocol
struct ExampleRestApiSecrets: SecretsProtocol {

    // MARK: - Private Properties
    private let storage = BTCKeys()

    // MARK: - Get-only Properties
    var apiUrl: URL {
        guard let url = URL(string: storage.exampleRestApiPath) else {
            fatalError("Used before being initialized")
        }

        return url
    }

}
