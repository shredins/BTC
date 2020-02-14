//
//  RESTManagerProtocol.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

protocol RESTManagerProtocol {

    var session: URLSessionProtocol { get }
    var requestBuilder: RequestBuilderProtocol { get }

    func call<T: Decodable>(input: RequestProtocol, _ completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTaskProtocol?

}
