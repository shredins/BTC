//
//  LiveTradesViewModelProtocol.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

protocol LiveTradesViewModelProtocol: LiveTradeOperationDelegate, EventAnalyzerDelegate, SourceObserverDelegate {

    var title: String { get }
    var analyzer: EventAnalyzerProtocol { get }
    var tradesStorage: TradesStorageProtocol { get }
    var sourceObserver: SourceObserverProtocol { get }
    var config: LiveTradesConfigurationProtocol { get }
    var delegate: LiveTradesViewModelDelegate? { get set }
    var uiDelegate: LiveTradesViewModelUIDelegate? { get set }

    func viewWillAppear()
    func set(tableView: UITableView)
    func set(websocketManager: LiveTradesWebsocketManagerProtocol)

}
