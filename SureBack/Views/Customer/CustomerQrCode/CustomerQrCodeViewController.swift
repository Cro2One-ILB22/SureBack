//
//  CustomerQrCodeViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 24/11/22.
//

import UIKit
import PusherSwift

class CustomerQrCodeViewController: UIViewController {

    var purchasePusherService: PurchasePusherSerivce?
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
        purchasePusherService = PurchasePusherSerivce(delegate: self)
        view.backgroundColor = .porcelain
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let user = user else { return }
        purchasePusherService?.requestQRScan(customerId: user.id) { [weak self] response in
            self?.purchasePusherService?.pusherService?.disconnect()
            self?.navigationController?.pushViewController(CustomerPurchaseViewController(merchantId: response.merchantId), animated: true)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        purchasePusherService?.pusherService?.disconnect()
    }
}

extension CustomerQrCodeViewController {
    func setupLabel() {
        view.addSubview(instructionLabel)
        instructionLabel.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        instructionLabel.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        instructionLabel.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
    }

    func setupView() {
        view.addSubview(qrView)
        qrView.translatesAutoresizingMaskIntoConstraints = false
        qrView.setTopAnchorConstraint(equalTo: instructionLabel.bottomAnchor, constant: 20)
        qrView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 15)
        qrView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -15)
    }
}

extension CustomerQrCodeViewController: PusherDelegate {}
