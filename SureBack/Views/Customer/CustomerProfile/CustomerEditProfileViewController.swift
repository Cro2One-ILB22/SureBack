//
//  CustomerEditProfileViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 26/11/22.
//

import RxSwift
import SDWebImage
import UIKit

class CustomerEditProfileViewController: UIViewController {
    let request = RequestFunction()

    let viewModel = UserViewModel.shared
//    var user: UserInfoResponse?

    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Name"
        return label
    }()

    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Email Address"
        return label
    }()

    lazy var nameTextField: CustomTextField = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
    lazy var emailTextField: CustomTextField = CustomTextField(insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))

//    init() {
//        super.init(nibName: nil, bundle: nil)
//        self.user = viewModel.user
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true

        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton

        setupLayout()
        configure()
    }

    func configure() {

        guard let user = viewModel.user else {return}

        profileImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        profileImage.sd_setImage(
            with: URL(string: user.profilePicture  ?? ""),
            placeholderImage: UIImage(named: "system.photo"),
            options: .progressiveLoad,
            completed: nil
        )
        nameTextField.text = user.name
        emailTextField.text = user.email
    }

    @objc func saveButtonTapped() {
        print("Save Button tapped")

        guard let user = viewModel.user else {return}

        if let email = emailTextField.text, let name = nameTextField.text {
            request.updateUser(name: name, email: email != user.email ? email : nil) { _ in
                print("successfully update user data")
                user.email = email
                user.name = name
                self.viewModel.userSubject.on(.next(user)) //published user yg berubah
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension CustomerEditProfileViewController {
    private func setupLayout() {
        setupImage()
        setupTextField()
    }

    private func setupImage() {
        view.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        profileImage.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
        profileImage.setHeightAnchorConstraint(equalToConstant: 80)
        profileImage.setWidthAnchorConstraint(equalToConstant: 80)
    }

    private func setupTextField() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField, emailLabel, emailTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: profileImage.bottomAnchor, constant: 30)
        stackView.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        stackView.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)

        nameTextField.setHeightAnchorConstraint(equalToConstant: 40)
        emailTextField.setHeightAnchorConstraint(equalToConstant: 40)
    }
}
