//
//  CustomerPurchaseSecondView.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 03/12/22.
//

import UIKit

class CustomerPurchaseSecondView: UIView {

    let totalPurchaseLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Purchase"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let totalPurchaseValue: UILabel = {
        let label = UILabel()
        label.text = "Waiting for Merchant"
        label.font = .italicSystemFont(ofSize: 15)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let coinUsedLabel: UILabel = {
        let label = UILabel()
        label.text = "Coin Used"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let coinUsedValue: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let totalPaymentLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Payment"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let totalPaymentValue: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let coinBalanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Coin Balance Left"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let coinBalanceValue: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

//    let line: UIView = {
//        let viewLine = UIView()
//        viewLine.backgroundColor = .black
//        viewLine.translatesAutoresizingMaskIntoConstraints = false
//        return viewLine
//    }()

    let noteLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Notes:
        - The coins used are only multiples 1,000
        - The coin that is used the maximum is the same with total spending
        """
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 17)
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

extension CustomerPurchaseSecondView {
    func setupView() {
        setupDetails()
    }
    func setupDetails() {
        let stackTotalPurchase = setupTotalPurchase()
        let stackCoinUsed = setupCoinUsed()
        let stackTotalPayment = setupTotalPayment()
        let stackCoinBalance = setupCoinBalance()

//        let line = UIView(frame: CGRect(x: 0, y: 100, width: frame.size.width, height: 2))
//        line.backgroundColor = .black
        
        let stackview = UIStackView(arrangedSubviews: [stackTotalPurchase, stackCoinUsed, stackTotalPayment, stackCoinBalance, noteLabel])
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
        stackview.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -10)
        stackview.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 10)
    }

    func setupTotalPurchase() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [totalPurchaseLabel, totalPurchaseValue])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }
    func setupCoinUsed() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [coinUsedLabel, coinUsedValue])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }
    func setupTotalPayment() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [totalPaymentLabel, totalPaymentValue])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }
    func setupCoinBalance() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [coinBalanceLabel, coinBalanceValue])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }
}
