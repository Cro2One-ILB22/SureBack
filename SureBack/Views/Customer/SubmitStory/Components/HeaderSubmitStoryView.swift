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
        label.text = "Timer"
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
        label.text = "TOKEN ID"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var tokenIdNameLabel: UILabel = {
        let label = UILabel()
        label.text = "1748694736284869"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var merchantLabel: UILabel = {
        let label = UILabel()
        label.text = "Merchant"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var merchantNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sushi Mei"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
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

    lazy var dateNameLabel: UILabel = {
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

    lazy var purchaseNameLabel: UILabel = {
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

        let stackTokenId = UIStackView(arrangedSubviews: [tokenIdLabel, tokenIdNameLabel])
        stackTokenId.axis = .horizontal
        stackTokenId.distribution = .equalSpacing
        stackTokenId.alignment = .fill
        stackTokenId.spacing = 250
        stackTokenId.translatesAutoresizingMaskIntoConstraints = false

        let stackMerchant = UIStackView(arrangedSubviews: [merchantLabel, merchantNameLabel])
        stackMerchant.axis = .horizontal
        stackMerchant.distribution = .equalSpacing
        stackMerchant.alignment = .fill
        stackMerchant.spacing = 250
        stackMerchant.translatesAutoresizingMaskIntoConstraints = false

        let stackDate = UIStackView(arrangedSubviews: [dateLabel, dateNameLabel])
        stackDate.axis = .horizontal
        stackDate.distribution = .equalSpacing
        stackDate.alignment = .fill
        stackDate.spacing = 250
        stackDate.translatesAutoresizingMaskIntoConstraints = false

        let stackPurchase = UIStackView(arrangedSubviews: [purchaseLabel, purchaseNameLabel])
        stackPurchase.axis = .horizontal
        stackPurchase.distribution = .equalSpacing
        stackPurchase.alignment = .fill
        stackPurchase.spacing = 250
        stackPurchase.translatesAutoresizingMaskIntoConstraints = false

        let stackViewTokenDetails = UIStackView(arrangedSubviews: [tokenLabel, stackTokenId, stackMerchant, stackDate, stackPurchase])
        stackViewTokenDetails.axis = .vertical
        stackViewTokenDetails.distribution = .equalSpacing
        stackViewTokenDetails.alignment = .fill
        stackViewTokenDetails.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [stackTimer, stackViewTokenDetails])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)

        addSubview(storyLabel)
        storyLabel.setTopAnchorConstraint(equalTo: stackView.bottomAnchor, constant: 20)
        storyLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        storyLabel.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        storyLabel.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -20)
    }
}
