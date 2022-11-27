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
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()

    lazy var merchantNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    lazy var coinImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loyalty.coin")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.setWidthAnchorConstraint(equalToConstant: 20)
        image.setHeightAnchorConstraint(equalToConstant: 20)
        return image
    }()

    lazy var totalCoinsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
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
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.cornerRadius = 10

        setupImage()
        setupLabel()
        setupTag()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
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
        let stackCoins = UIStackView(arrangedSubviews: [coinImage, totalCoinsLabel])
        stackCoins.axis = .horizontal
        stackCoins.spacing = 5
        stackCoins.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [merchantNameLabel, stackCoins])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 5
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
