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
        label.text = " 58000 Loyalty Coins "
        label.font = UIFont.systemFont(ofSize: 17)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProfileLabel()
        setupProfile2Label()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderCustomerDashboardView {
    private func setupProfileLabel() {
        addSubview(profileLabel)
        profileLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
    }

    private func setupProfile2Label() {
        let stackView = UIStackView(arrangedSubviews: [levelButton, totalCoinsLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: profileLabel.bottomAnchor, constant: 5)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
    }

    private func setupMerchantLabel() {
        let stackView = UIStackView(arrangedSubviews: [merchantLabel, seeAllMerchantButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        stackView.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -10)
    }

    private func deactiveToken() {
        let stackView = UIStackView(arrangedSubviews: [merchantLabel, seeAllMerchantButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: levelButton.bottomAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        stackView.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -20)
    }
}
