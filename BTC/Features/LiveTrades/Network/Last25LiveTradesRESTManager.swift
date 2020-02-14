//
//  Last25LiveTradesRESTManagerProtocol.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

protocol Last25LiveTradesRESTManagerProtocol: class {
    func getLast25LiveTrades(_ completion: @escaping (Result<[Trade], Error>) -> Void)
}

// I didn't provide Unit tests for it since it's already mocked in application (requirements).
// It doesn't make sense to test not fully finished networkManager
class Last25LiveTradesRESTManager: RESTManager, Last25LiveTradesRESTManagerProtocol {

    func getLast25LiveTrades(_ completion: @escaping (Result<[Trade], Error>) -> Void) {
        let request = Last25LiveTradesRequest()
        call(input: request, completion)
    }

}
