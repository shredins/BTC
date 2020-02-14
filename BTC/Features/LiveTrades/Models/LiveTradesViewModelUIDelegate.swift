//
//  LiveTradesViewModelUIDelegate.swift
//  BTC
//
//  Created by Tomasz Korab on 14/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Foundation

protocol LiveTradesViewModelUIDelegate: class {
    func liveTradesViewModel(_ viewModel: LiveTradesViewModelProtocol, askToHideIndicator indicatorIsHidden: Bool)
}
