//
//  SubscribeView.swift
//  BTC
//
//  Created by Tomasz Korab on 11/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit

class SubscribeView: UIView {

    // MARK: - Weak Properties
    weak var delegate: SubscribeViewDelegate?

    // MARK: - Private Properties
    private let buttonBuilder = BigGreenButtonBuilder(title: .subscribe)

    // MARK: - Lazy Properties
    private lazy var subscribeButton: UIButton = {
        let button = UIButton.builded(using: buttonBuilder)
        button.addTarget(self, action: #selector(buttonHasBeenSelected), for: .touchUpInside)
        button.accessibilityIdentifier = .subscibeButtonIdentifier
        return button
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
    @objc private func buttonHasBeenSelected() {
        delegate?.subscribeViewDidSelectSubscribe(self)
    }

    private func setup() {
        backgroundColor = .btcGray
        doLayout()
    }

    private func doLayout() {
        addSubview(subscribeButton)
        subscribeButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}

private extension String {
    static let subscribe = "subscribe.screen.subscribe.button.title"
    static let subscibeButtonIdentifier = "subscibe.button.identifier"
}
