//
//  WebsocketJSONDecoder.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

class WebsocketJSONDecoder: JSONDecoder {

    override init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
        dateDecodingStrategy = .custom { decoder -> Date in
            guard let stringValue = try? decoder.singleValueContainer().decode(String.self),
                  let doubleValue = Double(stringValue) else {
                    assertionFailure("Couldn't decode received timestamp")
                    return Date()
            }

            return Date(timeIntervalSince1970: doubleValue)
        }
    }

}
