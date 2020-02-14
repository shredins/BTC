//
//  JSONEncoderProtocol.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

protocol JSONEncoderProtocol {
    func encode<T>(_ value: T) throws -> Data where T : Encodable
}

extension JSONEncoder: JSONEncoderProtocol {}
