//
//  CustomerPurchaseFirstView.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 03/12/22.
//

import UIKit

class CustomerPurchaseFirstView: UIView {

    let getTokenLabel: UILabel = {
        let label = UILabel()
        label.text = "Get Token?"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let getTokenSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()

    let useCoinLabel: UILabel = {
        let label = UILabel()
        label.text = "Use Coin?"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let useCoinSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()

    let merchantNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Merchant Name"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let merchantNameValue: UILabel = {
        let label = UILabel()
        label.text = "Bestie Cafe"
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Monday, 10 November 2022"
        label.font = UIFont.systemFont(ofSize: 17)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@Barbara"
        label.font = UIFont.systemFont(ofSize: 17)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomerPurchaseFirstView {
    func setupView() {
        setupDetails()
    }
    func setupDetails() {
        let stackDateProfile = setupDateProfile()
        let stackMerchantName = setupMerchantName()
        let stackGetToken = setupGetToken()
        let stackUseCoin = setupUseCoin()

        let stackview = UIStackView(arrangedSubviews: [stackDateProfile, stackMerchantName, stackGetToken, stackUseCoin])
        stackview.backgroundColor = .white
        stackview.layer.borderWidth = 1
        stackview.layer.borderColor = UIColor.gray.cgColor
        stackview.layer.cornerRadius = 10
        stackview.axis = .vertical
        stackview.spacing = 15
        stackview.distribution = .fill
        stackview.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackview)
        stackview.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        stackview.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -10)
        stackview.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 10)
        stackview.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: 20)
    }
    func setupDateProfile() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, dateLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }
    func setupMerchantName() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [merchantNameLabel, merchantNameValue])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setHeightAnchorConstraint(equalToConstant: 50)

        return stackView
    }
    func setupGetToken() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [getTokenLabel, getTokenSwitch])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }
    func setupUseCoin() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [useCoinLabel, useCoinSwitch])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }
}
