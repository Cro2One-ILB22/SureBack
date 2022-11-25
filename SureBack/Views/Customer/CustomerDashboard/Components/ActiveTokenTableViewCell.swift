//
//  ActiveTokenTableViewCell.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 16/11/22.
//

import UIKit

class ActiveTokenTableViewCell: UITableViewCell {

    static let id = "ActiveTokenTableViewCell"

    var delegate: UIViewToController?
    var activateTokenData = [GenerateTokenOnlineResponse]() {
        didSet {
            collectionView.reloadData()
        }
    }
    var user: UserInfoResponse!

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.screenWidth - 40, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(ItemActiveTokenCollectionViewCell.self, forCellWithReuseIdentifier: ItemActiveTokenCollectionViewCell.id)
        return collectionView
    }()

    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
        pageControl.setCenterXAnchorConstraint(equalTo: contentView.centerXAnchor)
        pageControl.setBottomAnchorConstraint(equalTo: collectionView.bottomAnchor)

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

extension ActiveTokenTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemActiveTokenCollectionViewCell.id, for: indexPath) as? ItemActiveTokenCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .lightGray
        cell.tokenMerchantNameLabel.text = activateTokenData[indexPath.row].merchant.name
        cell.redeemButton.tag = indexPath.row
        cell.redeemButton.addTarget(self, action: #selector(toRedeemTokenTapped), for: .touchUpInside)
        cell.expireAt = activateTokenData[indexPath.row].expiresAt.stringToDate()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if activateTokenData.count == 1 {
            pageControl.isHidden = true
        }
        pageControl.numberOfPages = activateTokenData.count
        return activateTokenData.count
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        self.pageControl.currentPage = Int(roundedIndex)
    }

    @objc func toRedeemTokenTapped(sender: UIButton) {
        delegate?.didToRedeemTapButton(data: activateTokenData[sender.tag], user: user)
    }
}
