//
//  ItemCustomerStoryTableCell.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 21/11/22.
//

import UIKit

let margin = CGFloat(16)

class ItemCustomerStoryTableCell: UITableViewCell {
    static let id = "ItemCustomerStoryTableCell"
    var isHistory = false
    lazy var userImageProfile: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.image = UIImage(named: "person.crop.circle")
        return image
    }()
    lazy var usernameIG: UILabel = {
       let label = UILabel()
        label.text = "Username IG"
        return label
    }()
    lazy var userFollower: UILabel = {
       let label = UILabel()
        label.text = "User Follower"
        return label
    }()
    lazy var dateCreated: UILabel = {
       let label = UILabel()
        label.text = "Date create"
        return label
    }()
    lazy var historyStatus: UILabel = {
       let label = UILabel()
        label.text = "Status"
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.cornerRadius = 10
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func config() {
        
    }
}

extension ItemCustomerStoryTableCell {
    private func setupLayout() {
        setupImageLayout()
        setupUsernameIGLayout()
        setupUserFollowerLayout()
        setupDateCreatedLayout()
        setupHistoryStatusLayout()
    }
    private func setupImageLayout() {
        addSubview(userImageProfile)
        userImageProfile.translatesAutoresizingMaskIntoConstraints = false
        userImageProfile.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        userImageProfile.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 10)
        userImageProfile.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -10)
        userImageProfile.setWidthAnchorConstraint(equalToConstant: 75)
        userImageProfile.setHeightAnchorConstraint(equalToConstant: 75)
    }
    private func setupUsernameIGLayout() {
        addSubview(usernameIG)
        usernameIG.translatesAutoresizingMaskIntoConstraints = false
        usernameIG.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        usernameIG.setLeadingAnchorConstraint(equalTo: userImageProfile.trailingAnchor, constant: 10)
    }
    private func setupUserFollowerLayout() {
        addSubview(userFollower)
        userFollower.translatesAutoresizingMaskIntoConstraints = false
        userFollower.setTopAnchorConstraint(equalTo: usernameIG.bottomAnchor)
        userFollower.setLeadingAnchorConstraint(equalTo: userImageProfile.trailingAnchor, constant: 10)
        userFollower.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -10)
    }
    private func setupDateCreatedLayout() {
        addSubview(dateCreated)
        dateCreated.translatesAutoresizingMaskIntoConstraints = false
        dateCreated.setLeadingAnchorConstraint(equalTo: userImageProfile.trailingAnchor, constant: 10)
        dateCreated.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -10)
        dateCreated.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -10)
    }
    private func setupHistoryStatusLayout() {
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "person.crop.circle")
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.setWidthAnchorConstraint(equalToConstant: 20)
        iconImage.setHeightAnchorConstraint(equalToConstant: 20)
        let stackViewStatus = UIStackView(arrangedSubviews: [historyStatus, iconImage])
        stackViewStatus.axis = .horizontal
        stackViewStatus.distribution = .fill
        stackViewStatus.spacing = 10
        stackViewStatus.translatesAutoresizingMaskIntoConstraints = false
        stackViewStatus.backgroundColor = .red
        stackViewStatus.layer.cornerRadius = 10
        stackViewStatus.layoutMargins = UIEdgeInsets(top: 1, left: 10, bottom: 1, right: 10)
        stackViewStatus.isLayoutMarginsRelativeArrangement = true
        addSubview(stackViewStatus)
        stackViewStatus.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        stackViewStatus.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -10)
        stackViewStatus.setWidthAnchorConstraint(equalToConstant: 100)
        stackViewStatus.setLeadingAnchorConstraint(equalTo: usernameIG.trailingAnchor, constant: 10)
    }
}
