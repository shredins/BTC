//
//  SourceDelegate.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

protocol SourceDelegate: class {
    func sourceDidFail(_ source: SourceProtocol)
    func sourceDidFinish(_ source: SourceProtocol)
    func source(_ source: SourceProtocol, didProduce trade: Trade)
}
