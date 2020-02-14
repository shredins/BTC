//
//  SourceObserverProtocol.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

protocol SourceObserverProtocol: SourceDelegate {

    var sources: [SourceProtocol] { get set }
    var queue: SourceOperationQueueProtocol { get }
    var delegate: SourceObserverDelegate? { get set }
    var operationDelegate: LiveTradeOperationDelegate? { get set }

    func add(source: SourceProtocol)

}
