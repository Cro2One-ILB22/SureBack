//
//  HeaderMerchantDashboardView.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 10/11/22.
//

import UIKit

class HeaderMerchantDashboardView: UIView {
    let businessStatusCard: BussinesStatusCardView = {
        let card = BussinesStatusCardView()
        return card
    }()
    private let customersLabel: UILabel = {
        let label = UILabel()
        label.text = "Customers"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let seeAllCustomersButton: UIButton = {
       let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.tealishGreen, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .porcelain
        setupBussinesStatusCard()
        setupCustomersLabel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderMerchantDashboardView {
    private func setupBussinesStatusCard() {
        addSubview(businessStatusCard)
        businessStatusCard.setTopAnchorConstraint(equalTo: topAnchor, constant: 20)
        businessStatusCard.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        businessStatusCard.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        businessStatusCard.setHeightAnchorConstraint(equalToConstant: 144)
        businessStatusCard.setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth)
    }
    private func setupCustomersLabel() {
        let stackView = UIStackView(arrangedSubviews: [customersLabel, seeAllCustomersButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: businessStatusCard.bottomAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        stackView.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -20)
    }
}
