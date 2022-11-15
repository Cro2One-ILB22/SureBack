//
//  HeaderSubmitStoryView.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 14/11/22.
//

import UIKit

class HeaderSubmitStoryView: UIView {

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
        label.text = "TOKEN ID 1748694736284869"
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
        addSubview(tokenLabel)
        tokenLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        addSubview(tokenIdLabel)
        tokenIdLabel.setTopAnchorConstraint(equalTo: tokenLabel.bottomAnchor, constant: 10)
        tokenIdLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)

        let stackView0 = UIStackView(arrangedSubviews: [merchantLabel, merchantNameLabel])
        stackView0.axis = .horizontal
        stackView0.distribution = .equalSpacing
        stackView0.alignment = .fill
        stackView0.translatesAutoresizingMaskIntoConstraints = false

        let stackView1 = UIStackView(arrangedSubviews: [dateLabel, dateNameLabel])
        stackView1.axis = .horizontal
        stackView1.distribution = .equalSpacing
        stackView1.alignment = .fill
        stackView1.translatesAutoresizingMaskIntoConstraints = false

        let stackView2 = UIStackView(arrangedSubviews: [purchaseLabel, purchaseNameLabel])
        stackView2.axis = .horizontal
        stackView2.distribution = .equalSpacing
        stackView2.alignment = .fill
        stackView2.translatesAutoresizingMaskIntoConstraints = false

        let stackViewHeader = UIStackView(arrangedSubviews: [tokenLabel, tokenIdLabel, stackView0, stackView1, stackView2])
        stackViewHeader.axis = .vertical
        stackViewHeader.distribution = .equalSpacing
        stackViewHeader.alignment = .fill
        stackViewHeader.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackViewHeader)
        stackViewHeader.setTopAnchorConstraint(equalTo: topAnchor, constant: 20)
        stackViewHeader.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)

        addSubview(storyLabel)
        storyLabel.setTopAnchorConstraint(equalTo: stackViewHeader.bottomAnchor, constant: 20)
        storyLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        storyLabel.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        storyLabel.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -20)
    }

}
