//
//  ItemActiveTokenCollectionViewCell.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 12/11/22.
//

import UIKit

class ItemActiveTokenCollectionViewCell: UICollectionViewCell {

    static let id = "ItemActiveTokenCollectionViewCell"

    let expireLabel: UILabel = {
        let label = UILabel()
        label.text = "Expires in"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var tokenMerchantNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Merchant Name"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "Timer"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var redeemButton: UIButton = {
        let button = UIButton()
        button.setTitle("Redeem", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 30
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .lightGray
        layer.cornerRadius = 30
        setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth)
        setHeightAnchorConstraint(equalToConstant: 100)
        translatesAutoresizingMaskIntoConstraints = false
        setupStackLabel()
        setupButton()
    }

    private func setupStackLabel() {
        let stackView = UIStackView(arrangedSubviews: [expireLabel, tokenMerchantNameLabel, timerLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
    }

    private func setupButton() {
        addSubview(redeemButton)
        redeemButton.setCenterYAnchorConstraint(equalTo: centerYAnchor)
        redeemButton.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
    }
}
