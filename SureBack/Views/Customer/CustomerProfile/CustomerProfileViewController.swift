//
//  CustomerProfileViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 17/11/22.
//

import RxSwift
import SDWebImage
import UIKit

class CustomerProfileViewController: ProfileViewController {
    override func viewDidLoad() {
        isMerchantProfile = false
        super.viewDidLoad()
        appGuideCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(appGuideTapped)))
    }
    @objc func appGuideTapped(sender: UITapGestureRecognizer) {
        let customerGuideVC = CustomerGuideViewController()
        customerGuideVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(customerGuideVC, animated: true)
    }
}
