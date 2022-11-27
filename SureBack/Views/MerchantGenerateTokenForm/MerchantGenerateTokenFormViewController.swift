//
//  MerchantGenerateTokenFormViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 28/11/22.
//

import UIKit

class MerchantGenerateTokenFormViewController: UIViewController {
    let coinTransactionTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Coin Transaction"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let customerNameTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Customer name"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let purchaseDateTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Purchase date"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let percentageTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Percentage"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let expiredDateTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Expired Date"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let exchangedCoinTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Exchanged Coins"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .osloGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let totalPurchaseTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Purchase"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let customerNameValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let purchaseDateValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let percentageValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let expiredDateValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let exchangedCoinValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let totalPurchaseField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Total Purchase"
        textField.textContentType = .telephoneNumber
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 60).isActive = true
        return textField
    }()
    let generateTokenButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .tealishGreen
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Generate Token", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 10
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .porcelain
        setupLayout()
        generateTokenButton.addTarget(self, action: #selector(generateTokenAction), for: .touchUpInside)
    }
    @objc func generateTokenAction() {
        print("Tapped")
    }

}
