//
//  HeaderCustomerDashboardView.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 12/11/22.
//

import UIKit

class HeaderCustomerDashboardView: UIView {
    let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi, @bestie"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var coinImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loyalty.coin")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 13
        image.setWidthAnchorConstraint(equalToConstant: 24)
        image.setHeightAnchorConstraint(equalToConstant: 24)
        return image
    }()

    let totalCoinsLabel: UILabel = {
        let label = UILabel()
        label.text = " 58000"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let coinsLabel: UILabel = {
        let label = UILabel()
        label.text = " Accumulation "
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let notifButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bell.circle.fill.green"), for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setWidthAnchorConstraint(equalToConstant: 30)
        button.setHeightAnchorConstraint(equalToConstant: 30)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderCustomerDashboardView {
    private func setupHeaderView() {
        let stackView = UIStackView(arrangedSubviews: [coinImage, totalCoinsLabel, coinsLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let stackViewAll = UIStackView(arrangedSubviews: [profileLabel, stackView])
        stackViewAll.axis = .vertical
        stackViewAll.distribution = .equalSpacing
        stackViewAll.alignment = .fill
        stackViewAll.spacing = 5
        stackViewAll.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackViewAll)
        stackViewAll.setTopAnchorConstraint(equalTo: topAnchor, constant: 5)
        stackViewAll.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)

        addSubview(notifButton)
        notifButton.setTopAnchorConstraint(equalTo: safeAreaLayoutGuide.topAnchor)
        notifButton.setTrailingAnchorConstraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
//        notifButton.setHeightAnchorConstraint(equalToConstant: 50)
    }
}
