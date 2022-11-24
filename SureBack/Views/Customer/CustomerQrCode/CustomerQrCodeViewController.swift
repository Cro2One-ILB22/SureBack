//
//  CustomerQrCodeViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 24/11/22.
//

import UIKit

class CustomerQrCodeViewController: UIViewController {

    var user: UserInfoResponse?
    let function = Function()

    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Please share this code to the merchant to request token."
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .justified
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var qrView: CustomerQRView = {
        let view = CustomerQRView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLabel()
        setupView()

        guard let user = user else {
            return
        }

        qrView.dateLabel.text = Date().dateToString()
        qrView.usernameLabel.text = "@\(user.instagramUsername)"

        do {
            let tryJSON = try JSONEncoder().encode(user.id)
            let stringJSON = String(data: tryJSON, encoding: .utf8)
            print("stringJSON : \(stringJSON)")
            qrView.qrImage.image = function.generateQR(stringJSON: stringJSON ?? "")
        } catch let error as NSError {
            print(error.description)
        }
    }
}

extension CustomerQrCodeViewController {
    func setupLabel() {
        view.addSubview(instructionLabel)
        instructionLabel.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        instructionLabel.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        instructionLabel.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
    }

    func setupView() {
        view.addSubview(qrView)
        qrView.translatesAutoresizingMaskIntoConstraints = false
        qrView.setTopAnchorConstraint(equalTo: instructionLabel.bottomAnchor, constant: 20)
        qrView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 15)
        qrView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -15)
//        qrView.setBottomAnchorConstraint(equalTo: view.bottomAnchor, constant: -20)
    }
}
