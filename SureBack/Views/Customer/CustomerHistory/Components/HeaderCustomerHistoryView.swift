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
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 50, height: 50))
        image.clipsToBounds = true
        return image
    }()

    lazy var loyaltCoinsValueLabel: UILabel = {
        let label = UILabel()
        label.text = "50"
        label.font = UIFont.systemFont(ofSize: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var loyaltCoinsLabel: UILabel = {
        let label = UILabel()
        label.text = "Coin(s)"
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var lockImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()

    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Status \nAvailable"
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var descStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("i", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setWidthAnchorConstraint(equalToConstant: 15)
        button.setHeightAnchorConstraint(equalToConstant: 15)
        return button
    }()

    lazy var redeemButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "Timer"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var redeemLabel: UILabel = {
        let label = UILabel()
        label.text = "Redeem Token"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderCustomerHistoryView {
    func setupHeaderView() {

        let stackLoyaltyCoins = UIStackView(arrangedSubviews: [loyaltCoinsValueLabel, loyaltCoinsLabel])
        stackLoyaltyCoins.axis = .vertical
        stackLoyaltyCoins.distribution = .fill
        stackLoyaltyCoins.alignment = .trailing
        stackLoyaltyCoins.translatesAutoresizingMaskIntoConstraints = false

        let stackImageCoins = UIStackView(arrangedSubviews: [profileImage, stackLoyaltyCoins])
        stackImageCoins.axis = .horizontal
        stackImageCoins.distribution = .equalSpacing
        stackImageCoins.translatesAutoresizingMaskIntoConstraints = false

        profileImage.setWidthAnchorConstraint(equalToConstant: 80)
        profileImage.setHeightAnchorConstraint(equalToConstant: 80)

        let stackRedeemButton = UIStackView(arrangedSubviews: [timerLabel, redeemLabel])
        stackRedeemButton.backgroundColor = .lightGray
        stackRedeemButton.axis = .vertical
        stackRedeemButton.distribution = .equalSpacing
        stackRedeemButton.alignment = .center
        stackRedeemButton.translatesAutoresizingMaskIntoConstraints = false

        let stackStatus = UIStackView(arrangedSubviews: [lockImage, statusLabel, descStatusButton])
        stackStatus.axis = .horizontal
        stackStatus.distribution = .equalSpacing
        stackStatus.spacing = 10
        stackStatus.translatesAutoresizingMaskIntoConstraints = false

        let stackStatusRedeem = UIStackView(arrangedSubviews: [stackStatus, stackRedeemButton])
        stackStatusRedeem.axis = .horizontal
        stackStatusRedeem.distribution = .equalSpacing
        stackStatusRedeem.spacing = 10
        stackStatusRedeem.alignment = .trailing
        stackStatusRedeem.translatesAutoresizingMaskIntoConstraints = false

        let stackViewAll = UIStackView(arrangedSubviews: [merchantLabel, stackImageCoins, stackStatusRedeem])
        stackViewAll.backgroundColor = .systemBlue
        stackViewAll.layer.cornerRadius = 10
        stackViewAll.axis = .vertical
        stackViewAll.distribution = .equalSpacing
        stackViewAll.spacing = 10
        stackViewAll.alignment = .leading
        stackViewAll.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackViewAll)
        stackViewAll.setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth - 40)
        stackViewAll.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        stackViewAll.setCenterXAnchorConstraint(equalTo: centerXAnchor)

        merchantLabel.setLeadingAnchorConstraint(equalTo: stackViewAll.leadingAnchor, constant: 10)
        stackLoyaltyCoins.setTrailingAnchorConstraint(equalTo: stackViewAll.trailingAnchor, constant: -10)

        stackStatus.setLeadingAnchorConstraint(equalTo: stackViewAll.leadingAnchor, constant: 150)
        stackStatus.setTrailingAnchorConstraint(equalTo: stackRedeemButton.leadingAnchor, constant: -20)
        stackStatus.setBottomAnchorConstraint(equalTo: stackViewAll.bottomAnchor, constant: -20)

        stackRedeemButton.setTrailingAnchorConstraint(equalTo: stackViewAll.trailingAnchor, constant: -10)
        stackRedeemButton.setBottomAnchorConstraint(equalTo: stackViewAll.bottomAnchor, constant: -10)

        stackStatusRedeem.setBottomAnchorConstraint(equalTo: stackViewAll.bottomAnchor, constant: -10)
    }
}
