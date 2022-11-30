//
//  HeaderCustomerHistoryView+SetupUI.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 30/11/22.
//

import UIKit

extension HeaderCustomerHistoryView {
    func setupHeaderView() {
        // Stack 1
        let stackProfile = UIStackView(arrangedSubviews: [userNameLabel, merchantLabel])
        stackProfile.axis = .vertical
        stackProfile.distribution = .equalSpacing
        stackProfile.translatesAutoresizingMaskIntoConstraints = false

        // Stack 2
        let stack2 = UIStackView(arrangedSubviews: [profileImage, openLinkButton])
        stack2.axis = .horizontal
        stack2.spacing = 5
        stack2.distribution = .fill
        stack2.alignment = .center
        stack2.translatesAutoresizingMaskIntoConstraints = false


        bgProfileImageView.addSubview(stack2)
        stack2.setCenterYAnchorConstraint(equalTo: bgProfileImageView.centerYAnchor)
        stack2.setCenterXAnchorConstraint(equalTo: bgProfileImageView.centerXAnchor)
//        profileImage.translatesAutoresizingMaskIntoConstraints = false
        bgProfileImageView.setWidthAnchorConstraint(equalToConstant: 80)

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
//        stackImageCoins.distribution = .fillProportionally
        stackImageCoins.spacing = 170
        stackImageCoins.translatesAutoresizingMaskIntoConstraints = false

        // Stack 3
        let stackStatus = UIStackView(arrangedSubviews: [lockImage, statusLabel])
        stackStatus.axis = .horizontal
        stackStatus.spacing = 5
        stackStatus.distribution = .fill
        stackStatus.translatesAutoresizingMaskIntoConstraints = false

        let stackRedeemLabel = UIStackView(arrangedSubviews: [redeemLabel, redeemButton])
        stackRedeemLabel.axis = .horizontal
        stackRedeemLabel.spacing = 5
        stackRedeemLabel.distribution = .equalSpacing
        stackRedeemLabel.translatesAutoresizingMaskIntoConstraints = false

        stackRedeemButton = UIStackView(arrangedSubviews: [timerLabel, stackRedeemLabel])
        stackRedeemButton.axis = .vertical
        stackRedeemButton.distribution = .fill
        stackRedeemButton.alignment = .center
        stackRedeemButton.translatesAutoresizingMaskIntoConstraints = false

        redeemButtonView.addSubview(stackRedeemButton)
        stackRedeemButton.setTopAnchorConstraint(equalTo: redeemButtonView.topAnchor)
        stackRedeemButton.setLeadingAnchorConstraint(equalTo: redeemButtonView.leadingAnchor)
        stackRedeemButton.setTrailingAnchorConstraint(equalTo: redeemButtonView.trailingAnchor)
        stackRedeemButton.setBottomAnchorConstraint(equalTo: redeemButtonView.bottomAnchor, constant: -5)

        let stackStatusRedeem = UIStackView(arrangedSubviews: [stackStatus, redeemButtonView])
        stackStatusRedeem.axis = .horizontal
        stackStatusRedeem.distribution = .equalSpacing
        stackStatusRedeem.alignment = .center
        stackStatusRedeem.translatesAutoresizingMaskIntoConstraints = false

        let contentView = UIView()
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth - 40)
        contentView.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        contentView.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -10)
        contentView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 10)
        contentView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -10)

        contentView.addSubview(image)

        // Stack All
        let stackViewAll = UIStackView(arrangedSubviews: [stackProfile, stackImageCoins, stackStatusRedeem])
        stackViewAll.layer.cornerRadius = 10
        stackViewAll.axis = .vertical
        stackViewAll.distribution = .equalSpacing
        stackViewAll.spacing = 5
        stackViewAll.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackViewAll)
//        stackViewAll.setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth - 20)
        stackViewAll.setTopAnchorConstraint(equalTo: contentView.topAnchor, constant: 10)
//        stackViewAll.setCenterXAnchorConstraint(equalTo: contentView.centerXAnchor)
//        stackViewAll.setCenterYAnchorConstraint(equalTo: contentView.centerYAnchor)
        stackViewAll.setBottomAnchorConstraint(equalTo: contentView.bottomAnchor, constant: -10)
        stackViewAll.setLeadingAnchorConstraint(equalTo: contentView.leadingAnchor, constant: 10)
        stackViewAll.setTrailingAnchorConstraint(equalTo: contentView.trailingAnchor, constant: 10)
    }
}
