//
//  SourceRestorerDelegate.swift
//  BTC
//
//  Created by Tomasz Korab on 13/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

protocol SourceRestorerDelegate: class {
    func bitstampRestorerDidFailRestoring(_ restorer: BitstampRestorer)
    func bitstampRestorer(_ restorer: BitstampRestorer, didRestore source: SourceProtocol)
}
