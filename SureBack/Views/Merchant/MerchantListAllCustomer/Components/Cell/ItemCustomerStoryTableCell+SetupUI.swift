//
//  ItemCustomerStoryTableCell+SetupUI.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 22/11/22.
//

import UIKit

extension ItemCustomerStoryTableCell {
    func setupLayout() {
        setupImageLayout()
        setupUsernameIGLayout()
        setupUserFollowerLayout()
        setupDateCreatedLayout()
        if isHistory == true {
            setupHistoryStatusLayout()
        }
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
        if !isHistory {
            usernameIG.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -10)
        }
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
        iconImage.image = iconStatus
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.setWidthAnchorConstraint(equalToConstant: 11)
        iconImage.setHeightAnchorConstraint(equalToConstant: 11)
        let stackViewStatus = UIStackView(arrangedSubviews: [historyStatus, iconImage])
        stackViewStatus.axis = .horizontal
        stackViewStatus.distribution = .fill
        stackViewStatus.translatesAutoresizingMaskIntoConstraints = false
        stackViewStatus.backgroundColor = colorStatus
        stackViewStatus.layer.cornerRadius = 10
        stackViewStatus.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        stackViewStatus.isLayoutMarginsRelativeArrangement = true
        addSubview(stackViewStatus)
        stackViewStatus.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        stackViewStatus.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -10)
        stackViewStatus.setWidthAnchorConstraint(equalToConstant: 100)
        stackViewStatus.setLeadingAnchorConstraint(equalTo: usernameIG.trailingAnchor, constant: 10)
    }
}
