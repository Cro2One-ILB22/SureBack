//
//  CoinHistoryCardView.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 10/11/22.
//

import UIKit

class CoinHistoryCardView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
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
        backgroundColor = .gray
        layer.cornerRadius = 30
        setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth)
        setHeightAnchorConstraint(equalToConstant: 120)
        translatesAutoresizingMaskIntoConstraints = false
        setupTitleLabel()
        setupTotalLabel()
    }
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.setTopAnchorConstraint(equalTo: topAnchor, constant: 20)
        titleLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor)
        titleLabel.setTrailingAnchorConstraint(equalTo: trailingAnchor)
    }
    private func setupTotalLabel() {
        addSubview(totalLabel)
        totalLabel.setTopAnchorConstraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        totalLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor)
        totalLabel.setTrailingAnchorConstraint(equalTo: trailingAnchor)
    }
}
