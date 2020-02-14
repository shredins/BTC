//
//  DependencyInjection.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import Dip
import FDTTableViewManager

class DependencyInjection {

    // MARK: - Static Properties
    static var container = DependencyContainer { container in
        registerDefinitions(on: container)
    }

    // MARK: - Private Static Functions
    private static func registerDefinitions(on container: DependencyContainer) {
        container.register { WebsocketJSONDecoder() as JSONDecoderProtocol }
        container.register { JSONEncoder() as JSONEncoderProtocol }
        container.register { SubscribeViewModel() as SubscribeViewModelProtocol }
        container.register { SubscribeCoordinator() as SubscribeCoordinatorProtocol }
        container.register { LiveTradesWebsocketManager() as LiveTradesWebsocketManagerProtocol }
        container.register { WebsocketAdapter.self as WebSocketProtocol.Type }
        container.register { LiveTradesViewModel() as LiveTradesViewModelProtocol }
        container.register { TableViewManager() as TableViewManager }
        container.register { SourceObserver() as SourceObserverProtocol }
        container.register { SourceOperationQueue() as SourceOperationQueueProtocol }
        container.register { RequestBuilder() as RequestBuilderProtocol }
        // Mocked session which will be used in loading last 25 live trades
        container.register { MockURLSession() as URLSessionProtocol }
        container.register { EventAnalyzer() as EventAnalyzerProtocol }
        container.register { Last25LiveTradesRESTManager() as Last25LiveTradesRESTManagerProtocol}
        container.register { BTCConfiguration() as BTCConfigurationProtocol }
        container.register { BTCConfiguration() as RESTSourceConfigurationProtocol }
        container.register { BTCConfiguration() as LiveTradesConfigurationProtocol }
        container.register { TradesStorage() as TradesStorageProtocol }
        container.register { BitstampRestorer() as SourceRestorerProtocol }
        container.register { Date.formatter as DateFormatter }
    }

}
