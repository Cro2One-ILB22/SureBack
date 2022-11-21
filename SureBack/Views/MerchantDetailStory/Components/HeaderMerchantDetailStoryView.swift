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
        image.image = UIImage(named: "person.crop.circle")
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        return image
    }()
    let nameUser: UILabel = {
        let label = UILabel()
        label.text = "asofasofsaioasifpoajfjsapojoasjfpajsfpjaspfjpasjfojsapjosfjpajfoajspojpasjpfpaoajf"
        return label
    }()
    let usernameIGUser: UILabel = {
        let label = UILabel()
        label.text = "Username IG"
        return label
    }()
    let timesVisitUser: UILabel = {
        let label = UILabel()
        label.text = "Times visit"
        return label
    }()
    let followersUser: UILabel = {
        let label = UILabel()
        label.text = "10K"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    private let textFollowers: UILabel = {
        let label = UILabel()
        label.text = "Followers"
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
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
        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 30)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        
        addSubview(imageUser)
        imageUser.translatesAutoresizingMaskIntoConstraints = false
        imageUser.setTopAnchorConstraint(equalTo: topAnchor, constant: 20)
        imageUser.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        imageUser.setWidthAnchorConstraint(equalToConstant: 70)
        imageUser.setHeightAnchorConstraint(equalToConstant: 70)
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
        timesVisitUser.setTopAnchorConstraint(equalTo: usernameIGUser.bottomAnchor, constant: 5)
        timesVisitUser.setLeadingAnchorConstraint(equalTo: imageUser.trailingAnchor, constant: 20)
        // trailing
        timesVisitUser.setTrailingAnchorConstraint(equalTo: followersUser.leadingAnchor, constant: -10)
        timesVisitUser.setWidthAnchorConstraint(equalToConstant: 180)
    }
}
