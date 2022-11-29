//
//  CouponCardTransactionHistory+SetupUI.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 28/11/22.
//

import UIKit

extension CouponCardTransactionHistory {
    func setupLayout() {
        setupCoupon()
        setTitleStatus()
        setupStackDetail()
    }
    private func setupCoupon() {
        addSubview(coupon)
        coupon.translatesAutoresizingMaskIntoConstraints = false
        coupon.setTopAnchorConstraint(equalTo: topAnchor)
        coupon.setLeadingAnchorConstraint(equalTo: leadingAnchor)
        coupon.setTrailingAnchorConstraint(equalTo: trailingAnchor)
        coupon.setBottomAnchorConstraint(equalTo: bottomAnchor)
    }
    private func setTitleStatus() {
        let stackTokenAndDate = UIStackView(arrangedSubviews: [tokenIdValueLabel, dateCreatedLabel])
        stackTokenAndDate.axis = .horizontal
        stackTokenAndDate.alignment = .center
        stackTokenAndDate.distribution = .equalSpacing
        stackTokenAndDate.translatesAutoresizingMaskIntoConstraints = false

        let stackTransactionTitle = UIStackView(arrangedSubviews: [merchantLabel, stackTokenAndDate])
        stackTransactionTitle.axis = .vertical
        stackTransactionTitle.distribution = .equalSpacing
        stackTransactionTitle.spacing = 10
        stackTransactionTitle.translatesAutoresizingMaskIntoConstraints = false
        coupon.addSubview(stackTransactionTitle)
        stackTransactionTitle.setTopAnchorConstraint(equalTo: coupon.topAnchor)
        stackTransactionTitle.setLeadingAnchorConstraint(equalTo: coupon.leadingAnchor, constant: 20)
        stackTransactionTitle.setTrailingAnchorConstraint(equalTo: coupon.trailingAnchor, constant: -20)
    }

    private func setupStackDetail() {
        let setupCustomer = hStackView(views: [customerNameLabel, customerNameValue])
        let setupPurchaseDate = hStackView(views: [purchaseDateLabel, purchaseDateValue])
        let setupPercentage = hStackView(views: [percentageLabel, percentageValue])
        let setupExpiredDate = hStackView(views: [expiredDateLabel, expiredDateValue])

        let stackView1 = vStackView(views: [setupCustomer, setupPurchaseDate, setupPercentage, setupExpiredDate])
        coupon.addSubview(stackView1)
        stackView1.setTopAnchorConstraint(equalTo: tokenIdValueLabel.bottomAnchor, constant: 25)
        stackView1.setLeadingAnchorConstraint(equalTo: coupon.leadingAnchor, constant: 20)
        stackView1.setTrailingAnchorConstraint(equalTo: coupon.trailingAnchor, constant: -20)
        
        let setupCoinForExchangeCoin = setupCoin(view: exchangedCoinValue)
        let setupExchangeCoin = hStackView(views: [exchangedCoinLabel, setupCoinForExchangeCoin])
        let setupTotalPurchase = hStackView(views: [totalPurchaseLabel, totalPurchaseValue])
        
        let stackView2 = vStackView(views: [setupExchangeCoin, setupTotalPurchase])
        coupon.addSubview(stackView2)
        stackView2.setTopAnchorConstraint(equalTo: stackView1.bottomAnchor, constant: 30)
        stackView2.setLeadingAnchorConstraint(equalTo: coupon.leadingAnchor, constant: 20)
        stackView2.setTrailingAnchorConstraint(equalTo: coupon.trailingAnchor, constant: -20)
        
        let setupCustomerPay = hStackView(views: [customerPayLabel, customerPayValue])
        let setupCoinForCashbackCoin = setupCoin(view: cashbackCoinValue)
        let setupCashbackCoin = hStackView(views: [cashbackCoinLabel, setupCoinForCashbackCoin])
        
        let stackView3 = vStackView(views: [setupCustomerPay, setupCashbackCoin])
        coupon.addSubview(stackView3)
        stackView3.setTopAnchorConstraint(equalTo: stackView2.bottomAnchor, constant: 30)
        stackView3.setLeadingAnchorConstraint(equalTo: coupon.leadingAnchor, constant: 20)
        stackView3.setTrailingAnchorConstraint(equalTo: coupon.trailingAnchor, constant: -20)
        stackView3.setBottomAnchorConstraint(equalTo: coupon.bottomAnchor, constant: -20)
    }
    private func hStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
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
}
