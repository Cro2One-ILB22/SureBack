//
//  HeaderCustomerHistoryView.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 13/11/22.
//

import UIKit

class HeaderCustomerHistoryView: UIView {
    lazy var merchantLabel: UILabel = {
        let label = UILabel()
        label.text = "Merchant Name"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var loyaltCoinsLabel: UILabel = {
        let label = UILabel()
        label.text = "50 Loyalty Coins"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var redeemButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var timerLabel: UIView = {
        let label = UILabel()
        label.text = "Timer"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var redeemLabel: UIView = {
        let label = UILabel()
        label.text = "Redeem Token"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
        addSubview(redeemButton)
        redeemButton.setWidthAnchorConstraint(equalToConstant: 150)
        redeemButton.setCenterXAnchorConstraint(equalTo: centerXAnchor)
        redeemButton.setTopAnchorConstraint(equalTo: locationLabel.bottomAnchor, constant: 5)
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLabel() {
        let stackView = UIStackView(arrangedSubviews: [merchantLabel, loyaltCoinsLabel, locationLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 25)
    }

    func setupButton() {
        let stackView = UIStackView(arrangedSubviews: [timerLabel, redeemLabel])
        stackView.backgroundColor = .systemBlue
        stackView.layer.cornerRadius = 10
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        redeemButton.addSubview(stackView)
        stackView.setWidthAnchorConstraint(equalToConstant: 150)
        stackView.setCenterXAnchorConstraint(equalTo: centerXAnchor)
        stackView.setTopAnchorConstraint(equalTo: locationLabel.bottomAnchor, constant: 5)
    }
}
