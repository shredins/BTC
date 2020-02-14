//
//  SourceOperationQueue.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

// MARK: - FIFO type queue
class SourceOperationQueue: OperationQueue, SourceOperationQueueProtocol {

    // MARK: - Properties
    let queue: DispatchQueue

    // MARK: - Private Properties
    private var lastAddedOperation: BaseOperation?

    // MARK: - Computed Properties
    /// Ensures that no-one will break behaviour of queue
    /// It requires to perform only one operations at once
    override var maxConcurrentOperationCount: Int {
        get {
            .maxConcurrentOperations
        }
        set {
            super.maxConcurrentOperationCount = .maxConcurrentOperations
        }
    }

    // MARK: - Inits
    init(queue: DispatchQueue = DispatchQueue(label: .queueName, qos: .userInteractive)) {
        self.queue = queue
        super.init()
        underlyingQueue = queue
    }

    // MARK: - Public Instance Methods
    func process(trade: Trade, delegate: LiveTradeOperationDelegate) {
        let newOperation = LiveTradeOperation(trade: trade, delegate: delegate)

        if let lastAddedOperation = lastAddedOperation {
            /// Ensures that all trades will be added in correct order
            newOperation.addDependency(lastAddedOperation)
        }

        addOperation(newOperation)

        lastAddedOperation = newOperation
    }

}

private extension Int {
    static let maxConcurrentOperations = 1
}

private extension String {
    static let queueName = "SourceOperationQueue"
}
