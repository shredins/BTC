//
//  URLSessionProtocol.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

typealias URLSessionCompletion = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completion: @escaping URLSessionCompletion) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {

    func dataTask(with request: URLRequest, completion: @escaping URLSessionCompletion) -> URLSessionDataTaskProtocol {
        dataTask(with: request, completionHandler: completion)
    }

}
