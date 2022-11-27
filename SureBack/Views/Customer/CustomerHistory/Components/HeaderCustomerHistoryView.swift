//
//  HeaderCustomerHistoryView.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 13/11/22.
//

import UIKit

class HeaderCustomerHistoryView: UIView {

    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg.card.history")?.withRenderingMode(.alwaysOriginal)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: UIScreen.screenWidth - 40).isActive = true
        return imageView
    }()

    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
        image.image = UIImage(named: "AppIcon")
        image.clipsToBounds = true
        image.setWidthAnchorConstraint(equalToConstant: 50)
        image.setHeightAnchorConstraint(equalToConstant: 50)
        return image
    }()

    lazy var bgProfileImageView: UIView = {
        let view = UIView()
//        view.backgroundColor = .green
//        view.setWidthAnchorConstraint(equalToConstant: 70)
        return view
    }()

    lazy var coinImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loyalty.coin")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 13
        image.setWidthAnchorConstraint(equalToConstant: 20)
        image.setHeightAnchorConstraint(equalToConstant: 20)
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
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.setWidthAnchorConstraint(equalToConstant: 30)
        image.setHeightAnchorConstraint(equalToConstant: 30)
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

    var stackRedeemButton = UIStackView()

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
    private func setupHeaderView() {
        // Stack 1
        let stackProfile = UIStackView(arrangedSubviews: [userNameLabel, merchantLabel])
        stackProfile.axis = .vertical
        stackProfile.distribution = .equalSpacing
        stackProfile.translatesAutoresizingMaskIntoConstraints = false

        // Stack 2
        bgProfileImageView.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false

        let stackCoinsLabel = UIStackView(arrangedSubviews: [loyaltCoinsLabel, coinImage])
        stackCoinsLabel.axis = .horizontal
        stackCoinsLabel.distribution = .equalSpacing
        stackCoinsLabel.spacing = 5
        stackCoinsLabel.translatesAutoresizingMaskIntoConstraints = false

        let stackCoins = UIStackView(arrangedSubviews: [loyaltCoinsValueLabel, stackCoinsLabel])
        stackCoins.axis = .vertical
        stackCoins.distribution = .equalSpacing
        stackCoins.spacing = 5
        stackCoins.translatesAutoresizingMaskIntoConstraints = false

        let stackImageCoins = UIStackView(arrangedSubviews: [bgProfileImageView, stackCoins])
        stackImageCoins.axis = .horizontal
        stackImageCoins.translatesAutoresizingMaskIntoConstraints = false

        // Stack 3
        let stackStatus = UIStackView(arrangedSubviews: [lockImage, statusLabel])
        stackStatus.axis = .horizontal
        stackStatus.spacing = 5
        stackStatus.distribution = .equalSpacing
        stackStatus.translatesAutoresizingMaskIntoConstraints = false

        stackRedeemButton = UIStackView(arrangedSubviews: [timerLabel, redeemLabel])
        stackRedeemButton.backgroundColor = .lightGray
        stackRedeemButton.axis = .vertical
        stackRedeemButton.distribution = .fill
        stackRedeemButton.alignment = .center
        stackRedeemButton.translatesAutoresizingMaskIntoConstraints = false

        let stackStatusRedeem = UIStackView(arrangedSubviews: [stackStatus, stackRedeemButton])
        stackStatusRedeem.axis = .horizontal
        stackStatusRedeem.distribution = .equalSpacing
        stackStatusRedeem.alignment = .center
        stackStatusRedeem.translatesAutoresizingMaskIntoConstraints = false

        let contentView = UIView()
        contentView.backgroundColor = .systemBlue
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth - 40)
        contentView.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        contentView.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -10)
        contentView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 10)
        contentView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -10)


        // Stack All
        let stackViewAll = UIStackView(arrangedSubviews: [stackProfile, stackImageCoins, stackStatusRedeem])
        stackViewAll.layer.cornerRadius = 10
        stackViewAll.axis = .vertical
        stackViewAll.distribution = .equalSpacing
        stackViewAll.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackViewAll)
        stackViewAll.setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth - 40)
        stackViewAll.setTopAnchorConstraint(equalTo: contentView.topAnchor, constant: 10)
        stackViewAll.setCenterXAnchorConstraint(equalTo: contentView.centerXAnchor)
        stackViewAll.setCenterYAnchorConstraint(equalTo: contentView.centerYAnchor)
        stackViewAll.setBottomAnchorConstraint(equalTo: contentView.bottomAnchor, constant: -10)
        stackViewAll.setLeadingAnchorConstraint(equalTo: contentView.leadingAnchor, constant: 10)
        stackViewAll.setTrailingAnchorConstraint(equalTo: contentView.trailingAnchor, constant: -10)
    }
}
