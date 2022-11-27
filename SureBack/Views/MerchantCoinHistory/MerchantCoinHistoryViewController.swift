//
//  MerchantCoinHistoryViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 18/11/22.
//

import UIKit

// MARK: BELOM SELESAI
class MerchantCoinHistoryViewController: UIViewController {

    private let outstandingCoinCard: DetailCoinHistoryCardView = {
       let card = DetailCoinHistoryCardView()
        return card
    }()
    private let exchangedCoinCard: DetailCoinHistoryCardView = {
       let card = DetailCoinHistoryCardView()
        return card
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(outstandingCoinCard)
        outstandingCoinCard.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        outstandingCoinCard.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 16)
        outstandingCoinCard.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
        outstandingCoinCard.setHeightAnchorConstraint(equalToConstant: 80)
        outstandingCoinCard.setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth)
        
        view.addSubview(exchangedCoinCard)
        exchangedCoinCard.setTopAnchorConstraint(equalTo: outstandingCoinCard.bottomAnchor, constant: 20)
        exchangedCoinCard.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 16)
        exchangedCoinCard.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
        exchangedCoinCard.setHeightAnchorConstraint(equalToConstant: 80)
        exchangedCoinCard.setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth)
    }
}
