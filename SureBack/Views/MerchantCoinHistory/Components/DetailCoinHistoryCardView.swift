//
//  CoinHistoryCardView.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 18/11/22.
//

import UIKit

class DetailCoinHistoryCardView: UIView {
    lazy var titleCoin: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Title Coin"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var totalThisMonthCoinLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var totalThisWeekCoinLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var totalTodayCoinLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var thisMonthText: UILabel = {
       let label = UILabel()
        label.text = "This Month"
        return label
    }()
    lazy var thisWeekText: UILabel = {
       let label = UILabel()
        label.text = "This Week"
        return label
    }()
    lazy var todayText: UILabel = {
       let label = UILabel()
        label.text = "Today"
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
        translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }
    private func setupLayout() {
        addSubview(titleCoin)
        titleCoin.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        titleCoin.setLeadingAnchorConstraint(equalTo: leadingAnchor)
        titleCoin.setTrailingAnchorConstraint(equalTo: trailingAnchor)
        
        let thisMonthStackView = verticalStackView([totalThisMonthCoinLabel, thisMonthText])
        let thisWeekStackView = verticalStackView([totalThisWeekCoinLabel, thisWeekText])
        let todayStackView = verticalStackView([totalTodayCoinLabel, todayText])
        
        let stackView = UIStackView(arrangedSubviews: [thisMonthStackView, thisWeekStackView, todayStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: titleCoin.bottomAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
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
