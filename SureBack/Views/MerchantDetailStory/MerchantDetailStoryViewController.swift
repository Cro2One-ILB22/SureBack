//
//  MerchantDetailStoryViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 17/11/22.
//

import UIKit

class MerchantDetailStoryViewController: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    private let headerView: HeaderMerchantDetailStoryView = {
       let view = HeaderMerchantDetailStoryView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.osloGray.cgColor
        return view
    }()
    private let storyCardView: ItemCustomerStoryCollectionCell = {
       let view = ItemCustomerStoryCollectionCell()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.osloGray.cgColor
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .porcelain
        setupLayout()
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
