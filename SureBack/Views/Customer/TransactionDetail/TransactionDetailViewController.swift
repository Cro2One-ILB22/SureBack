//
//  TransactionDetailViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 26/11/22.
//

import UIKit

class TransactionDetailViewController: UIViewController {
    lazy var coupon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "coupon")
        image.contentMode = .scaleAspectFill
        return image
    }()
    lazy var statusImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "multiply.circle.fill.red")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.setWidthAnchorConstraint(equalToConstant: 34)
        image.setHeightAnchorConstraint(equalToConstant: 34)
        return image
    }()

    lazy var transactionStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Token Expired"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var transactionIdLabel: UILabel = {
        let label = UILabel()
        label.text = "12"
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    lazy var merchantNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Merchant"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidthAnchorConstraint(equalToConstant: 110)
        return label
    }()

    lazy var merchantNameValue: UILabel = {
        let label = UILabel()
        label.text = "Bestie Cafe"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var purchaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Purchase Date"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidthAnchorConstraint(equalToConstant: 110)
        return label
    }()

    lazy var purchaseDateValue: UILabel = {
        let label = UILabel()
        label.text = "4 Nov 2022, 11:00 AM"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var totalPurchaseLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Purchase"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidthAnchorConstraint(equalToConstant: 110)
        return label
    }()

    lazy var totalPurchaseValue: UILabel = {
        let label = UILabel()
        label.text = "Rp200,000"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Percentage"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidthAnchorConstraint(equalToConstant: 110)
        return label
    }()

    lazy var percentageValue: UILabel = {
        let label = UILabel()
        label.text = "10%"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var coinLabel: UILabel = {
        let label = UILabel()
        label.text = "Coin"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidthAnchorConstraint(equalToConstant: 110)
        return label
    }()

    lazy var coinValue: UILabel = {
        let label = UILabel()
        label.text = "001"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var expiredDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Expired Date"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidthAnchorConstraint(equalToConstant: 110)
        return label
    }()

    lazy var expiredDateValue: UILabel = {
        let label = UILabel()
        label.text = "11 Nov 2022, 11:02 PM"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var reasonLabel: UILabel = {
        let label = UILabel()
        label.text = "Reason"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidthAnchorConstraint(equalToConstant: 110)
        return label
    }()

    lazy var reasonValue: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }

    func configureToken(_ data: MyStoryData, status: String) {
        switch status {
        case "expired":
            statusImageView.image = UIImage(named: "multiply.circle.fill.red.tintBlack")
            transactionStatusLabel.text = "Token Expired"
            expiredDateLabel.text = "Expired Date"
            expiredDateValue.text = data.token.expiresAt.formatTodMMMyyyhmma()

            reasonLabel.isHidden = true
            reasonValue.isHidden = true
//            stackField7.isHidden = true
        case "approved":
            statusImageView.image = UIImage(named: "checkmark.circle.fill.green")
            transactionStatusLabel.text = "Story Approved"
            expiredDateLabel.text = "Rewarded Date"
            expiredDateValue.text = data.token.approvedAt?.formatTodMMMyyyhmmaStory()

            reasonLabel.isHidden = true
            reasonValue.isHidden = true
//            stackField7.isHidden = true
        case "rejected":
            statusImageView.image = UIImage(named: "multiply.circle.fill.red.tintBlack")
            transactionStatusLabel.text = "Story Rejected"
            expiredDateLabel.text = "Rejected Date"
            expiredDateValue.text = data.token.rejectedAt?.formatTodMMMyyyhmmaStory()
            reasonValue.text = data.token.rejectedReason ?? "-"
        default:
            break
        }
        transactionIdLabel.text = String(data.token.id)
        merchantNameValue.text = data.token.merchant.name
        purchaseDateValue.text = data.token.purchase?.createdAt.formatTodMMMyyyhmma()
        totalPurchaseValue.text = String(data.token.purchase?.purchaseAmount ?? 0)
        percentageValue.text = "\(data.token.tokenCashback.percent)%"
        coinValue.text = "\(data.token.tokenCashback.amount)"
    }

    func configureCoin(_ data: Transaction) {
        transactionIdLabel.text = String(data.purchase?.token?.id ?? 0)

        merchantNameValue.text = data.purchase?.merchant?.name
        purchaseDateValue.text = data.purchase?.createdAt.formatTodMMMyyyhmma()
        totalPurchaseValue.text = String(data.purchase?.purchaseAmount ?? 0)
        coinValue.text = String(data.amount ?? 0)
        switch data.accountingEntry {
        case .c:
            statusImageView.image = UIImage(named: "arrow.down.left.circle.fill")?.sd_tintedImage(with: .green)
            transactionStatusLabel.text = "Reward Credited"
            percentageValue.text = "\(String(data.purchase?.token?.tokenCashback.percent ?? 0))%"
            expiredDateLabel.text = "Redeemed Date"
            expiredDateValue.text = data.purchase?.token?.submittedAt?.formatTodMMMyyyhmma()
            reasonLabel.text = "Credited Date"
            reasonValue.text = data.purchase?.token?.approvedAt?.formatTodMMMyyyhmmaStory() ?? data.purchase?.token?.rejectedAt?.formatTodMMMyyyhmmaStory()
        case .d:
            statusImageView.image = UIImage(named: "arrow.up.forward.circle.fill")?.sd_tintedImage(with: .red)
            transactionStatusLabel.text = "Coin Used"
            percentageLabel.isHidden = true
            percentageValue.isHidden = true
            coinLabel.text = "Coin Used"
            expiredDateLabel.isHidden = true
            expiredDateValue.isHidden = true
            reasonLabel.text = "Payment"
            reasonValue.text = String(data.purchase?.paymentAmount ?? 0)
        }
    }
}

extension TransactionDetailViewController {
    private func setupLayout() {
        setupCoupon()
        setTitleStatus()
        setupStackDetail()
    }

    private func setupCoupon() {
        view.addSubview(coupon)
        coupon.translatesAutoresizingMaskIntoConstraints = false
        coupon.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
        coupon.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        coupon.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        coupon.setWidthAnchorConstraint(equalToConstant: 487)
        coupon.setHeightAnchorConstraint(equalToConstant: 358)
    }

    private func setTitleStatus() {
        let stackTransactionStatus = UIStackView(arrangedSubviews: [statusImageView, transactionStatusLabel])
        stackTransactionStatus.axis = .horizontal
        stackTransactionStatus.alignment = .center
        stackTransactionStatus.distribution = .fill
        stackTransactionStatus.spacing = 5
        stackTransactionStatus.translatesAutoresizingMaskIntoConstraints = false

        let stackTransactionTitle = UIStackView(arrangedSubviews: [stackTransactionStatus, transactionIdLabel])
        stackTransactionTitle.axis = .vertical
        stackTransactionTitle.alignment = .center
        stackTransactionTitle.distribution = .fill
        stackTransactionTitle.spacing = 5
        stackTransactionTitle.translatesAutoresizingMaskIntoConstraints = false

        coupon.addSubview(stackTransactionTitle)
        stackTransactionTitle.setTopAnchorConstraint(equalTo: coupon.safeAreaLayoutGuide.topAnchor, constant: 20)
        stackTransactionTitle.setLeadingAnchorConstraint(equalTo: coupon.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        stackTransactionTitle.setTrailingAnchorConstraint(equalTo: coupon.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        stackTransactionTitle.setCenterXAnchorConstraint(equalTo: coupon.centerXAnchor)
    }

    private func setupStackDetail() {
        let stackField1 = setupMerchant()
        let stackField2 = setupPurchaseDate()
        let stackField3 = setupTotalPurchase()
        let stackField4 = setupPercentage()
        let stackField5 = setupCoin()
        let stackField6 = setupExpiredDate()
        let stackField7 = setupReason()

        let stackView = UIStackView(arrangedSubviews: [stackField1, stackField2, stackField3, stackField4, stackField5, stackField6, stackField7])
        stackView.axis = .vertical
        stackView.spacing = 10
//        stackView.backgroundColor = .white
//        stackView.layer.borderWidth = 1
//        stackView.layer.borderColor = UIColor.gray.cgColor
//        stackView.layer.cornerRadius = 10
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        coupon.addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: transactionIdLabel.bottomAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
    }

    private func setupMerchant() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [merchantNameLabel, merchantNameValue])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }

    private func setupPurchaseDate() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [purchaseDateLabel, purchaseDateValue])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }

    private func setupTotalPurchase() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [totalPurchaseLabel, totalPurchaseValue])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }

    private func setupPercentage() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [percentageLabel, percentageValue])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }

    private func setupCoin() -> UIStackView {
        // coin, coin used
        let coinImage: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: "loyalty.coin")
            image.translatesAutoresizingMaskIntoConstraints = false
            image.setWidthAnchorConstraint(equalToConstant: 20)
            image.setHeightAnchorConstraint(equalToConstant: 20)
            return image
        }()
        let stackLoyaltyCoin = UIStackView(arrangedSubviews: [coinImage, coinValue])
        stackLoyaltyCoin.axis = .horizontal
        stackLoyaltyCoin.distribution = .fill
        stackLoyaltyCoin.spacing = 10

        let stackView = UIStackView(arrangedSubviews: [coinLabel, stackLoyaltyCoin])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }

    private func setupExpiredDate() -> UIStackView {
        // expired, rewarded, rejected, payment, redeem date
        let stackView = UIStackView(arrangedSubviews: [expiredDateLabel, expiredDateValue])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }

    private func setupReason() -> UIStackView {
        // reason, credited date
        let stackView = UIStackView(arrangedSubviews: [reasonLabel, reasonValue])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }
}
