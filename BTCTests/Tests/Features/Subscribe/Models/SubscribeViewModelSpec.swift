//
//  SubscribeViewModelSpec.swift
//  BTCTests
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable
import BTC

class SubscribeViewModelSpec: QuickSpec {

    override func spec() {

        describe("SubscribeViewModel") {

            var sut: SubscribeViewModel!
            var delegate: Delegate!
            var manager: WebsocketManager!

            beforeEach {
                manager = WebsocketManager()
                delegate = Delegate()
                DependencyInjection.container.register { manager as LiveTradesWebsocketManagerProtocol }
                sut = SubscribeViewModel()
                sut.delegate = delegate
            }

            context("Should successfully subscribe") {

                beforeEach {
                    manager.shouldSucceed = true
                    sut.subscribeViewDidSelectSubscribe(SubscribeView())
                }

                it("Should perform route == .liveTrades") {
                    switch delegate.routeToPerform {
                    case .liveTrades:
                        expect(true).to(beTrue())
                    default:
                        fail()
                    }
                }

            }

            context("Should fail subscribing") {

                beforeEach {
                    manager.shouldSucceed = false
                    sut.subscribeViewDidSelectSubscribe(SubscribeView())
                }

                it("Should show alert informing about internal error") {
                    let alert = delegate.alertToShow
                    expect(alert?.title == "internal.error.alert.title".localized).to(beTrue())
                }

            }
        }
    }
}

private extension SubscribeViewModelSpec {

    class WebsocketManager: LiveTradesWebsocketManagerProtocol {

        // MARK: - Mock Properties
        var shouldSucceed = true
        var didCallDisconnect = false

        // MARK: - Implementation
        func subscribe(_ completion: @escaping (Result<WSSubscriptionAck, Error>) -> Void) {
            if shouldSucceed {
                let ack = WSSubscriptionAck(event: .subscriptionSucceeded, channel: .BTCtoUSD)
                completion(.success(ack))
            } else {
                let error = WebsocketManagerError.decoding
                completion(.failure(error))
            }
        }

        func disconnect(_ didDisconnect: WebsocketDisconnectCompletion?) {
            didCallDisconnect = true
        }

        func listenLiveTrades(_ completion: @escaping (Result<TradeResponse, Error>) -> Void) {}

    }

    class Delegate: SubscribeViewModelDelegate {

        // MARK: - Mock Properties
        var routeToPerform: SubscribeRoute?
        var alertToShow: UIAlertController?

        // MARK: - Implementation
        func subscribeViewModelProtocol(_ viewModel: SubscribeViewModelProtocol, didAskToPerform route: SubscribeRoute) {
            routeToPerform = route
        }

        func subscribeViewModelProtocol(_ viewModel: SubscribeViewModelProtocol, didAskToPresent alert: UIAlertController) {
            alertToShow = alert
        }

    }

}
