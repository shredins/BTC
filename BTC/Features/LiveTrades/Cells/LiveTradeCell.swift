//
//  LiveTradeCell.swift
//  BTC
//
//  Created by Tomasz Korab on 12/02/2020.
//  Copyright © 2020 Tomasz Korab. All rights reserved.
//

import UIKit
import SnapKit

class LiveTradeCell: UITableViewCell {

    // MARK: - Properties
    let dateLabel = HeaderLabel()
    let priceLabel = ValueLabel()
    let sentimentLabel = SentimentLabel()

    // MARK: - Lazy Properties
    private lazy var sentimentContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .sentimentContainerCornerRadius
        return view
    }()

    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .btcWhite
        container.layer.cornerRadius = .containerCornerRadius
        DropShadowBuilder().set(to: container)
        return container
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, priceLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = .stackViewSpacing
        return stackView
    }()

    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        container.layer.shadowPath = UIBezierPath(roundedRect: container.bounds,
                                                  cornerRadius: container.layer.cornerRadius).cgPath
    }

    // MARK: - Public Instance Methods
    func showSentiment(with text: String, backgroundColor: UIColor) {
        sentimentContainer.backgroundColor = backgroundColor
        sentimentLabel.text = text
        sentimentContainer.isHidden = false
    }

    func hideSentiment() {
        sentimentContainer.isHidden = true
    }

    func animateScrollingBottom() {
        transform = .fromTop
        UIView.animate(withDuration: .animationDuration) {
            self.transform = .zero
        }
    }

    func animateScrollingTop() {
        transform = .fromBottom
        UIView.animate(withDuration: .animationDuration) {
            self.transform = .zero
        }
    }

    // MARK: - Private Instance Methods
    private func setup() {
        selectionStyle = .none
        backgroundColor = .btcGray
        doLayout()
    }

    private func doLayout() {
        addSubview(container)
        container.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets.container)
        }

        container.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets.stackView)
        }

        container.addSubview(sentimentContainer)
        sentimentContainer.snp.makeConstraints {
            $0.trailing.equalTo(CGFloat.sentimentContainerTrailing)
            $0.centerY.equalToSuperview()
        }

        sentimentContainer.addSubview(sentimentLabel)
        sentimentLabel.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets.sentimentLabel)
        }
    }

}

private extension UIEdgeInsets {
    static let stackView = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
    static let container = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
    static let sentimentLabel = UIEdgeInsets(top: 13, left: 12, bottom: 13, right: 12)
}

private extension CGFloat {
    static let stackViewSpacing: Self = 2
    static let containerCornerRadius: Self = 20
    static let sentimentContainerTrailing: Self = -8
    static let sentimentContainerCornerRadius: Self = 15
}

private extension TimeInterval {
    static let animationDuration = 0.3
}

private extension CGAffineTransform {
    static let zero = CGAffineTransform(translationX: 0, y: 0)
    static let fromTop = CGAffineTransform(translationX: 0, y: 30)
    static let fromBottom = CGAffineTransform(translationX: 0, y: -30)
}
