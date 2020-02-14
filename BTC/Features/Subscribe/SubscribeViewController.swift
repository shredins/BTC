//
//  SubscribeViewController.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

class SubscribeViewController: UIViewController {

    // MARK: - Lazy Properties
    lazy var coordinator: SubscribeCoordinatorProtocol = {
        let coordinator: SubscribeCoordinatorProtocol = inject()
        coordinator.root = self
        return coordinator
    }()

    lazy var viewModel: SubscribeViewModelProtocol = {
        let viewModel: SubscribeViewModelProtocol = inject()
        viewModel.delegate = self
        return viewModel
    }()

    lazy var subscribeView: SubscribeView = {
        let view = SubscribeView()
        view.delegate = viewModel
        return view
    }()

    // MARK: - Life Cycle Methods
    override func loadView() {
        view = subscribeView
    }

}

// MARK: - SubscribeViewModelDelegate Methods
extension SubscribeViewController: SubscribeViewModelDelegate {

    func subscribeViewModelProtocol(_ viewModel: SubscribeViewModelProtocol, didAskToPerform route: SubscribeRoute) {
        coordinator.perform(route: route)
    }

    func subscribeViewModelProtocol(_ viewModel: SubscribeViewModelProtocol, didAskToPresent alert: UIAlertController) {
        present(alert, animated: true)
    }

}
