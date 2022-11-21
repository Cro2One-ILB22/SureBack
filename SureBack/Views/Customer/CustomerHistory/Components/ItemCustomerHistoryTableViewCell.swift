//
//  ItemCustomerHistoryTableViewCell.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 13/11/22.
//

import UIKit

class ItemCustomerHistoryTableViewCell: UITableViewCell {

    static let id = "ItemCustomerHistoryTableViewCell"

    lazy var statusImage: UIImageView = {
        let merchantImage = UIImageView()
        merchantImage.contentMode = .scaleAspectFill
        merchantImage.clipsToBounds = true
        return merchantImage
    }()

    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Direview"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()

    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Success"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "13 November 2022"
        label.textColor = .systemGray
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()

    lazy var coinsLabel: UILabel = {
        let label = UILabel()
        label.text = "+ 2000 coins"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImage()
        setupLabel()
        setupCoinsLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupImage() {
        addSubview(statusImage)
        statusImage.translatesAutoresizingMaskIntoConstraints = false
        statusImage.setCenterYAnchorConstraint(equalTo: centerYAnchor)
        statusImage.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 15)
        statusImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        statusImage.widthAnchor.constraint(equalTo: statusImage.heightAnchor).isActive = true
    }

    func setupLabel() {
        let stackView = UIStackView(arrangedSubviews: [statusLabel, categoryLabel ,dateLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setCenterYAnchorConstraint(equalTo: centerYAnchor)
        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        stackView.setLeadingAnchorConstraint(equalTo: statusImage.trailingAnchor, constant: 10)
    }

    func setupCoinsLabel() {
        addSubview(coinsLabel)
        coinsLabel.translatesAutoresizingMaskIntoConstraints = false
        coinsLabel.setCenterYAnchorConstraint(equalTo: centerYAnchor)
        coinsLabel.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
    }
}
