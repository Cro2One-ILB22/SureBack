//
//  ShowQRViewController3.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 07/11/22.
//

import Foundation
import UIKit

struct QRData: Codable {
    var customerID: Int
    var points: Int
    var isTokenActive: Bool

    enum CodingKeys: String, CodingKey {
        case customerID = "customer_id"
        case points
        case isTokenActive = "is_token_active"
    }
}

class ShowQRViewController: UIViewController {
    var user: UserInfoResponse?

    var isTokenActive = true

    let function = Function()
    let request = RequestFunction()

    var customerID: Int?

    let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Balance"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let balanceTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let getTokenLabel: UILabel = {
        let label = UILabel()
        label.text = "Get Token"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let getTokenSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()

    let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Amount"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let amountTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let buttonGenerate: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        button.backgroundColor = .blue
        button.layer.cornerRadius = 15
        button.setTitle("Show QR Code", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let stackView = mainStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .white
        view.addSubview(stackView)

        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true

        getTokenSwitch.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        getTokenSwitch.setOn(true, animated: false)

        buttonGenerate.addTarget(self, action: #selector(generateQrButtonAction), for: .touchUpInside)

        guard let user = user else {
            return
        }
        balanceTextField.text = String(user.balance)
    }

    func mainStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [balanceLabel,
                                                       balanceTextField,
                                                       getTokenLabel,
                                                       getTokenSwitch,
                                                       amountLabel,
                                                       amountTextField,
                                                       buttonGenerate])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }

    @objc func switchStateDidChange(_ sender: UISwitch!) {
        isTokenActive = sender.isOn
    }

    @objc func generateQrButtonAction(sender: UIButton!) {
        print("Button Generate QR tapped")

        guard let user = user, let coins = amountTextField.text, let coins = Int(coins) else {
            return
        }

        var dataQr: QRData = QRData(customerID: user.id, points: coins, isTokenActive: isTokenActive)

        do {
            let tryJSON = try JSONEncoder().encode(dataQr)
            let stringJSON = String(data: tryJSON, encoding: .utf8)
            print(stringJSON)
            generateQrImage(stringJSON: stringJSON!)
        } catch let error as NSError {
            print(error.description)
        }
    }

    func generateQrImage(stringJSON: String) {
        let qrCodeImageView = UIImageView(image: function.generateQR(stringJSON: stringJSON))
        view.addSubview(qrCodeImageView)
        qrCodeImageView.frame = CGRect(x: 100, y: 500, width: 200, height: 200)
        qrCodeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        qrCodeImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100).isActive = true
    }
}
