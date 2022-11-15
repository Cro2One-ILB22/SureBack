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
}

class RegistrationViewController: UIViewController {
    private let titleTextView: UITextView = {
        let title = UITextView()
        title.text = "Hi! Let's join the \nrewarding program."
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.isEditable = false
        title.isScrollEnabled = false
        return title
    }()
    private let nameField: UITextField = {
        let nameField = UITextField()
        nameField.placeholder = "Name"
        nameField.layer.borderWidth = 1
        nameField.layer.borderColor = UIColor.black.cgColor
        return nameField
    }()
    private let usernamIGField: UITextField = {
        let usernamIGField = UITextField()
        usernamIGField.placeholder = "IG Username"
        usernamIGField.layer.borderWidth = 1
        usernamIGField.layer.borderColor = UIColor.black.cgColor
        return usernamIGField
    }()
    private let emaillField: UITextField = {
        let email = UITextField()
        email.placeholder = "Email"
        email.layer.borderWidth = 1
        email.layer.borderColor = UIColor.black.cgColor
        return email
    }()
    private let passwordField: UITextField = {
        let passField = UITextField()
        passField.placeholder = "Password"
        passField.layer.borderWidth = 1
        passField.isSecureTextEntry = true
        passField.layer.borderColor = UIColor.black.cgColor
        return passField
    }()
    private let confirmPasswordField: UITextField = {
        let confirmPassField = UITextField()
        confirmPassField.placeholder = "Confirm Password"
        confirmPassField.layer.borderWidth = 1
        confirmPassField.isSecureTextEntry = true
        confirmPassField.layer.borderColor = UIColor.black.cgColor
        return confirmPassField
    }()
    private let haveAnAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Have an account, "
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let toSignInLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    private let signUpButton: UIButton = {
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
    private let roleSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["customer", "seller"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return segmentedControl
    }()
    private let loadingIndicator: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.style = .gray
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.isHidden = true
        return loading
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTitle()
        setupTextFields()
        setupAlreadyHaveAccount()
        setupButton()
        setupLoadingIndicator()
        setupRoleSegmentedControl()
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        toSignInLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(signInTapped)))
        nameField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        usernamIGField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        emaillField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        confirmPasswordField.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
    }
    @objc func signUpTapped() {
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
        guard let name = nameField.text, !name.isEmpty else {return}
        guard let usernameIG = usernamIGField.text?.lowercased(), !usernameIG.isEmpty else {return}
        guard let email = emaillField.text, !email.isEmpty else {return}
        guard let password = passwordField.text, !password.isEmpty else {return}
        guard let confirmPass = confirmPasswordField.text, !confirmPass.isEmpty else {return}
        guard let role = roleSegmentedControl.titleForSegment(at: roleSegmentedControl.selectedSegmentIndex) else {return}
        print(role)
        let request = RequestFunction()
        request.preRegister(name: name, email: email, password: password, role: role, username: usernameIG) { result, error  in
            if error != nil {
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden = true
                self.showAlert(title: "Error", message: error?.localizedDescription ?? "", action: "Oke")
                return
            }
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
            print(result)
            let confirmRegistVC = ConfirmRegistrationViewController()
            let dataRegister = Register(
                name: name,
                usernameIG: usernameIG,
                email: email,
                role: role,
                password: password)
            confirmRegistVC.responseOTP = result
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
            signUpButton.backgroundColor = .blue
            signUpButton.isEnabled = true
        } else {
            signUpButton.backgroundColor = .gray
            signUpButton.isEnabled = false
        }
    }
    @objc func signInTapped() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension RegistrationViewController {
    private func setupTitle() {
        view.addSubview(titleTextView)
        titleTextView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        titleTextView.setLeftAnchorConstraint(equalTo: view.leftAnchor)
        titleTextView.setRightAnchorConstraint(equalTo: view.rightAnchor)
    }
    private func setupTextFields() {
        let stackView = UIStackView(arrangedSubviews: [nameField, usernamIGField, emaillField, passwordField, confirmPasswordField])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: titleTextView.bottomAnchor, constant: 50)
        stackView.setLeftAnchorConstraint(equalTo: view.leftAnchor, constant: 40)
        stackView.setRightAnchorConstraint(equalTo: view.rightAnchor, constant: -40)
        stackView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    private func setupAlreadyHaveAccount() {
        let stackView = UIStackView(arrangedSubviews: [haveAnAccountLabel, toSignInLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: confirmPasswordField.bottomAnchor, constant: 10)
        stackView.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
    }
    private func setupButton() {
        view.addSubview(signUpButton)
        signUpButton.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 40)
        signUpButton.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -40)
        signUpButton.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    }
    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
        loadingIndicator.setCenterYAnchorConstraint(equalTo: view.centerYAnchor)
    }
    private func setupRoleSegmentedControl() {
        view.addSubview(roleSegmentedControl)
        roleSegmentedControl.setTopAnchorConstraint(equalTo: haveAnAccountLabel.bottomAnchor, constant: 10)
        roleSegmentedControl.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
    }
}
