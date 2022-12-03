//
//  ConfirmRegistrationViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 08/11/22.
//

import UIKit

class ConfirmRegistrationViewController: UIViewController {
    var dataRegister: Register?
    let apiRequest = RequestFunction()
    var expiresOtpIn: Int = 0
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
        label.text = "Expires: 00.00"
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
    var snackBarMessage: SnackBarMessage?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .porcelain
        let otp = dataRegister?.otp ?? 0
        let expiresIn = dataRegister?.otpExpiredIn ?? 299
        otpLabel.text = "\(otp)"
        expiresOtpIn = expiresIn
        setupLayout()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountDown), userInfo: nil, repeats: true)
        surebackInstagramAccountButton.addTarget(self, action: #selector(goToSurebackAccount), for: .touchUpInside)
        checkOtpButton.addTarget(self, action: #selector(checkOtp), for: .touchUpInside)
        copyToClipboard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(copyToClipboardAction)))
        renewCodeButton.addTarget(self, action: #selector(renewCodeAction), for: .touchUpInside)
        snackBarMessage = SnackBarMessage(view: view)
    }
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}

extension ConfirmRegistrationViewController {
    @objc func renewCodeAction() {
        guard let dataRegister = dataRegister else {return}
        print("Tapped")
        present(alertWaiting, animated: true)
        preRegister(name: dataRegister.name, email: dataRegister.email, password: dataRegister.password, role: dataRegister.role, usernameIG: dataRegister.usernameIG)
    }
    private func preRegister(name: String, email: String, password: String, role: String, usernameIG: String) {
        apiRequest.preRegister(name: name, email: email, password: password, role: role, username: usernameIG) { [weak self] result, statusCode  in
            guard let self = self else {return}
            self.alertWaiting.dismiss(animated: true)
            guard let statusCode = statusCode else {return}
            self.snackBarMessage?.showResponseMessage(statusCode: statusCode)
            guard let instagramToDM = result?.instagramToDM else {return}
            guard let otp = result?.otp else {return}
            guard let otpExpiredIn = result?.expiresIn else {return}
            DispatchQueue.main.async {
                self.dataRegister?.otp = otp
                self.dataRegister?.otpExpiredIn = otpExpiredIn
                self.dataRegister?.instagramToDM = instagramToDM
                self.otpLabel.text = "\(otp)"
                self.expiresOtpIn = otpExpiredIn
            }
        }
    }
    @objc func copyToClipboardAction(sender: UITapGestureRecognizer) {
        let otp = dataRegister?.otp ?? 0
        UIPasteboard.general.string = "\(otp)"
        self.showAlert(title: "Successfully", message: "Copy to clipboard", action: "Ok")
    }
    @objc func updateCountDown() {
        if expiresOtpIn > 0 {
            expiresOtpIn -= 1
            expiresLabel.text = "Expires: " + timeString(time: TimeInterval(expiresOtpIn))
            print(expiresOtpIn)
        }
    }
    @objc func goToSurebackAccount() {
        let instagramToDM = dataRegister?.instagramToDM ?? "instagram"
        UIApplication.shared.open(URL(string: "https://www.instagram.com/\(instagramToDM)/?hl=id")!)
    }
    @objc func checkOtp() {
        guard let name = dataRegister?.name, !name.isEmpty else {return}
        guard let usernameIG = dataRegister?.usernameIG, !usernameIG.isEmpty else {return}
        guard let email = dataRegister?.email, !email.isEmpty else {return}
        guard let password = dataRegister?.password, !password.isEmpty else {return}
        guard let role = dataRegister?.role, !role.isEmpty else {return}
        guard let instagraToDM = dataRegister?.instagramToDM else { return }
        present(alertWaiting, animated: true)
        register(name: name, email: email, password: password, role: role, usernameIG: usernameIG, instagraToDM: instagraToDM)
    }
    private func register(
        name: String,
        email: String,
        password: String,
        role: String,
        usernameIG: String,
        instagraToDM: String) {
        apiRequest.register(
            name: name,
            email: email,
            password: password,
            role: role,
            username: usernameIG,
            instagramToDM: instagraToDM) {[weak self] data, statusCode in
//                guard let self = self else {return}
                self?.alertWaiting.dismiss(animated: true)
                guard let statusCode = statusCode else {return}
                self?.snackBarMessage?.showResponseMessage(statusCode: statusCode)
                do {
                    guard let accessToken = data?.accessToken else {return}
                    try KeychainHelper.standard.save(key: .accessToken, value: accessToken)
                } catch {
                    print("Error save token")
                }
                let mainVC = IsLoginViewController()
                self?.navigationController?.pushViewController(mainVC, animated: true)
            }
    }
}
