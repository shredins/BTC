//
//  RequestBuilder.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

struct RequestBuilder: RequestBuilderProtocol {

    // MARK: - Public Instance Methods
    func build(using input: RequestProtocol) -> URLRequest {
        let baseUrl = input.secrets.apiUrl.appendingPathComponent(input.endpoint)

        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)
        components?.queryItems = input.urlParameters

        guard let url = components?.url else {
            fatalError("Couldn't create URL from specified input")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = input.method.rawValue
        urlRequest.allHTTPHeaderFields = input.headers

        return urlRequest
    }

}
