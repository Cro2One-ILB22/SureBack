//
//  ChooseRoleRegistrationViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 30/11/22.
//

import UIKit

class ChooseRoleRegistrationViewController: UIViewController {
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "O! Wait, we need to get\nto know you"
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        return label
    }()
    let cardRoleMerchant: CardRoleView = {
        let card = CardRoleView()
        card.imageRole.image = UIImage(named: "merchant.option")
        card.titleRole.text = "I'm a culinary\nbusinessman"
        card.setWidthAnchorConstraint(equalToConstant: 155)
        card.setHeightAnchorConstraint(equalToConstant: 196)
        return card
    }()
    let cardRoleCustomer: CardRoleView = {
        let card = CardRoleView()
        card.imageRole.image = UIImage(named: "customer.option")
        card.titleRole.text = "I'm just a foodie"
        card.setWidthAnchorConstraint(equalToConstant: 155)
        card.setHeightAnchorConstraint(equalToConstant: 196)
        return card
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .porcelain
        setupLayout()
        cardRoleMerchant.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseRole)))
        cardRoleCustomer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseRole)))
    }
    @objc func chooseRole(sender: UITapGestureRecognizer) {
        var role: String?
        if sender.view == cardRoleMerchant {
            role = "merchant"
        } else {
            role = "customer"
        }
        guard let role = role else {return}
        let formRegistVC = FormRegistrationViewController()
        formRegistVC.role = role
        navigationController?.pushViewController(formRegistVC, animated: true)
    }

}

extension ChooseRoleRegistrationViewController {
    func setupLayout() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80)
        titleLabel.setLeadingAnchorConstraint(equalTo: view.leadingAnchor)
        titleLabel.setTrailingAnchorConstraint(equalTo: view.trailingAnchor)
        let stackView = UIStackView(arrangedSubviews: [cardRoleMerchant, cardRoleCustomer])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        stackView.alignment = .center
        view.addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: titleLabel.bottomAnchor, constant: 16)
        stackView.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
    }
}
