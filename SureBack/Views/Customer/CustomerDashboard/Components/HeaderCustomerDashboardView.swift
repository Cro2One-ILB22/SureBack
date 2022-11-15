//
//  HeaderCustomerDashboardView.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 12/11/22.
//

import UIKit

class HeaderCustomerDashboardView: UIView {
    let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi, @bestie"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let levelButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Nano ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let totalCoinsLabel: UILabel = {
        let label = UILabel()
        label.text = " 58000 "
        label.font = UIFont.systemFont(ofSize: 17)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let loyaltyCoinsLabel: UILabel = {
        let label = UILabel()
        label.text = " Loyalty Coins"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let tokenLabel: UILabel = {
        let label = UILabel()
        label.text = "Token"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let activeTokenCard: ActiveTokenCardView = {
        let card = ActiveTokenCardView()
        return card
    }()

    private let merchantLabel: UILabel = {
        let label = UILabel()
        label.text = "Merchant"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let seeAllMerchantButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(count: Int, activeTokenData: [GenerateTokenOnlineResponse], frame: CGRect) {
        super.init(frame: frame)
        setupProfileLabel()
        setupProfile2Label()
        if count > 0 {
            setupToken()
            setupMerchantLabel()

            activeTokenCard.tokenMerchantNameLabel.text = activeTokenData[0].merchant.name
        } else {
            deactiveToken()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderCustomerDashboardView {
    private func setupProfileLabel() {
        addSubview(profileLabel)
        profileLabel.setTopAnchorConstraint(equalTo: topAnchor)
        profileLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
    }

    private func setupProfile2Label() {
        let stackView = UIStackView(arrangedSubviews: [levelButton, totalCoinsLabel, loyaltyCoinsLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: profileLabel.bottomAnchor, constant: 5)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
    }

    private func setupToken() {
        addSubview(tokenLabel)
        tokenLabel.setTopAnchorConstraint(equalTo: levelButton.bottomAnchor, constant: 20)
        tokenLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        tokenLabel.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        addSubview(activeTokenCard)
        activeTokenCard.setTopAnchorConstraint(equalTo: tokenLabel.bottomAnchor, constant: 20)
        activeTokenCard.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        activeTokenCard.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        activeTokenCard.setHeightAnchorConstraint(equalToConstant: 150)
    }

    private func setupMerchantLabel() {
        let stackView = UIStackView(arrangedSubviews: [merchantLabel, seeAllMerchantButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: activeTokenCard.bottomAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        stackView.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -20)
    }

    private func deactiveToken() {
        let stackView = UIStackView(arrangedSubviews: [merchantLabel, seeAllMerchantButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: loyaltyCoinsLabel.bottomAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        stackView.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -20)
    }
}
