//
//  MerchantGenerateTokenFormViewController+SetupUI.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 28/11/22.
//

import UIKit
import PusherSwift

extension MerchantGenerateTokenFormViewController {
    func setupLayout() {
        setupCoinTransactoinLabel()
        setupCustomerName()
        setupPurchaseDate()
        setupPercentage()
        setupExpiredDate()
        setupExchangedCoin()
        setupTotalPurchaseText()
        setupTotalPurchaseField()
        setupGenerateButton()
    }
    private func setupCoinTransactoinLabel() {
        view.addSubview(coinTransactionTextLabel)
        coinTransactionTextLabel.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        coinTransactionTextLabel.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        coinTransactionTextLabel.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
    }
    private func setupCustomerName() {
        let customerNameSV = verticalStackView(views: [customerNameTextLabel, customerNameValueLabel])
        view.addSubview(customerNameSV)
        customerNameSV.setTopAnchorConstraint(equalTo: coinTransactionTextLabel.bottomAnchor, constant: 16)
        customerNameSV.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        customerNameSV.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
    }
    private func setupPurchaseDate() {
        let purchaseDateVS = verticalStackView(views: [purchaseDateTextLabel, purchaseDateValueLabel])
        view.addSubview(purchaseDateVS)
        purchaseDateVS.setTopAnchorConstraint(equalTo: customerNameTextLabel.bottomAnchor, constant: 7)
        purchaseDateVS.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        purchaseDateVS.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
    }
    private func setupPercentage() {
        let percentageVS = verticalStackView(views: [percentageTextLabel, percentageValueLabel])
        view.addSubview(percentageVS)
        percentageVS.setTopAnchorConstraint(equalTo: purchaseDateTextLabel.bottomAnchor, constant: 7)
        percentageVS.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        percentageVS.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
    }
    private func setupExpiredDate() {
        let expiredDateSV = verticalStackView(views: [expiredDateTextLabel, expiredDateValueLabel])
        view.addSubview(expiredDateSV)
        expiredDateSV.setTopAnchorConstraint(equalTo: percentageTextLabel.bottomAnchor, constant: 7)
        expiredDateSV.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        expiredDateSV.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
    }
    private func setupExchangedCoin() {
        let exchangedCoinSV = verticalStackView(views: [exchangedCoinTextLabel, exchangedCoinValueLabel])
        view.addSubview(exchangedCoinSV)
        exchangedCoinSV.setTopAnchorConstraint(equalTo: expiredDateTextLabel.bottomAnchor, constant: 30)
        exchangedCoinSV.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        exchangedCoinSV.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
    }
    private func setupTotalPurchaseText() {
        view.addSubview(totalPurchaseTextLabel)
        totalPurchaseTextLabel.setTopAnchorConstraint(equalTo: exchangedCoinTextLabel.bottomAnchor, constant: 16)
        totalPurchaseTextLabel.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        totalPurchaseTextLabel.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
    }
    private func setupTotalPurchaseField() {
        view.addSubview(totalPurchaseField)
        totalPurchaseField.translatesAutoresizingMaskIntoConstraints = false
        totalPurchaseField.setTopAnchorConstraint(equalTo: totalPurchaseTextLabel.bottomAnchor, constant: 16)
        totalPurchaseField.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        totalPurchaseField.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
    }
    private func setupGenerateButton() {
        view.addSubview(generateTokenButton)
        generateTokenButton.translatesAutoresizingMaskIntoConstraints = false
        generateTokenButton.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        generateTokenButton.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
        generateTokenButton.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
    }
    private func verticalStackView(views: [UIView]) -> UIStackView {
        let stackview = UIStackView(arrangedSubviews: views)
        stackview.axis = .horizontal
        stackview.distribution = .equalSpacing
        stackview.alignment = .fill
        stackview.layer.cornerRadius = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }
}

extension MerchantGenerateTokenFormViewController: PusherDelegate {}
