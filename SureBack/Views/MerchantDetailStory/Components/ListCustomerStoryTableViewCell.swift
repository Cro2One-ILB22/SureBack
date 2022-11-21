//
//  ListCustomerStoryTableViewCell.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 18/11/22.
//

import UIKit

class ListCustomerStoryTableViewCell: UITableViewCell {
    static let id = "ListCustomerStoryCell"
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 550)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(ItemCustomerStoryCollectionCell.self, forCellWithReuseIdentifier: ItemCustomerStoryCollectionCell.id)
        return collectionView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
}

extension ListCustomerStoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCustomerStoryCollectionCell.id, for: indexPath) as? ItemCustomerStoryCollectionCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .green
        return cell
    }
}
