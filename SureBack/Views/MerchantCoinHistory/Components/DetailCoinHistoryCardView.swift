//
//  CoinHistoryCardView.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 18/11/22.
//

import UIKit

class DetailCoinHistoryCardView: UIView {
    lazy var titleLabel: UIButton = {
       let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Title", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.backgroundColor = .iceBerg
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.osloGray.cgColor
        return button
    }()
    lazy var totalThisMonthCoinLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var totalThisWeekCoinLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var totalTodayCoinLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var thisMonthText: UILabel = {
       let label = UILabel()
        label.text = "This Month"
        label.textColor = .osloGray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    lazy var thisWeekText: UILabel = {
       let label = UILabel()
        label.text = "This Week"
        label.textColor = .osloGray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    lazy var todayText: UILabel = {
       let label = UILabel()
        label.text = "Today"
        label.textColor = .osloGray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    private let borderView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        borderView.layer.borderColor = UIColor.gray.cgColor
        borderView.layer.borderWidth = 1
        borderView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        borderView.frame = bounds
        borderView.layer.cornerRadius = 8
        addSubview(borderView)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }
    private func setupLayout() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setTopAnchorConstraint(equalTo: topAnchor, constant: -15)
        titleLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 8)
        let separator = UIView()
        separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        separator.backgroundColor = .black

        let thisMonthStackView = verticalStackView([totalThisMonthCoinLabel, separator, thisMonthText])
        let thisWeekStackView = verticalStackView([totalThisWeekCoinLabel, thisWeekText])
        let todayStackView = verticalStackView([totalTodayCoinLabel, todayText])

        let stackView = UIStackView(arrangedSubviews: [thisMonthStackView, thisWeekStackView, todayStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: titleLabel.bottomAnchor, constant: 7)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        stackView.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -4)
    }
    private func verticalStackView(_ listView: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: listView)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 1
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

}

