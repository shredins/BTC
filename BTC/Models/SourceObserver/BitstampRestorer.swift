//
//  BitstampRestorer.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

class BitstampRestorer: SourceRestorerProtocol {

    // MARK: - Properties
    lazy var websocketManager: LiveTradesWebsocketManagerProtocol? = inject()

    // MARK: - Weak Properties
    weak var delegate: SourceRestorerDelegate?

    // MARK: - Public Instance Methods
    func restore() {
        guard let websocketManager = websocketManager else {
            assertionFailure("Trying to subscribe without initializing subscribeWSManager")
            return
        }

        websocketManager.subscribe { [weak self] result in
            guard let strongSelf = self else {
                return
            }

            switch result {
            case .success(let response) where response.event == .subscriptionSucceeded:
                let restoredSource = BitstampSource(liveTradesWebsocketManager: websocketManager)
                strongSelf.delegate?.bitstampRestorer(strongSelf, didRestore: restoredSource)
                strongSelf.websocketManager = nil
            default:
                strongSelf.delegate?.bitstampRestorerDidFailRestoring(strongSelf)
            }
        }
    }

}
