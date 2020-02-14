//
//  RestorerFactory.swift
//  BTC
//
//  Created by Tomasz Korab on 13/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

struct RestorerFactory {

    // MARK: - Inits
    private init() {}

    // MARK: - Static Functions
    static func restorer(for source: SourceProtocol) -> SourceRestorerProtocol? {
        switch source {
        case is BitstampSource:
            return BitstampRestorer()
        default:
            return nil
        }
    }

}
