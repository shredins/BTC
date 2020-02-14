//
//  LiveTradesViewController.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit
import FDTTableViewManager

class LiveTradesViewController: UIViewController {

    // MARK: - Properties
    let liveTradesView = LiveTradesView()

    // MARK: - Lazy Properties
    lazy var viewModel: LiveTradesViewModelProtocol = {
        let viewModel: LiveTradesViewModelProtocol = inject()
        viewModel.set(tableView: liveTradesView.tableView)
        viewModel.delegate = self
        viewModel.uiDelegate = liveTradesView
        return viewModel
    }()

    // MARK: - Inits
    init(websocketManager: LiveTradesWebsocketManagerProtocol) {
        super.init(nibName: nil, bundle: nil)
        viewModel.set(websocketManager: websocketManager)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle Methods
    override func loadView() {
        view = liveTradesView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        viewModel.viewWillAppear()
    }

    // MARK: - Private Instance Methods
    private func setupNavigationBar() {
        navigationItem.localizedText = viewModel.title
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

// MARK: - LiveTradesViewModelDelegate Methods
extension LiveTradesViewController: LiveTradesViewModelDelegate {

    func liveTradesViewModel(_ viewModel: LiveTradesViewModelProtocol, didAskToPresent alert: UIAlertController) {
        present(alert, animated: true)
    }

    func liveTradesViewModel(_ viewModel: LiveTradesViewModelProtocol, didChange title: String) {
        navigationItem.localizedText = title
    }

}
