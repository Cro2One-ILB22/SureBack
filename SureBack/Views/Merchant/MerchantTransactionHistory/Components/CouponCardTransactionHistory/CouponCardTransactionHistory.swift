//
//  CouponCardTransactionHIstory.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 28/11/22.
//

import UIKit

class CouponCardTransactionHistory: UIView {
    private let widthLabel = CGFloat(120)
    lazy var coupon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "coupon")
        image.contentMode = .scaleAspectFill
        return image
    }()
    lazy var merchantLabel: UILabel = {
        let label = UILabel()
        label.text = "Merchant"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var tokenIdValueLabel: UILabel = {
        let label = UILabel()
        label.text = "TOKENID"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    lazy var dateCreatedLabel: UILabel = {
        let label = UILabel()
        label.text = "Date created"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    lazy var customerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Customer"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidthAnchorConstraint(equalToConstant: widthLabel)
        return label
    }()

    lazy var customerNameValue: UILabel = {
        let label = UILabel()
        label.text = "Customer name"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var purchaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Purchase Date"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidthAnchorConstraint(equalToConstant: widthLabel)
        return label
    }()

    lazy var purchaseDateValue: UILabel = {
        let label = UILabel()
        label.text = "4 Nov 2022, 11:00 AM"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Percentage"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidthAnchorConstraint(equalToConstant: widthLabel)
        return label
    }()

    lazy var percentageValue: UILabel = {
        let label = UILabel()
        label.text = "10%"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var expiredDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Expired Date"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidthAnchorConstraint(equalToConstant: widthLabel)
        return label
    }()

    lazy var expiredDateValue: UILabel = {
        let label = UILabel()
        label.text = "11 Nov 2022, 11:02 PM"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var exchangedCoinLabel: UILabel = {
        let label = UILabel()
        label.text = "Exchanged Coin"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidthAnchorConstraint(equalToConstant: widthLabel)
        return label
    }()

    lazy var exchangedCoinValue: UILabel = {
        let label = UILabel()
        label.text = "3,000"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var totalPurchaseLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Purchase"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidthAnchorConstraint(equalToConstant: widthLabel)
        return label
    }()

    lazy var totalPurchaseValue: UILabel = {
        let label = UILabel()
        label.text = "Rp200,000"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var coinLabel: UILabel = {
        let label = UILabel()
        label.text = "Coin"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidthAnchorConstraint(equalToConstant: widthLabel)
        return label
    }()
    lazy var coinValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var customerPayLabel: UILabel = {
        let label = UILabel()
        label.text = "Customer Pay"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidthAnchorConstraint(equalToConstant: widthLabel)
        return label
    }()
    lazy var customerPayValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var cashbackCoinLabel: UILabel = {
        let label = UILabel()
        label.text = "Cashback Coins"
        label.font = UIFont.systemFont(ofSize: 15)
//        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setWidthAnchorConstraint(equalToConstant: widthLabel)
        return label
    }()
    lazy var cashbackCoinValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
