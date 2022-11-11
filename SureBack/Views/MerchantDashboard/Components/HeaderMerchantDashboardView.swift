//
//  HeaderMerchantDashboardView.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 10/11/22.
//

import UIKit

class HeaderMerchantDashboardView: UIView {
    private let businessStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Business Status"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let businessStatusCard: BussinesStatusCardView = {
        let card = BussinesStatusCardView()
        return card
    }()
    private let coinHistoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Coin History"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let seeAllCoinHistoryButton: UIButton = {
       let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let outstandingCoinCard: CoinHistoryCardView = {
       let card = CoinHistoryCardView()
        card.titleLabel.text = "Outstanding Coins"
        card.totalLabel.text = "500"
        return card
    }()
    let exchangedCoinCard: CoinHistoryCardView = {
       let card = CoinHistoryCardView()
        card.titleLabel.text = "Exchanged Coins"
        card.totalLabel.text = "200"
        return card
    }()
    private let customersLabel: UILabel = {
        let label = UILabel()
        label.text = "Customers"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let seeAllCustomersButton: UIButton = {
       let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupBussinesStatusLabel()
        setupBussinesStatusCard()
        setupCoinHistoryLabel()
        setupCoinHistoryCard()
        setupCustomersLabel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderMerchantDashboardView {
    private func setupBussinesStatusLabel() {
        addSubview(businessStatusLabel)
        businessStatusLabel.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        businessStatusLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        businessStatusLabel.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
    }
    private func setupBussinesStatusCard() {
        addSubview(businessStatusCard)
        businessStatusCard.setTopAnchorConstraint(equalTo: businessStatusLabel.bottomAnchor, constant: 20)
        businessStatusCard.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        businessStatusCard.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        businessStatusCard.setHeightAnchorConstraint(equalToConstant: 150)
        businessStatusCard.setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth)
    }
    private func setupCoinHistoryLabel() {
        let stackView = UIStackView(arrangedSubviews: [coinHistoryLabel, seeAllCoinHistoryButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: businessStatusCard.bottomAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
    }
    private func setupCoinHistoryCard() {
        let stackView = UIStackView(arrangedSubviews: [outstandingCoinCard, exchangedCoinCard])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: coinHistoryLabel.bottomAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
    }
    private func setupCustomersLabel() {
        let stackView = UIStackView(arrangedSubviews: [customersLabel, seeAllCustomersButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: outstandingCoinCard.bottomAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        stackView.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -20)
    }
}
