//
//  ConfirmRegistrationViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 08/11/22.
//

import UIKit

class ConfirmRegistrationViewController: UIViewController {
    var responseOTP: RequestInstagramOTPResponse?
    var dataRegister: Register?
    let title1Label: UILabel = {
        let title = UILabel()
        title.text = "You're almost there!"
        title.numberOfLines = 0
        title.font = UIFont.boldSystemFont(ofSize: 22)
        title.textAlignment = .center
        return title
    }()
    let title2Label: UILabel = {
        let title = UILabel()
        title.text = "Introduce yourself by sending the code \nbelow to our instagram account"
        title.font = UIFont.systemFont(ofSize: 17)
        title.numberOfLines = 0
        title.textAlignment = .center
        return title
    }()
    let otpLabel: UILabel = {
        let otp = UILabel()
        otp.text = "Kosong"
        otp.font = UIFont.boldSystemFont(ofSize: 34)
        otp.textAlignment = .center
        return otp
    }()
    let copyToClipboard: UIImageView = {
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "doc.on.doc.fill.green")
        iconImage.setWidthAnchorConstraint(equalToConstant: 22)
        iconImage.setHeightAnchorConstraint(equalToConstant: 25)
        iconImage.isUserInteractionEnabled = true
        return iconImage
    }()
    let expiresLabel: UILabel = {
        let label = UILabel()
        label.text = "Expires"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let renewCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Renew Code", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    let surebackInstagramAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go to SureBack's account", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    let checkOtpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Already sent it", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 10
        return button
    }()
    var count = 120
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .porcelain
        setupLayout()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountDown), userInfo: nil, repeats: true)
        surebackInstagramAccountButton.addTarget(self, action: #selector(goToSurebackAccount), for: .touchUpInside)
        checkOtpButton.addTarget(self, action: #selector(checkOtp), for: .touchUpInside)
        copyToClipboard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(copyToClipboardAction)))
        renewCodeButton.addTarget(self, action: #selector(renewCodeAction), for: .touchUpInside)
    }
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}

extension ConfirmRegistrationViewController {
    @objc func renewCodeAction() {
        print("Tapped renew code action")
    }
    @objc func copyToClipboardAction(sender: UITapGestureRecognizer) {
        print("Tapped copy")
        UIPasteboard.general.string = "Ini adalah text yang berhasil dicopy"
        self.showAlert(title: "Successfully", message: "Copy to clipboard", action: "Ok")
    }
    @objc func updateCountDown() {
        if count > 0 {
            count -= 1
            expiresLabel.text = "Expires: " + timeString(time: TimeInterval(count))
        }
    }
    @objc func goToSurebackAccount() {
        print("go to tapped")
        UIApplication.shared.open(URL(string: "https://www.instagram.com/sureback.id/?hl=id")!)
    }
    @objc func checkOtp() {
        print("Tapped")
        guard let name = dataRegister?.name, !name.isEmpty else {return}
        guard let usernameIG = dataRegister?.usernameIG, !usernameIG.isEmpty else {return}
        guard let email = dataRegister?.email, !email.isEmpty else {return}
        guard let password = dataRegister?.password, !password.isEmpty else {return}
        guard let role = dataRegister?.role, !role.isEmpty else {return}
        let request = RequestFunction()
        request.register(
            name: name,
            email: email,
            password: password,
            role: role,
            username: usernameIG) { data, error in
                if error != nil {
                    self.showAlert(title: "Error", message: error?.localizedDescription ?? "", action: "Okey")
                    return
                }
                let mainVC = IsLoginViewController()
                self.navigationController?.pushViewController(mainVC, animated: true)
            }
    }
}
