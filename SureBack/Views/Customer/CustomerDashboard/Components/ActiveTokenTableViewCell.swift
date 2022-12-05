//
//  ActiveTokenTableViewCell.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 16/11/22.
//

import UIKit
import RxSwift

class ActiveTokenTableViewCell: UITableViewCell {

    static let id = "ActiveTokenTableViewCell"

    var delegate: UIViewToController?
    var user: UserInfoResponse!
    let activeTokensViewModel = ActiveTokensViewModel.shared
    private let disposeBag = DisposeBag()
    private var loadingService: LoadingService?

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.screenWidth - 40, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .porcelain
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

    override func didMoveToSuperview() {
        activeTokensViewModel.activeTokensSubject.subscribe(onNext: { [weak self] tokens in
            self?.loadingService?.setState(state: tokens.loadingState)
            self?.collectionView.reloadData()
        }).disposed(by: disposeBag)
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
        cell.tokenMerchantNameLabel.text = activeTokensViewModel.activeTokens.tokens[indexPath.row].purchase?.merchant?.name
        cell.redeemButton.tag = indexPath.row
        cell.redeemButton.addTarget(self, action: #selector(toRedeemTokenTapped), for: .touchUpInside)
        cell.expireAt = activeTokensViewModel.activeTokens.tokens[indexPath.row].expiresAt.stringToDate()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if activeTokensViewModel.activeTokens.tokens.count == 1 {
            pageControl.isHidden = true
        }
        pageControl.numberOfPages = activeTokensViewModel.activeTokens.tokens.count
        return activeTokensViewModel.activeTokens.tokens.count
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        self.pageControl.currentPage = Int(roundedIndex)
    }

    @objc func toRedeemTokenTapped(sender: UIButton) {
        delegate?.didToRedeemTapButton(data: activeTokensViewModel.activeTokens.tokens[sender.tag], user: user)
    }
}
