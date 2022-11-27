//
//  HeaderMerchantDetailStoryView.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 17/11/22.
//

import UIKit

class HeaderMerchantDetailStoryView: UIView {
    let imageUser: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "AppIcon")
        image.layer.masksToBounds = false
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        return image
    }()
    let nameUser: UILabel = {
        let label = UILabel()
        label.text = "@username"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    let usernameIGUser: UILabel = {
        let label = UILabel()
        label.text = "Username IG"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    let timesVisitUser: UILabel = {
        let label = UILabel()
        label.text = "Times visit"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    let followersUser: UILabel = {
        let label = UILabel()
        label.text = "10K"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    private let textFollowers: UILabel = {
        let label = UILabel()
        label.text = "Followers"
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .porcelain
        setupLayouts()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderMerchantDetailStoryView {
    private func setupLayouts() {
        let stackView = UIStackView(arrangedSubviews: [followersUser, textFollowers])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = -10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 25)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        
        addSubview(imageUser)
        imageUser.translatesAutoresizingMaskIntoConstraints = false
        imageUser.setTopAnchorConstraint(equalTo: topAnchor, constant: 20)
        imageUser.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        imageUser.setWidthAnchorConstraint(equalToConstant: 75)
        imageUser.setHeightAnchorConstraint(equalToConstant: 75)
        imageUser.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -20)
        
        addSubview(nameUser)
        nameUser.translatesAutoresizingMaskIntoConstraints = false
        nameUser.setTopAnchorConstraint(equalTo: topAnchor, constant: 20)
        nameUser.setLeadingAnchorConstraint(equalTo: imageUser.trailingAnchor, constant: 20)
        // trailing
        nameUser.setTrailingAnchorConstraint(equalTo: followersUser.leadingAnchor, constant: -10)
        nameUser.setWidthAnchorConstraint(equalToConstant: 180)
        
        addSubview(usernameIGUser)
        usernameIGUser.translatesAutoresizingMaskIntoConstraints = false
        usernameIGUser.setTopAnchorConstraint(equalTo: nameUser.bottomAnchor, constant: 5)
        usernameIGUser.setLeadingAnchorConstraint(equalTo: imageUser.trailingAnchor, constant: 20)
        // trailing
        usernameIGUser.setTrailingAnchorConstraint(equalTo: followersUser.leadingAnchor, constant: -10)
        usernameIGUser.setWidthAnchorConstraint(equalToConstant: 180)
        
        addSubview(timesVisitUser)
        timesVisitUser.translatesAutoresizingMaskIntoConstraints = false
        timesVisitUser.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -20)
        timesVisitUser.setLeadingAnchorConstraint(equalTo: imageUser.trailingAnchor, constant: 20)
        // trailing
        timesVisitUser.setTrailingAnchorConstraint(equalTo: followersUser.leadingAnchor, constant: -10)
        timesVisitUser.setWidthAnchorConstraint(equalToConstant: 180)
    }
}
