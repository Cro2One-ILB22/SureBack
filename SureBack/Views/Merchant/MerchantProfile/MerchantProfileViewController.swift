//
//  MerchantProfileViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 16/11/22.
//

import UIKit

class MerchantProfileViewController: ProfileViewController {
    override func viewDidLoad() {
        isMerchantProfile = true
        super.viewDidLoad()
        businessSettingsCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(businessSettingCardAction)))
        tabBarController?.tabBar.backgroundColor = .white
    }
    @objc func businessSettingCardAction() {
        let formBusinessSettingVC = MerchantFormBusinessSettingViewController()
        formBusinessSettingVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(formBusinessSettingVC, animated: true)
    }
}
