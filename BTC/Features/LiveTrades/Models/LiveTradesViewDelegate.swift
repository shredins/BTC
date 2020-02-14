//
//  LiveTradesViewDelegate.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

protocol LiveTradesViewModelDelegate: class {
    func liveTradesViewModel(_ viewModel: LiveTradesViewModelProtocol, didChange title: String)
    func liveTradesViewModel(_ viewModel: LiveTradesViewModelProtocol, didAskToPresent alert: UIAlertController)
}
