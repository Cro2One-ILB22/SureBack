//
//  RegistrationViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 08/11/22.
//

import UIKit

struct Register {
    let name: String
    let usernameIG: String
    let email: String
    let role: String
    let password: String
    var instagramToDM: String
    var otp: Int
    var otpExpiredIn: Int
}

class FormRegistrationViewController: UIViewController {
    let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Hi! Let's join the \nrewarding program."
        title.font = UIFont.boldSystemFont(ofSize: 22)
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        return title
    }()
    let nameField: CustomTextField = {
        let nameField = CustomTextField(insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        nameField.placeholder = "Name"
        nameField.backgroundColor = .white
        nameField.autocapitalizationType = .none
        return nameField
    }()
    let usernamIGField: CustomTextField = {
        let usernamIGField = CustomTextField(insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        usernamIGField.placeholder = "Instagram Username"
        usernamIGField.backgroundColor = .white
        usernamIGField.autocapitalizationType = .none
        return usernamIGField
    }()
    let emaillField: CustomTextField = {
        let email = CustomTextField(insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        email.placeholder = "Email Address"
        email.backgroundColor = .white
        email.keyboardType = .emailAddress
        email.autocapitalizationType = .none
        return email
    }()
    let passwordField: CustomTextField = {
        let passField = CustomTextField(insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        passField.placeholder = "Password"
        passField.backgroundColor = .white
        passField.autocapitalizationType = .none
        passField.isSecureTextEntry = true
        return passField
    }()
    let confirmPasswordField: CustomTextField = {
        let confirmPassField = CustomTextField(insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        confirmPassField.placeholder = "Your Password, again"
        confirmPassField.backgroundColor = .white
        confirmPassField.autocapitalizationType = .none
        confirmPassField.isSecureTextEntry = true
        return confirmPassField
    }()
    let haveAnAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Have an account, "
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let toSignInLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .tealishGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.isEnabled = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Join", for: .normal)
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
    let emailMessageError: UILabel = {
        let title = UILabel()
        title.text = "Email not valid"
        title.font = .systemFont(ofSize: 13)
        title.textColor = .red
        title.isHidden = true
        return title
    }()
    let igUsernameMessageError: UILabel = {
        let title = UILabel()
        title.text = "Required"
        title.font = .systemFont(ofSize: 13)
        title.textColor = .red
        title.isHidden = true
        return title
    }()
    let passwordMessageError: UILabel = {
        let title = UILabel()
        title.text = "Must be 6-20 characters"
        title.font = .systemFont(ofSize: 13)
        title.textColor = .red
        title.isHidden = true
        return title
    }()
    let confirmPasswordMessageError: UILabel = {
        let title = UILabel()
        title.text = "Password confirmation does not match the password"
        title.font = .systemFont(ofSize: 13)
        title.textColor = .red
        title.isHidden = true
        return title
    }()
    var role: String?
    private let apiRequest = RequestFunction()
    var snackBarMessage: SnackBarMessage?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .porcelain
        if role == "merchant" {
            nameField.placeholder = "Bussiness Name"
        }
        passwordField.enablePasswordToggle()
        confirmPasswordField.enablePasswordToggle()
        setupLayout()
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        toSignInLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(signInTapped)))
        nameField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        usernamIGField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        emaillField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        confirmPasswordField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        snackBarMessage = SnackBarMessage(view: view)
    }
    @objc func signUpTapped() {
        guard let name = nameField.text, !name.isEmpty else {return}
        guard let usernameIG = usernamIGField.text?.lowercased(), !usernameIG.isEmpty else {return}
        guard let email = emaillField.text, !email.isEmpty else {return}
        guard let password = passwordField.text, !password.isEmpty else {return}
        guard let confirmPass = confirmPasswordField.text, !confirmPass.isEmpty else {return}
        guard let role = role else {return}
        let isValidEmail = isValidEmail(email: email)
        if !isValidEmail {
            showValidationMessage(true, messageView: emailMessageError, forField: emaillField)
            return
        } else {
            showValidationMessage(false, messageView: emailMessageError, forField: emaillField)
        }
        if password.count < 6 {
            showValidationMessage(true, messageView: passwordMessageError, forField: passwordField)
            return
        } else {
            showValidationMessage(false, messageView: passwordMessageError, forField: passwordField)
        }
        if password != confirmPass {
            confirmPasswordField.layer.borderColor = UIColor.red.cgColor
            confirmPasswordMessageError.isHidden = false
            return
        }
        present(alertWaiting, animated: true)
        preRegister(name: name, email: email, password: password, role: role, usernameIG: usernameIG)
    }
    private func preRegister(name: String, email: String, password: String, role: String, usernameIG: String) {
        apiRequest.preRegister(name: name, email: email, password: password, role: role, username: usernameIG) { result, statusCode  in
            self.alertWaiting.dismiss(animated: true)
            guard let statusCode = statusCode else {return}
            self.snackBarMessage?.showResponseMessage(statusCode: statusCode)
            guard let instagramToDM = result?.instagramToDM else {return}
            guard let otp = result?.otp else {return}
            guard let otpExpiredIn = result?.expiresIn else {return}
            let confirmRegistVC = ConfirmRegistrationViewController()
            let dataRegister = Register(
                name: name,
                usernameIG: usernameIG,
                email: email,
                role: role,
                password: password,
                instagramToDM: instagramToDM,
                otp: otp,
                otpExpiredIn: otpExpiredIn)
            confirmRegistVC.dataRegister = dataRegister
            self.navigationController?.pushViewController(confirmRegistVC, animated: true)
        }
    }
    @objc func handleTextChanged() {
        guard let name = nameField.text,
              let usernameIG = usernamIGField.text,
              let email = emaillField.text,
              let password = passwordField.text,
              let confirmPass = confirmPasswordField.text else {
            return
        }
        let isFormFilled = !name.isEmpty && !usernameIG.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPass.isEmpty
        if isFormFilled {
            signUpButton.backgroundColor = .tealishGreen
            signUpButton.setTitleColor(.black, for: .normal)
            signUpButton.isEnabled = true
        } else {
            signUpButton.backgroundColor = .gray
            signUpButton.setTitleColor(.white, for: .normal)
            signUpButton.isEnabled = false
        }
    }
    @objc func signInTapped() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }
    private func showValidationMessage(
        _ isShow: Bool,
        messageView view: UILabel,
        forField fieldView: UITextField
    ) {
        fieldView.layer.borderColor = isShow ? UIColor.red.cgColor : UIColor.gray.cgColor
        view.isHidden = !isShow
    }
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
