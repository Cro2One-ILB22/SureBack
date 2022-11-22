//
//  ItemMerchantTableViewCell.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 10/11/22.
//

import UIKit

class ItemMerchantTableViewCell: UITableViewCell {

    static let id = "ItemMerchantTableViewCell"

    lazy var merchantImage: UIImageView = {
        let merchantImage = UIImageView()
        merchantImage.contentMode = .scaleAspectFill
        merchantImage.layer.cornerRadius = 10
        merchantImage.clipsToBounds = true
        return merchantImage
    }()

    lazy var merchantNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    lazy var totalCoinsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()

    lazy var merchantTagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.backgroundColor = .systemBlue
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImage()
        setupLabel()
        setupTag()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupImage() {
        addSubview(merchantImage)
        merchantImage.translatesAutoresizingMaskIntoConstraints = false
        merchantImage.setCenterYAnchorConstraint(equalTo: centerYAnchor)
        merchantImage.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        merchantImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        merchantImage.widthAnchor.constraint(equalTo: merchantImage.heightAnchor).isActive = true
    }

    func setupLabel() {
        let stackView = UIStackView(arrangedSubviews: [merchantNameLabel, totalCoinsLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        stackView.setLeadingAnchorConstraint(equalTo: merchantImage.trailingAnchor, constant: 30)
    }

    func setupTag() {
        addSubview(merchantTagLabel)
        merchantTagLabel.translatesAutoresizingMaskIntoConstraints = false
        merchantTagLabel.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -20)
        merchantTagLabel.setLeadingAnchorConstraint(equalTo: merchantImage.trailingAnchor, constant: 30)
    }
}
