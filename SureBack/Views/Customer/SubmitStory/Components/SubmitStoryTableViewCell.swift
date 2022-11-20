//
//  SubmitStoryTableViewCell.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 15/11/22.
//

import SDWebImage
import UIKit

class SubmitStoryTableViewCell: UITableViewCell {
    static let id = "SubmitStoryTableViewCell"

    var storyData = [ResultStoryIG]() {
        didSet {
            collectionView.reloadData()
        }
    }

    var user: UserInfoResponse?
    var userIgInfo: ProfileIGResponse?

    var selectedStoryIndex = Int()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 500)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(ItemStoryCollectionViewCell.self, forCellWithReuseIdentifier: ItemStoryCollectionViewCell.id)

        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
}

extension SubmitStoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemStoryCollectionViewCell.id, for: indexPath) as? ItemStoryCollectionViewCell, let user = user, let userIgInfo = userIgInfo else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: ItemStoryCollectionViewCell.id, for: indexPath) as! UICollectionViewCell // swiftlint:disable:this force_cast
        }
        cell.backgroundColor = selectedStoryIndex == indexPath.row ? .systemBlue : .lightGray
        cell.userImageProfile.sd_setImage(
            with: URL(string: user.profilePicture),
            placeholderImage: UIImage(named: "person.crop.circle"),
            options: .progressiveLoad,
            completed: nil
        )
        cell.usernameIG.text = user.instagramUsername
        cell.userFollower.text = "\(userIgInfo.followerCount) Followers"
        cell.userImageStory.sd_setImage(
            with: URL(string: storyData[indexPath.row].imageURL ?? ""),
            placeholderImage: UIImage(named: "system.photo"),
            options: .progressiveLoad,
            completed: nil
        )

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyData.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = indexPath.row
        print(selected)
        selectedStoryIndex = indexPath.row

        self.collectionView.reloadData()
    }
}
