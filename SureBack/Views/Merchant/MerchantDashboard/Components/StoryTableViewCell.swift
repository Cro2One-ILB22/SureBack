//
//  StoryTableViewCell.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 10/11/22.
//

import UIKit

protocol StoryTableViewCellCellDelegate: AnyObject {
    func didSelectItem(with storyData: MyStoryData)
}

class StoryTableViewCell: UITableViewCell {
    static let id = "StoryTableViewCell"
    var delegate: StoryTableViewCellCellDelegate?
    public var listCustomerStory: [MyStoryData] = []
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 208, height: 400)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(ItemStoryCollectionViewCell.self, forCellWithReuseIdentifier: ItemStoryCollectionViewCell.id)
        collectionView.backgroundColor = .porcelain
        return collectionView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

extension StoryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = listCustomerStory[indexPath.row]
        delegate?.didSelectItem(with: data)
    }
}

extension StoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemStoryCollectionViewCell.id, for: indexPath) as? ItemStoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let data = listCustomerStory[indexPath.row]
        cell.setCellWithValueOf(data)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCustomerStory.count
    }
}
