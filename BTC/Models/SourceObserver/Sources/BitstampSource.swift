//
//  BitstampSource.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

class BitstampSource: SourceProtocol {

    // MARK: - Properties
    let id: String = UUID().uuidString
    let websocketManager: LiveTradesWebsocketManagerProtocol

    // MARK: - Weak Properties
    weak var delegate: SourceDelegate? {
        didSet {
            // Listening will being only when observer will set delegate
            // It'll prevent source from receiving data until everything is set up
            observe()
        }
    }

    // MARK: - Inits
    init(liveTradesWebsocketManager: LiveTradesWebsocketManagerProtocol) {
        self.websocketManager = liveTradesWebsocketManager
    }

    // MARK: - Private Instance Methods
    private func observe() {
        websocketManager.listenLiveTrades { [weak self] result in
            guard let strongSelf = self else {
                return
            }

            switch result {
            case .success(let response):
                strongSelf.handleResponse(response)
            case .failure(let error):
                strongSelf.handleFailure(error)
            }
        }
    }

    private func handleResponse(_ response: TradeResponse) {
        delegate?.source(self, didProduce: response.data)
    }

    private func handleFailure(_ error: Error) {
        delegate?.sourceDidFail(self)
        delegate?.sourceDidFinish(self)
    }

}
