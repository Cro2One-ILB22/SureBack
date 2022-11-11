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
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Total coin tokens you \ngenerated"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var totalTokenLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "0 Token"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var stillAcceptingCustomerLabel: UILabel = {
       let label = UILabel()
        label.text = "Still accepting customers"
        return label
    }()
    lazy var switchButton: UISwitch = {
       let switchButton = UISwitch()
        switchButton.setOn(true, animated: false)
        return switchButton
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
        setupLabel1()
        setupLabel2()
    }
    private func setupLabel1() {
        let stackView = UIStackView(arrangedSubviews: [label, totalTokenLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 20)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
    }
    private func setupLabel2() {
        let stackView = UIStackView(arrangedSubviews: [stillAcceptingCustomerLabel, switchButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        stackView.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -20)
    }
}
