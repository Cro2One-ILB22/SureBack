//
//  MerchantDetailPurchase+SetupUI.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 05/12/22.
//

import UIKit
import PusherSwift

extension MerchantDetailPurchaseViewController {
    func setupLayout() {
        setupStackDetail()
        setupGenerateButton()
    }
    private func setupStackDetail() {
        let setupEditButton = setupEditButton(view: totalPurchaseValueLabel)
        let setupTotalPurchase = hStackView(views: [totalPurchaseTextLabel, setupEditButton])
        
        let stackView1 = vStackView(views: [setupTotalPurchase])
        stackView1.backgroundColor = .white
        stackView1.layer.cornerRadius = 10
        stackView1.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView1.isLayoutMarginsRelativeArrangement = true
        view.addSubview(stackView1)
        stackView1.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25)
        stackView1.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        stackView1.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
        let setupCustomer = hStackView(views: [customerNameTextLabel, customerNameValueLabel])
        let setupPercentage = hStackView(views: [percentageTextLabel, percentageValueLabel])
        let setupExchangedCoin = hStackView(views: [exchangedCoinTextLabel, exchangedCoinValueLabel])

        let stackView2 = vStackView(views: [setupCustomer, setupPercentage, setupExchangedCoin])
        stackView2.backgroundColor = .white
        stackView2.layer.cornerRadius = 10
        stackView2.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView2.isLayoutMarginsRelativeArrangement = true
        view.addSubview(stackView2)
        stackView2.setTopAnchorConstraint(equalTo: stackView1.bottomAnchor, constant: 25)
        stackView2.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        stackView2.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
        
        let setupTotalPayment = hStackView(views: [totalPaymentTextLabel, totalPaymentValueLabel])
        let setupCoinForCashback = setupCoin(view: cashbackCoinValueLabel)
        let setupCashbackCoin = hStackView(views: [cashbackCoinsTextLabel, setupCoinForCashback])
        
        let stackView3 = vStackView(views: [setupTotalPayment, setupCashbackCoin])
        stackView3.backgroundColor = .white
        stackView3.layer.cornerRadius = 10
        stackView3.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView3.isLayoutMarginsRelativeArrangement = true
        view.addSubview(stackView3)
        stackView3.setTopAnchorConstraint(equalTo: stackView2.bottomAnchor, constant: 30)
        stackView3.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        stackView3.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
    }
    private func setupGenerateButton() {
        view.addSubview(makePurchaseButton)
        makePurchaseButton.translatesAutoresizingMaskIntoConstraints = false
        makePurchaseButton.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        makePurchaseButton.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
        makePurchaseButton.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
    }
    private func hStackView(views: [UIView]) -> UIStackView {
        let stackview = UIStackView(arrangedSubviews: views)
        stackview.axis = .horizontal
        stackview.distribution = .equalSpacing
        stackview.alignment = .fill
        stackview.layer.cornerRadius = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }
    private func vStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    private func setupCoin(view: UIView) -> UIStackView {
        let coinImage: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: "loyalty.coin")
            image.translatesAutoresizingMaskIntoConstraints = false
            image.setWidthAnchorConstraint(equalToConstant: 20)
            image.setHeightAnchorConstraint(equalToConstant: 20)
            return image
        }()
        let stackLoyaltyCoin = UIStackView(arrangedSubviews: [coinImage, view])
        stackLoyaltyCoin.axis = .horizontal
        stackLoyaltyCoin.distribution = .fill
        stackLoyaltyCoin.spacing = 10
        return stackLoyaltyCoin
    }
    private func setupEditButton(view: UIView) -> UIStackView {
        editImage.translatesAutoresizingMaskIntoConstraints = false
        editImage.setWidthAnchorConstraint(equalToConstant: 20)
        editImage.setHeightAnchorConstraint(equalToConstant: 20)
        let stackLoyaltyCoin = UIStackView(arrangedSubviews: [view, editImage])
        stackLoyaltyCoin.axis = .horizontal
        stackLoyaltyCoin.distribution = .fill
        stackLoyaltyCoin.spacing = 10
        return stackLoyaltyCoin
    }
}

extension MerchantDetailPurchaseViewController: PusherDelegate {}
