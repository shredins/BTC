//
//  RESTSource.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

// This source doesn't call didFail(source:) beucase it's not main source.
// It's just triggered from time to time depending on the configuration's frequency
// Unit tests for this source are not provided since it's already mocked
class RESTSource: SourceProtocol {

    // MARK: - Properties
    let id: String = UUID().uuidString
    let config: RESTSourceConfigurationProtocol = inject()
    let restManager: Last25LiveTradesRESTManagerProtocol = inject()

    // MARK: - Weak Properties
    weak var delegate: SourceDelegate? {
        didSet {
            // Listening will being only when observer will set delegate
            // It'll prevent source from receiving data until everything is set up
            observe()
        }
    }

    // MARK: - Private Instance Methods
    private func observe() {
        restManager.getLast25LiveTrades { [weak self] result in
            guard let strongSelf = self else {
                return
            }

            switch result {
            case .success(let trades):
                strongSelf.handleResponse(trades)
            case .failure(let error):
                strongSelf.handleFailure(error)
            }
        }
    }

    private func handleResponse(_ trades: [Trade]) {
        let maxCount = min(trades.count, config.numberOfTradesFromREST)
        trades[0..<maxCount]
            .sorted(by: { $0.timestamp < $1.timestamp })
            .forEach {
                delegate?.source(self, didProduce: $0)
            }
        delegate?.sourceDidFinish(self)
    }

    private func handleFailure(_ error: Error) {
        // TODO: -
        delegate?.sourceDidFinish(self)
    }

}
