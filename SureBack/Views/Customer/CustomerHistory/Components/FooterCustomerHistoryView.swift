//
//  FooterCustomerHistoryView.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 13/11/22.
//

import UIKit

class FooterCustomerHistoryView: UIView {
    lazy var totalRedeemLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Rewards\nRedeem"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "17000 Coins"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLabel() {
        let stackView = UIStackView(arrangedSubviews: [totalRedeemLabel, totalLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        totalLabel.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 5)
//        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 10)
//        stackView.setCenterYAnchorConstraint(equalTo: centerYAnchor)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
    }
}
