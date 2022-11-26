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
        image.image = UIImage(named: "AppIcon")
        image.contentMode = .scaleAspectFill
        image.makeRounded()
        return image
    }()
    let usernameIG: UILabel = {
        let label = UILabel()
        label.text = "@username"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    let userFollower: UILabel = {
        let label = UILabel()
        label.text = "10 Follower"
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        return label
    }()
    let userImageStory: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "AppIcon")
        image.layer.cornerRadius = 20
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    public func setCellWithValueOf(_ data: MyStoryData) {
        updateUI(
            profileImagePath: data.customer.profilePicture,
            usernameInstagram: data.customer.instagramUsername,
            storyImagePath: data.imageURI ?? "")
    }
    private func updateUI(profileImagePath: String, usernameInstagram: String, storyImagePath: String) {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.osloGray.cgColor
        backgroundColor = .white
        setupConstraint()
        let imageDownloader = ImageDownloader()
        guard let urlProfile = URL(string: profileImagePath) else {return}
        imageDownloader.downloadImage(url: urlProfile) { imageData in
            self.userImageProfile.image = UIImage(data: imageData)
        }
//        guard let urlStory = URL(string: storyImagePath) else {return}
//        imageDownloader.downloadImage(url: urlStory) { imageData in
//            self.userImageStory.image = UIImage(data: imageData)
//        }
        usernameIG.text = "@" + usernameInstagram
        let rf = RequestFunction()
        rf.getProfileIG(username: usernameInstagram) { data in
            switch data {
            case .success(let data):
                self.userFollower.text = "\(String(describing: data.followerCount)) Followers"
            case .failure(let error):
                print(error)
            }
        }
    }
    private func setupConstraint() {
        contentView.addSubview(userImageProfile)
        userImageProfile.translatesAutoresizingMaskIntoConstraints = false
        userImageProfile.setTopAnchorConstraint(equalTo: contentView.topAnchor, constant: 10)
        userImageProfile.setLeadingAnchorConstraint(equalTo: contentView.leadingAnchor, constant: 10)
        userImageProfile.setHeightAnchorConstraint(equalToConstant: 32)
        userImageProfile.setWidthAnchorConstraint(equalToConstant: 32)
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
