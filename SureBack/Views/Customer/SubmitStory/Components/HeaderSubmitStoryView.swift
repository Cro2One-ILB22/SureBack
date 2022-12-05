//
//  HeaderSubmitStoryView.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 14/11/22.
//

import UIKit

class HeaderSubmitStoryView: UIView {
    lazy var expireLabel: UILabel = {
        let label = UILabel()
        label.text = "Expires in"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var tokenLabel: UILabel = {
        let label = UILabel()
        label.text = "Token Details"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var tokenIdLabel: UILabel = {
        let label = UILabel()
        label.text = "Token ID"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var tokenIdValueLabel: UILabel = {
        let label = UILabel()
        label.text = "1748694736284869"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var merchantNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Merchant"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var merchantNameValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Sushi Mei"
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.setWidthAnchorConstraint(equalToConstant: 180)
        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var dateValueLabel: UILabel = {
        let label = UILabel()
        label.text = "17 October 2022"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var purchaseLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Purchase"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var purchaseValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Rp4,000,000"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let storyLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose Story"
        label.font = UIFont.boldSystemFont(ofSize: 17)
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

    func setupHeaderView() {
        let stackTimer = UIStackView(arrangedSubviews: [expireLabel, timerLabel])
        stackTimer.axis = .vertical
        stackTimer.distribution = .equalSpacing
        stackTimer.alignment = .fill
        stackTimer.translatesAutoresizingMaskIntoConstraints = false

        let stackTokenId = UIStackView(arrangedSubviews: [tokenIdLabel, tokenIdValueLabel])
        stackTokenId.axis = .horizontal
        stackTokenId.distribution = .equalCentering
        stackTokenId.translatesAutoresizingMaskIntoConstraints = false

//        let stackMerchant = UIStackView(arrangedSubviews: [merchantNameLabel, merchantNameValueLabel])
//        stackMerchant.axis = .horizontal
//        stackMerchant.distribution = .equalCentering
//        stackMerchant.translatesAutoresizingMaskIntoConstraints = false

        let merchantLabel = UIView()
        merchantLabel.translatesAutoresizingMaskIntoConstraints = false
        merchantLabel.addSubview(merchantNameLabel)
        merchantLabel.addSubview(merchantNameValueLabel)
        merchantNameLabel.setTopAnchorConstraint(equalTo: merchantLabel.topAnchor, constant: 0)
        merchantNameLabel.setBottomAnchorConstraint(equalTo: merchantLabel.bottomAnchor, constant: 0)
        merchantNameValueLabel.setTopAnchorConstraint(equalTo: merchantLabel.topAnchor, constant: 0)
        merchantNameValueLabel.setBottomAnchorConstraint(equalTo: merchantLabel.bottomAnchor, constant: 0)

        merchantNameLabel.setLeadingAnchorConstraint(equalTo: merchantLabel.leadingAnchor, constant: 0)
//        merchantNameValueLabel.setLeadingAnchorConstraint(equalTo: merchantNameLabel.trailingAnchor, constant: 70)
        merchantNameValueLabel.setTrailingAnchorConstraint(equalTo: merchantLabel.trailingAnchor, constant: 0)
//        merchantNameValueLabel.setLeadingAnchorConstraint(equalTo: merchantNameLabel.trailingAnchor, constant: 100)
//        stackMerchant.setTopAnchorConstraint(equalTo: merchantlabel.topAnchor)
//        stackMerchant.setLeadingAnchorConstraint(equalTo: merchantlabel.leadingAnchor)
//        stackMerchant.setTrailingAnchorConstraint(equalTo: merchantlabel.trailingAnchor)
//        stackMerchant.setBottomAnchorConstraint(equalTo: merchantlabel.bottomAnchor)

        let stackDate = UIStackView(arrangedSubviews: [dateLabel, dateValueLabel])
        stackDate.axis = .horizontal
        stackDate.distribution = .equalCentering
        stackDate.translatesAutoresizingMaskIntoConstraints = false

        let stackPurchase = UIStackView(arrangedSubviews: [purchaseLabel, purchaseValueLabel])
        stackPurchase.axis = .horizontal
        stackPurchase.distribution = .equalCentering
        stackPurchase.translatesAutoresizingMaskIntoConstraints = false

        let stackTokenDetails = UIStackView(arrangedSubviews: [stackTokenId, merchantLabel, stackDate, stackPurchase])
        stackTokenDetails.axis = .vertical
        stackTokenDetails.backgroundColor = .white
        stackTokenDetails.layer.borderWidth = 1
        stackTokenDetails.layer.borderColor = UIColor.gray.cgColor
        stackTokenDetails.layer.cornerRadius = 10
        stackTokenDetails.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stackTokenDetails.isLayoutMarginsRelativeArrangement = true
        stackTokenDetails.translatesAutoresizingMaskIntoConstraints = false

        // let stackLabel = UIStackView(arrangedSubviews: [tokenIdLabel, merchantNameLabel, dateLabel, purchaseLabel])
        // stackLabel.axis = .vertical
        // stackLabel.distribution = .equalSpacing
        // stackLabel.alignment = .fill
        // stackLabel.spacing = 5
        // stackLabel.translatesAutoresizingMaskIntoConstraints = false

        // let stackValue = UIStackView(arrangedSubviews: [tokenIdValueLabel, merchantNameValueLabel, dateValueLabel, purchaseValueLabel])
        // stackValue.axis = .vertical
        // stackValue.distribution = .equalSpacing
        // stackValue.alignment = .fill
        // stackValue.spacing = 5
        // stackValue.translatesAutoresizingMaskIntoConstraints = false

        // let stackTokenDetails = UIStackView(arrangedSubviews: [stackLabel, stackValue])
        // stackTokenDetails.backgroundColor = .white
        // stackTokenDetails.layer.borderWidth = 1
        // stackTokenDetails.layer.borderColor = UIColor.gray.cgColor
        // stackTokenDetails.layer.cornerRadius = 10
        // stackTokenDetails.axis = .horizontal
        // stackTokenDetails.spacing = 30
        // stackTokenDetails.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        // stackTokenDetails.isLayoutMarginsRelativeArrangement = true
        // stackTokenDetails.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [stackTimer, tokenLabel, stackTokenDetails])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)

        addSubview(storyLabel)
        storyLabel.setTopAnchorConstraint(equalTo: stackView.bottomAnchor, constant: 20)
        storyLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        storyLabel.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        storyLabel.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -20)

        stackTokenDetails.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -10)
        stackTokenDetails.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 10)

    }
}
