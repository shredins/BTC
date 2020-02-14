//
//  SubscribeViewModelDelegate.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

protocol SubscribeViewModelDelegate: class {
    func subscribeViewModelProtocol(_ viewModel: SubscribeViewModelProtocol, didAskToPerform route: SubscribeRoute)
    func subscribeViewModelProtocol(_ viewModel: SubscribeViewModelProtocol, didAskToPresent alert: UIAlertController)
}
