//
//  MerchantTransactionHistoryViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 28/11/22.
//

import UIKit

class MerchantTransactionHistoryViewController: UIViewController {
    var customer: UserInfoResponse?
    var purchaseData: PurchaseResponse?
    let userViewModel = UserViewModel.shared
    let transactionHistoryTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Transaction History"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let closeImage: UIImageView = {
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "multiply.circle.fill.green")
        iconImage.setWidthAnchorConstraint(equalToConstant: 24)
        iconImage.setHeightAnchorConstraint(equalToConstant: 24)
        iconImage.isUserInteractionEnabled = true
        return iconImage
    }()
    private var couponCard: CouponCardTransactionHistory = {
        let view = CouponCardTransactionHistory()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        closeImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapClose)))
        configData()
    }
    private func configData() {
        couponCard.tokenIdValueLabel.text = purchaseData?.token?.code ?? "-"
        couponCard.dateCreatedLabel.text = purchaseData?.createdAt.formatTodMMMyyyhmma()
        couponCard.merchantLabel.text = userViewModel.user?.name
        couponCard.customerNameValue.text = customer?.name
        couponCard.purchaseDateValue.text = purchaseData?.token?.createdAt.formatTodMMMyyyhmma() ?? "-"
        couponCard.percentageValue.text = "\(purchaseData?.token?.tokenCashback.percent ?? 0.0)%"
        couponCard.expiredDateValue.text = purchaseData?.token?.expiresAt.formatTodMMMyyyhmma() ?? "-"
        couponCard.exchangedCoinValue.text = "\(purchaseData?.coinExchange?.amount ?? 0)"
        couponCard.totalPurchaseValue.text = "\(purchaseData?.purchaseAmount ?? 0)"
        couponCard.customerPayValue.text = "\(purchaseData?.paymentAmount ?? 0)"
        couponCard.cashbackCoinValue.text = "\(purchaseData?.token?.tokenCashback.amount ?? 0)"
    }
    @objc func didTapClose() {
        dismiss(animated: true)
    }
}

extension MerchantTransactionHistoryViewController {
    func setupLayout() {
        setupTitle1()
        setupCoupon()
    }
    private func setupTitle1() {
        let hStackView = UIStackView(arrangedSubviews: [transactionHistoryTextLabel, closeImage])
        hStackView.axis = .horizontal
        hStackView.distribution = .equalSpacing
        hStackView.alignment = .fill
        hStackView.layer.cornerRadius = 10
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hStackView)
        hStackView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        hStackView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 16)
        hStackView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
    }
    private func setupCoupon() {
        view.addSubview(couponCard)
        couponCard.translatesAutoresizingMaskIntoConstraints = false
        couponCard.setTopAnchorConstraint(equalTo: transactionHistoryTextLabel.topAnchor, constant: 120)
        couponCard.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        couponCard.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
        couponCard.setWidthAnchorConstraint(equalToConstant: 487)
        couponCard.setHeightAnchorConstraint(equalToConstant: 358)
    }
}
