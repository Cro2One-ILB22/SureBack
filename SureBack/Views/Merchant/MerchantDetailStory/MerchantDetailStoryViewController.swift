//
//  MerchantDetailStoryViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 17/11/22.
//

import UIKit

class MerchantDetailStoryViewController: UIViewController {
    var isFromHistory: Bool = false
    var storyData: MyStoryData?
    let scrollView = UIScrollView()
    let contentView = UIView()
    private let apiRequest = RequestFunction()
    private let headerView: HeaderMerchantDetailStoryView = {
       let view = HeaderMerchantDetailStoryView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.osloGray.cgColor
        return view
    }()
    private let storyCardView: PreviewCustomerStoryView = {
       let view = PreviewCustomerStoryView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.osloGray.cgColor
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .porcelain
        setupStoryCardView()
        setupLayout()
        initData()
        storyCardView.rejectButton.addTarget(self, action: #selector(rejectAction), for: .touchUpInside)
    }
    @objc func rejectAction() {
        let rejectFormVC = MerchantRejectStoryFormViewController()
        rejectFormVC.id = storyData?.id
        present(rejectFormVC, animated: true)
    }
    private func setupStoryCardView() {
        storyCardView.isFromHistory = isFromHistory
        storyCardView.setupConstraint()
        storyCardView.statusInfoImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(infoAction)))
    }
    @objc func infoAction() {
        print("Tapped")
        guard let storyData = storyData else {
            return
        }
        let status = storyData.token.currentStatus?.rawValue ?? "approve"
        let transactionDetailVC = TransactionDetailViewController()
        transactionDetailVC.nameLabel.text = "Customer"
        transactionDetailVC.configureToken(storyData, status: status)
        present(transactionDetailVC, animated: true)
    }
    private func initData() {
        let imageDownloader = ImageDownloader()
        let name = storyData?.customer?.name
        let username = "@" + (storyData?.customer?.instagramUsername ?? "")
        let createdStory = storyData?.createdAt.formatTodMMMyyyhmma()
        headerView.loadingIndicatorImageProfile.show(true)
        storyCardView.loadingIndicatorStory.show(true)
        guard let urlProfile = URL(string: storyData?.customer?.profilePicture ?? defaultImage) else {return}
        guard let urlStory = URL(string: storyData?.storyURL ?? defaultImage) else {return}
        let cashbackAmount = storyData?.token.tokenCashback.amount ?? 0
        imageDownloader.downloadImage(url: urlProfile) {[weak self] data in
            self?.headerView.loadingIndicatorImageProfile.show(false)
            self?.headerView.loadingIndicatorImageProfile.isHidden = true
            self?.headerView.imageUser.image = UIImage(data: data)
        }
        headerView.nameUser.text = name
        headerView.usernameIGUser.text = username
        headerView.timesVisitUser.text = createdStory
        getUserFollower()
        imageDownloader.downloadImage(url: urlStory) {[weak self] data in
            self?.storyCardView.loadingIndicatorStory.show(false)
            self?.storyCardView.loadingIndicatorStory.isHidden = true
            self?.storyCardView.userImageStory.image = UIImage(data: data)
        }
        storyCardView.cashbackLabel.text = "\(cashbackAmount)"
    }
    private func getUserFollower() {
        guard let username = storyData?.customer?.instagramUsername else {return}
        apiRequest.getProfileIG(username: username) { [weak self]result in
            switch(result) {
            case .success(let data):
                let follower = data.followerCount
                self?.headerView.followersUser.text = "\(follower)"
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MerchantDetailStoryViewController {
    private func setupLayout() {
        setupScrollView()
        setupHeader()
        setupStoryCard()
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.setCenterXAnchorConstraint(equalTo: view.centerXAnchor)
        scrollView.setWidthAnchorConstraint(equalTo: view.widthAnchor)
        scrollView.setTopAnchorConstraint(equalTo: view.topAnchor)
        scrollView.setBottomAnchorConstraint(equalTo: view.bottomAnchor)
        contentView.setCenterXAnchorConstraint(equalTo: scrollView.centerXAnchor)
        contentView.setWidthAnchorConstraint(equalTo: scrollView.widthAnchor)
        contentView.setTopAnchorConstraint(equalTo: scrollView.topAnchor)
        contentView.setBottomAnchorConstraint(equalTo: scrollView.bottomAnchor)
    }
    private func setupHeader() {
        contentView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.setWidthAnchorConstraint(equalToConstant: 100)
        headerView.setHeightAnchorConstraint(equalToConstant: 111)
        headerView.setTopAnchorConstraint(equalTo: contentView.topAnchor)
        headerView.setLeadingAnchorConstraint(equalTo: contentView.leadingAnchor)
        headerView.setTrailingAnchorConstraint(equalTo: contentView.trailingAnchor)
    }
    private func setupStoryCard() {
        contentView.addSubview(storyCardView)
        storyCardView.translatesAutoresizingMaskIntoConstraints = false
        storyCardView.setWidthAnchorConstraint(equalToConstant: 300)
        storyCardView.setHeightAnchorConstraint(equalToConstant: 580)
        storyCardView.setTopAnchorConstraint(equalTo: headerView.bottomAnchor, constant: 20)
        storyCardView.setLeadingAnchorConstraint(equalTo: contentView.leadingAnchor, constant: 40)
        storyCardView.setTrailingAnchorConstraint(equalTo: contentView.trailingAnchor, constant: -40)
        storyCardView.setBottomAnchorConstraint(equalTo: contentView.bottomAnchor, constant: -20)
    }
}
