//
//  Last25LiveTradesRequest.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

struct Last25LiveTradesRequest: ExampleRestApiSecretsRequestProtocol {
    let endpoint: String = "last_trades"
    let method: HTTPMethod = .get
    let headers: [String : String] = [:]
    let urlParameters: [URLQueryItem] = []
}
