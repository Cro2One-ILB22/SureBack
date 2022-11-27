//
//  TransactionDetailViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 26/11/22.
//

import UIKit

class TransactionDetailViewController: UIViewController {

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
        label.font = UIFont.boldSystemFont(ofSize: 22)
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
        return label
    }()

    lazy var coinValue: UILabel = {
        let label = UILabel()
        label.text = "0"
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
        return label
    }()

    lazy var reasonValue: UILabel = {
        let label = UILabel()
        label.text = "Foto tidak sesuai"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
}

extension TransactionDetailViewController {
    private func setupLayout() {
        let stackTransactionStatus = UIStackView(arrangedSubviews: [statusImageView, transactionStatusLabel])
        stackTransactionStatus.axis = .horizontal
        stackTransactionStatus.alignment = .center
        stackTransactionStatus.distribution = .equalSpacing
        stackTransactionStatus.spacing = 5
        stackTransactionStatus.translatesAutoresizingMaskIntoConstraints = false

        let stackTransactionTitle = UIStackView(arrangedSubviews: [stackTransactionStatus, transactionIdLabel])
        stackTransactionTitle.axis = .vertical
        stackTransactionTitle.alignment = .center
        stackTransactionTitle.distribution = .equalSpacing
        stackTransactionTitle.spacing = 5
        stackTransactionTitle.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackTransactionTitle)
        stackTransactionTitle.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        stackTransactionTitle.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        stackTransactionTitle.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)

        let stackLabel = UIStackView(arrangedSubviews: [merchantNameLabel, purchaseDateLabel, totalPurchaseLabel, percentageLabel, coinLabel, expiredDateLabel, reasonLabel])
        stackLabel.axis = .vertical
        stackLabel.distribution = .equalSpacing
        stackLabel.alignment = .fill
        stackLabel.spacing = 5
        stackLabel.translatesAutoresizingMaskIntoConstraints = false

        let stackValue = UIStackView(arrangedSubviews: [merchantNameValue, purchaseDateValue, totalPurchaseValue, percentageValue, coinValue, expiredDateValue, reasonValue])
        stackValue.axis = .vertical
        stackValue.distribution = .equalSpacing
        stackValue.alignment = .fill
        stackValue.spacing = 5
        stackValue.translatesAutoresizingMaskIntoConstraints = false

        let stackDetails = UIStackView(arrangedSubviews: [stackLabel, stackValue])
        stackDetails.backgroundColor = .white
        stackDetails.layer.borderWidth = 1
        stackDetails.layer.borderColor = UIColor.gray.cgColor
        stackDetails.layer.cornerRadius = 10
        stackDetails.axis = .horizontal
        stackDetails.spacing = 30
        stackDetails.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stackDetails.isLayoutMarginsRelativeArrangement = true
        stackDetails.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackDetails)
        stackDetails.setTopAnchorConstraint(equalTo: stackTransactionTitle.bottomAnchor, constant: 20)
        stackDetails.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        stackDetails.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
    }
}
