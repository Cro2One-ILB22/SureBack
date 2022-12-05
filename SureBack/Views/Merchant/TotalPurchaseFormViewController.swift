//
//  TotalPurchaseFormViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 05/12/22.
//

import UIKit

class TotalPurchaseFormViewController: CommonSheetViewController {
    var totalPurchase: String?
    let information: UILabel = {
        let label = UILabel()
        label.text = "Please pay attention to the nominal that you will input."
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    let totalPurchaseField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Rp."
        textField.keyboardType = .numberPad
        textField.textContentType = .telephoneNumber
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 60).isActive = true
        return textField
    }()
    let confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .tealishGreen
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Confirm", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 10
        return button
    }()
    let alertWaiting: UIAlertController = {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        return alert
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        totalPurchaseField.text = totalPurchase ?? ""
        view.backgroundColor = .porcelain
        titleLabel.text = "Total Purchase"
        setupLayout()
        confirmButton.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
    }
    @objc func didTapConfirm() {
        guard let totalPurchase = totalPurchaseField.text else {return}
        if totalPurchase.isEmpty {
            self.showAlert(title: "Total Purchase", message: "Please input total purchase", action: "Okey")
            return
        }
        self.showAlert(title: "Total Purchase Confirmed", message: "Make sure the nominal is correct", action: "Done") { _ in
            // Pindah ke halaman detail purchase
        }
    }

}

extension TotalPurchaseFormViewController {
    func setupLayout() {
        view.addSubview(information)
        information.translatesAutoresizingMaskIntoConstraints = false
        information.setTopAnchorConstraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        information.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        information.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
        
        view.addSubview(totalPurchaseField)
        totalPurchaseField.translatesAutoresizingMaskIntoConstraints = false
        totalPurchaseField.setTopAnchorConstraint(equalTo: information.bottomAnchor, constant: 8)
        totalPurchaseField.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        totalPurchaseField.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
        
        view.addSubview(confirmButton)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.setTopAnchorConstraint(equalTo: totalPurchaseField.bottomAnchor, constant: 8)
        confirmButton.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 20)
        confirmButton.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -20)
    }
}
