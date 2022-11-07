//
//  LoginViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 05/11/22.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    let request = RequestFunction()

    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Let's join \nthe rewarding program!"
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()

    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email"
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.isSecureTextEntry = true
        return textField
    }()

    let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Haven't sign up yet?"
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let toRegisterLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .blue
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let stackView = mainStackView()

        view.backgroundColor = .white
        view.addSubview(titleTextView)
        view.addSubview(stackView)
        view.addSubview(firstLabel)
        view.addSubview(toRegisterLabel)
        view.addSubview(loginButton)

        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        let registerTapped = UITapGestureRecognizer(target: self, action: #selector(registerButtonTapped))
        toRegisterLabel.addGestureRecognizer(registerTapped)
        toRegisterLabel.isUserInteractionEnabled = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: titleTextView.topAnchor, constant: 120).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true

        firstLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 100).isActive = true
        firstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        firstLabel.trailingAnchor.constraint(equalTo: toRegisterLabel.leadingAnchor).isActive = true

        toRegisterLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 100).isActive = true
        toRegisterLabel.leadingAnchor.constraint(equalTo: firstLabel.trailingAnchor).isActive = true
        toRegisterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true

        setupLayout()
    }

    private func setupLayout() {
        titleTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        titleTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        titleTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }

    func mainStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [emailTextField,
                                                       passwordTextField])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }

    @objc func loginButtonTapped() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return print("email or password is nil")
        }
        if email.isEmpty || password.isEmpty {
            let alert = UIAlertController(title: "Failed to Login", message: "Please fill all field!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Try Again", comment: "Default action"), style: .default))
            present(alert, animated: true, completion: nil)
        }
        request.postLogin(email: email.lowercased(), password: password) { data in
            print(data)
            switch data {
            case .success:
                let mainScreenVC = DummyViewController()
                mainScreenVC.title = "Dummy Main Screen"
                let alert = UIAlertController(title: "Success", message: "your login success", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    self.navigationController?.pushViewController(mainScreenVC, animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            case .failure:
                print("Failed to Login")
                let alert = UIAlertController(title: "Wrong Email or Password", message: "please try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Try Again", comment: "Default action"), style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    @objc func registerButtonTapped(sender: UITapGestureRecognizer) {
        let registerVC = DummyViewController()
        registerVC.title = "Dummy Register"
        navigationController?.pushViewController(registerVC, animated: true)
    }
}
