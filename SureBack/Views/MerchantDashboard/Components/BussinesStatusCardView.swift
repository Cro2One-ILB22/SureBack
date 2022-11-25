//
//  BussinesStatusCardView.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 10/11/22.
//

import UIKit

class BussinesStatusCardView: UIView {
    lazy var label: UILabel = {
       let label = UILabel()
        label.text = "Total tokens today"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var totalTokenLabel: UILabel = {
       let label = UILabel()
        label.text = "0 Token"
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var outstandingCoinLabel: UILabel = {
       let label = UILabel()
        label.text = "Outstanding Coins"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var totalOutstandingCoinLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "0"
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var exchangedCoinLabel: UILabel = {
       let label = UILabel()
        label.text = "Exchanged Coins"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var totalExchangedCoinLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "0"
        label.font = .boldSystemFont(ofSize: 22)
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
    private func setupView() {
        backgroundColor = .white
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [label, totalTokenLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        
        let outstandingStackView = verticalStackView([outstandingCoinLabel, totalOutstandingCoinLabel])
        let exchangedStackView = verticalStackView([exchangedCoinLabel, totalExchangedCoinLabel])
        
        let separator = UIView()
        separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        separator.backgroundColor = .osloGray
        
        let stackViewCoins = UIStackView(arrangedSubviews: [outstandingStackView, separator, exchangedStackView])
        stackViewCoins.axis = .horizontal
        stackViewCoins.distribution = .equalSpacing
        stackViewCoins.alignment = .fill
        stackViewCoins.backgroundColor = .tealishGreenWithOpacity
        stackViewCoins.layer.cornerRadius = 10
        stackViewCoins.translatesAutoresizingMaskIntoConstraints = false
        stackViewCoins.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackViewCoins.isLayoutMarginsRelativeArrangement = true
        addSubview(stackViewCoins)
        stackViewCoins.setTopAnchorConstraint(equalTo: stackView.bottomAnchor, constant: 20)
        stackViewCoins.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackViewCoins.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
    }
    private func verticalStackView(_ listView: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: listView)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}
