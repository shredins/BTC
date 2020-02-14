//
//  SubscribeCoordinatorSpec.swift
//  BTCTests
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import XCTest
import Quick
import Nimble
import FDTTableViewManager

@testable
import BTC

class SubscribeCoordinatorSpec: QuickSpec {

    override func spec() {

        describe("SubscribeCoordinator") {

            var sut: SubscribeCoordinator!
            var root: MockController!

            beforeEach {
                root = MockController()
                sut = SubscribeCoordinator()
                sut.root = root
            }

            it("Should ask to present UINavigationController when perform called") {
                let route: SubscribeRoute = .liveTrades(websocketManager: MockWebsocketManager())

                DependencyInjection.container.register { DispatchQueue.main as DispatchQueue }
                DependencyInjection.container.register { TradesStorage() as TradesStorageProtocol}
                DependencyInjection.container.register { BTCConfiguration() as LiveTradesConfigurationProtocol }
                DependencyInjection.container.register { LiveTradesViewModel() as LiveTradesViewModelProtocol }
                DependencyInjection.container.register { TableViewManager() as TableViewManager }
                DependencyInjection.container.register { SourceObserver() as SourceObserverProtocol}
                DependencyInjection.container.register { SourceOperationQueue() as SourceOperationQueueProtocol }

                sut.perform(route: route)
                expect(root.didAskToPresentController).to(beAKindOf(UINavigationController.self))
            }

        }
    }
}

private extension SubscribeCoordinatorSpec {

    class MockController: UIViewController {

        var didAskToPresentController: UIViewController?
        override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
            didAskToPresentController = viewControllerToPresent
        }

    }

    class MockWebsocketManager: LiveTradesWebsocketManagerProtocol {
        func listenLiveTrades(_ completion: @escaping (Result<TradeResponse, Error>) -> Void) {}
        func subscribe(_ completion: @escaping (Result<WSSubscriptionAck, Error>) -> Void) {}
        func disconnect(_ didDisconnect: WebsocketDisconnectCompletion?) {}
    }

}
