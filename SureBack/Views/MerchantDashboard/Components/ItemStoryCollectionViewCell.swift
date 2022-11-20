//
//  ItemStoryCollectionViewCell.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 11/11/22.
//

import UIKit

class ItemStoryCollectionViewCell: UICollectionViewCell {
    static let id = "ItemStoryCollectionViewCell"
    let userImageProfile: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.image = UIImage(named: "person.crop.circle")
        return image
    }()
    let usernameIG: UILabel = {
       let label = UILabel()
        return label
    }()
    let userFollower: UILabel = {
       let label = UILabel()
        return label
    }()
    let userImageStory: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "person.crop.circle")
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 30
        setupConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupConstraint() {
        contentView.addSubview(userImageProfile)
        userImageProfile.translatesAutoresizingMaskIntoConstraints = false
        userImageProfile.setTopAnchorConstraint(equalTo: contentView.topAnchor, constant: 10)
        userImageProfile.setLeadingAnchorConstraint(equalTo: contentView.leadingAnchor, constant: 10)
        userImageProfile.setHeightAnchorConstraint(equalToConstant: 40)
        userImageProfile.setWidthAnchorConstraint(equalToConstant: 40)
        contentView.addSubview(usernameIG)
        usernameIG.translatesAutoresizingMaskIntoConstraints = false
        usernameIG.setTopAnchorConstraint(equalTo: contentView.topAnchor, constant: 10)
        usernameIG.setLeadingAnchorConstraint(equalTo: userImageProfile.trailingAnchor, constant: 10)
        usernameIG.setTrailingAnchorConstraint(equalTo: contentView.trailingAnchor, constant: -10)
        contentView.addSubview(userFollower)
        userFollower.translatesAutoresizingMaskIntoConstraints = false
        userFollower.setTopAnchorConstraint(equalTo: usernameIG.bottomAnchor)
        userFollower.setLeadingAnchorConstraint(equalTo: userImageProfile.trailingAnchor, constant: 10)
        userFollower.setTrailingAnchorConstraint(equalTo: contentView.trailingAnchor, constant: -10)
        contentView.addSubview(userImageStory)
        userImageStory.translatesAutoresizingMaskIntoConstraints = false
        userImageStory.setTopAnchorConstraint(equalTo: userImageProfile.bottomAnchor, constant: 10)
        userImageStory.setLeadingAnchorConstraint(equalTo: contentView.leadingAnchor, constant: 10)
        userImageStory.setTrailingAnchorConstraint(equalTo: contentView.trailingAnchor, constant: -10)
        userImageStory.setBottomAnchorConstraint(equalTo: contentView.bottomAnchor, constant: -10)
    }
}
