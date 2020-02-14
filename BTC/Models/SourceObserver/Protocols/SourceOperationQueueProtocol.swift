//
//  SourceOperationQueueProtocol.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

protocol SourceOperationQueueProtocol {

    var queue: DispatchQueue { get }
    var maxConcurrentOperationCount: Int { get set }

    func process(trade: Trade, delegate: LiveTradeOperationDelegate)

}
