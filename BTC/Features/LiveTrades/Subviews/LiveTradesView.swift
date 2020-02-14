//
//  LiveTradesView.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit
import SnapKit

class LiveTradesView: UIView {

    // MARK: - Properties
    let indicator = UIActivityIndicatorView(style: .gray)

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .btcGray
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    // MARK: - Inits
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Instance Methods
    private func setup() {
        backgroundColor = .btcGray
        doLayout()
    }

    private func doLayout() {
        addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

// MARK: - LiveTradesViewModelUIDelegate Methods
extension LiveTradesView: LiveTradesViewModelUIDelegate {

    func liveTradesViewModel(_ viewModel: LiveTradesViewModelProtocol, askToHideIndicator indicatorIsHidden: Bool) {
        tableView.isHidden = !indicatorIsHidden
        indicatorIsHidden ? indicator.stopAnimating() : indicator.startAnimating()
    }

}
