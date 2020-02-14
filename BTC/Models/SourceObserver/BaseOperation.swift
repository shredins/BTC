//
//  BaseOperation.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

class BaseOperation: Operation {

    // MARK: - Private Properties
    private var state: State = .ready
    private var queue: DispatchQueue

    // MARK: - Overridden Properties
    final override var isExecuting: Bool {
        threadSafeState == .executing
    }

    final override var isFinished: Bool {
        threadSafeState == .finished
    }

    final override var isReady: Bool {
        threadSafeState == .ready && super.isReady
    }

    // MARK: - Computed Property
    @objc dynamic private var threadSafeState: State {
        get {
            // Won't read it until ongoing reads finish
            queue.sync {
                state
            }
        }
        set {
            // Barrier ensures that only its block will be executed on queue
            queue.async(flags: .barrier) { [weak self] in
                if let strongSelf = self {
                    strongSelf.state = newValue
                }
            }
        }
    }

    // MARK: - Inits
    init(queue: DispatchQueue = DispatchQueue(label: .queueName, attributes: .concurrent)) {
        self.queue = queue
    }

    // MARK: - Overridden Instance Methods
    override func start() {
        guard !isCancelled else {
            threadSafeState = .finished
            return
        }

        threadSafeState = .executing

        main()
    }

    /// Remember that you need to handle state when operation finishes
    override func main() {
        fatalError("Using before being implemented")
    }

    /// Tell that threadSafeState is responsible for changes in overridden properties
    override class func keyPathsForValuesAffectingValue(forKey key: String) -> Set<String> {
        if String.keys.contains(key) {
            return [#keyPath(threadSafeState)]
        }
        return super.keyPathsForValuesAffectingValue(forKey: key)
    }

    // MARK: - Public Instance Methods
    func finish() {
        if threadSafeState != .finished {
            threadSafeState = .finished
        }
    }

}

private extension BaseOperation {

    @objc enum State: Int {

        case ready
        case executing
        case finished

        var description: String {
            switch self {
            case .ready:
                return "Ready"
            case .executing:
                return "Executing"
            case .finished:
                return "Finished"
            }
        }

    }

}

private extension String {
    static let queueName = "Thread Safe Queue"
    static let keys = ["isExecuting", "isFinished", "isReady"]
}
