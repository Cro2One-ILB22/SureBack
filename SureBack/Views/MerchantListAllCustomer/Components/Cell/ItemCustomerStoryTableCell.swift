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
    var colorStatus = UIColor.titanWhite
    var iconStatus = UIImage(named: "checkmark.circle.fill.black")
    lazy var userImageProfile: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.image = UIImage(named: "person.crop.circle")
        return image
    }()
    lazy var usernameIG: UILabel = {
       let label = UILabel()
        label.text = "@username"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    lazy var userFollower: UILabel = {
       let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    lazy var dateCreated: UILabel = {
       let label = UILabel()
        label.text = "17 Mei 2022"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    lazy var historyStatus: UILabel = {
       let label = UILabel()
        label.text = "Approve"
        label.font = .systemFont(ofSize: 11)
        return label
    }()
    public func setCellWithValueOf(_ data: MyStoryData) {
        updateUI(imagePath: data.customer.profilePicture,
                 usernameInstagram: data.customer.instagramUsername,
                 dateCreated: data.createdAt.formatTodMMMyyyhmma(),
                 historyStatus: "Approve")
    }
    private func updateUI(imagePath: String, usernameInstagram: String, dateCreated: String, historyStatus: String? = nil) {
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.cornerRadius = 10
        setupLayout()
        let imageDownloader = ImageDownloader()
        guard let url = URL(string: imagePath) else {return}
        imageDownloader.downloadImage(url: url) { imageData in
            self.userImageProfile.image = UIImage(data: imageData)
        }
        usernameIG.text = "@" + usernameInstagram
        self.dateCreated.text = dateCreated.formatTodMMMyyyhmma()
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
}
