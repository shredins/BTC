//
//  MockRequest.swift
//  BTCTests
//
//  Created by Tomasz Korab on 14/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

@testable import BTC

struct MockRequest: RequestProtocol {
    let secrets: SecretsProtocol = MockSecrets()
    let endpoint: String = "/endpoint"
    let method: HTTPMethod = .get
    let headers: [String : String] = ["Header": "Value"]
    let urlParameters: [URLQueryItem] = [
        URLQueryItem(name: "param", value: "value")
    ]
}
