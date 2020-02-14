//
//  SourceRestorerProtocol.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

protocol SourceRestorerProtocol {

    var delegate: SourceRestorerDelegate? { get set }

    func restore()

}
