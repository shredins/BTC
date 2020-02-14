//
//  RequestProtocol.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    var secrets: SecretsProtocol { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var urlParameters: [URLQueryItem] { get }
}
