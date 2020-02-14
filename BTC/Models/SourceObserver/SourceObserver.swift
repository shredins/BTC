//
//  SourceObserver.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

class SourceObserver: SourceObserverProtocol {

    // MARK: - Properties
    var sources: [SourceProtocol] = []
    let queue: SourceOperationQueueProtocol = inject()

    // MARK: - Weak Properties
    weak var delegate: SourceObserverDelegate?
    weak var operationDelegate: LiveTradeOperationDelegate?

    // MARK: - Public Instance Methods
    func add(source: SourceProtocol) {
        sources.append(source)
        source.delegate = self
    }

}

// MARK: - SourceDelegate Methods
extension SourceObserver: SourceDelegate {

    func sourceDidFail(_ source: SourceProtocol) {
        delegate?.sourceObserver(self, didDetectSourceFailure: source)
    }

    func sourceDidFinish(_ source: SourceProtocol) {
        sources.removeAll(where: { $0.id == source.id })
    }

    func source(_ source: SourceProtocol, didProduce trade: Trade) {
        guard let operationDelegate = operationDelegate else {
            assertionFailure("Result of operation won't be passed to viewModel")
            return
        }
        queue.process(trade: trade, delegate: operationDelegate)
    }

}
