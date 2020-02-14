//
//  SubscribeViewControllerSpec.swift
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

class SubscribeViewControllerSpec: QuickSpec {

    override func spec() {

        describe("SubscribeViewController") {

            var sut: SubscribeViewController!
            var viewModel: ViewModel!
            var coordinator: Coordinator!

            beforeEach {
                coordinator = Coordinator()
                viewModel = ViewModel()
                DependencyInjection.container.register { coordinator as SubscribeCoordinatorProtocol }
                DependencyInjection.container.register { viewModel as SubscribeViewModelProtocol }
                sut = SubscribeViewController()
                sut.view.layoutIfNeeded()
            }

            it("Should have view equal to sut.subscribeView") {
                expect(sut.view).to(be(sut.subscribeView))
            }

            it("Should set viewModel as subscribeView's delegate") {
                expect(sut.subscribeView.delegate).to(be(sut.viewModel))
            }

            it("Should set sut as viewModel's delegate") {
                expect(sut.viewModel.delegate).to(be(sut))
            }

            it("Should set sut as coordinator's root") {
                expect(sut.coordinator.root).to(be(sut))
            }
        }
    }

}

private extension SubscribeViewControllerSpec {

    class Coordinator: SubscribeCoordinatorProtocol {

        // MARK: - Mock properties
        var didAskToPerformRoute: SubscribeRoute?

        // MARK: - Implementation
        var root: UIViewController?

        func perform(route: SubscribeRoute) {
            didAskToPerformRoute = route
        }

    }

    class ViewModel: SubscribeViewModelProtocol {

        // MARK: - Implementation
        weak var delegate: SubscribeViewModelDelegate?

        func subscribeViewDidSelectSubscribe(_ view: SubscribeView) {

        }

    }

}
