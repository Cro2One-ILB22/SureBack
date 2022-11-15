//
//  MerchantGenerateTokenViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 09/11/22.
//

import Foundation
import UIKit

protocol SendDataDelegate: AnyObject {
    func passData(data: String)
}

class MerchantGenerateTokenViewController: UIViewController, SendDataDelegate {
    let request = RequestFunction()

    var stringJSON: String = ""

    let totalPurchaseLabel: UILabel = {
        let label = UILabel()
        label.text = "Input the customer’s total purchase."
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let totalPurchaseField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Total Purchase"
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 60).isActive = true
        return textField
    }()

    let scanButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitle("Scan QR Code", for: .normal)
        button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 60).isActive = true
        return button
    }()

    let shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitle("Share Token Code", for: .normal)
        button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 60).isActive = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

//        request.postLogin(email: "av@sampolain.com", password: "hahahahah") { data in
//            print(data)
//        }

        setupTotalPurchase()
        setupButton()
        scanButton.addTarget(self, action: #selector(scanQrButtonAction), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareTokenButtonAction), for: .touchUpInside)
    }

    @objc func scanQrButtonAction(sender: UIButton!) {
        print("Button Scan QR Customer ID tapped")
        let scanQrVC = ScanQrViewController()
        scanQrVC.delegate = self
        navigationController?.pushViewController(scanQrVC, animated: true)
    }

    @objc func shareTokenButtonAction(sender: UIButton!) {
        print("Button Share Token tapped")
    }

    func passData(data: String) {
        stringJSON = data
        print("get data json \(stringJSON)")

        guard let totalPurchase = totalPurchaseField.text, let totalPurchase = Int(totalPurchase) else {
            return
        }

        do {
            let jsonData = stringJSON.data(using: .utf8)!
            var dataQr: QRData = try! JSONDecoder().decode(QRData.self, from: jsonData)

            request.postGenerateTokenOffline(customerId: dataQr.customerID, purchaseAmount: totalPurchase, isRequestingToken: 0) { data in
                print(data)
                switch data {
                case .success:
                    print("Success to generate token")
                case let .failure(error):
                    print("Failed to generate token")
                    print(error.localizedDescription)
                }
            }

        } catch let error as NSError {
            print(error.description)
        }
    }
}

extension MerchantGenerateTokenViewController {
    private func setupTotalPurchase() {
        let stackView = UIStackView(arrangedSubviews: [totalPurchaseLabel, totalPurchaseField])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        stackView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 30)
    }

    private func setupButton() {
        let stackView = UIStackView(arrangedSubviews: [scanButton, shareButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: totalPurchaseField.bottomAnchor, constant: 40)
        stackView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 30)
    }
}
