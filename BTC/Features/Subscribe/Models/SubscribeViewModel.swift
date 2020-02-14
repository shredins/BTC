//
//  SubscribeViewModel.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

class SubscribeViewModel: SubscribeViewModelProtocol {

    // MARK: - Weak Properties
    weak var delegate: SubscribeViewModelDelegate?

    // MARK: - Lazy Properties
    lazy var subscribeWSManager: LiveTradesWebsocketManagerProtocol? = inject()

    // MARK: - Public Instance Methods
    func handleSuccess(_ response: WSSubscriptionAck) {
        guard let subscribeWSManager = subscribeWSManager else {
            assertionFailure("Used before being intialized")
            return
        }

        let route: SubscribeRoute = .liveTrades(websocketManager: subscribeWSManager)
        delegate?.subscribeViewModelProtocol(self, didAskToPerform: route)
        self.subscribeWSManager = nil
    }

    func handleFailure(_ error: Error) {
        let alert: UIAlertController

        switch error {
        case let wsError as WebsocketManagerError where wsError == .disconnected:
            alert = AlertBuilder.lostConnection()
        default:
            alert = AlertBuilder.internalError()
        }

        delegate?.subscribeViewModelProtocol(self, didAskToPresent: alert)
    }

}

// MARK: - SubscribeViewDelegate Methods
extension SubscribeViewModel: SubscribeViewDelegate {

    func subscribeViewDidSelectSubscribe(_ view: SubscribeView) {
        guard let subscribeWSManager = subscribeWSManager else {
            assertionFailure("Trying to subscribe without initializing subscribeWSManager")
            return
        }

        subscribeWSManager.subscribe { [weak self] result in
            guard let strongSelf = self else {
                return
            }

            switch result {
            case .success(let response):
                strongSelf.handleSuccess(response)
            case .failure(let error):
                strongSelf.handleFailure(error)
            }
        }
    }

}
