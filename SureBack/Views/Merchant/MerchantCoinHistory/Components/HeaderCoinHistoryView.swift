//
//  HeaderCoinHistoryView.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 27/11/22.
//

import UIKit

class HeaderCoinHistoryView: UIView {
    let title: UILabel = {
       let label = UILabel()
        label.text = "Coin History Summary"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    let outstandingCoinCard: DetailCoinHistoryCardView = {
       let card = DetailCoinHistoryCardView()
        card.titleLabel.setTitle("Outstanding Coin", for: .normal)
        return card
    }()
    let exchangedCoinCard: DetailCoinHistoryCardView = {
       let card = DetailCoinHistoryCardView()
        card.titleLabel.setTitle("Exchanged Coin", for: .normal)
        return card
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderCoinHistoryView {
    func setupLayout() {
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.setTopAnchorConstraint(equalTo: topAnchor, constant: 16)
        title.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 16)
        title.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -16)
        
        addSubview(outstandingCoinCard)
        outstandingCoinCard.setTopAnchorConstraint(equalTo: title.bottomAnchor, constant: 30)
        outstandingCoinCard.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 16)
        outstandingCoinCard.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -16)
        outstandingCoinCard.setHeightAnchorConstraint(equalToConstant: 80)
        outstandingCoinCard.setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth)

        addSubview(exchangedCoinCard)
        exchangedCoinCard.setTopAnchorConstraint(equalTo: outstandingCoinCard.bottomAnchor, constant: 20)
        exchangedCoinCard.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 16)
        exchangedCoinCard.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -16)
        exchangedCoinCard.setHeightAnchorConstraint(equalToConstant: 80)
        exchangedCoinCard.setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth)
    }
}
