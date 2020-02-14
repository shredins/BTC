//
//  Encodable+Extensions.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

extension Encodable {

    func jsonString(using encoder: JSONEncoderProtocol) -> String? {
        guard let data = try? encoder.encode(self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

}
