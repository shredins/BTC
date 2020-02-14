//
//  SubscribeCoordinator.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

class SubscribeCoordinator: SubscribeCoordinatorProtocol {

    // MARK: - Weak Properties
    weak var root: UIViewController?

    // MARK: - Public Instance Methods
    func perform(route: SubscribeRoute) {
        switch route {
        case .liveTrades(let manager):
            openLiveTradesScreen(websocketManager: manager)
        }
    }

    // MARK: - Private Instance Methods
    private func openLiveTradesScreen(websocketManager: LiveTradesWebsocketManagerProtocol) {
        let controller = LiveTradesViewController(websocketManager: websocketManager)

        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .overFullScreen

        root?.present(navigationController, animated: false)
    }

}
