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
    }
    @objc func businessSettingCardAction() {
        print("Tapped")
    }
}
