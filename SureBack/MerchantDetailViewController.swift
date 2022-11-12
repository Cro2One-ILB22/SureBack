//
//  MerchantDetailViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 10/11/22.
//

import Foundation
import UIKit

class MerchantDetailViewController: UIViewController {
    var user: UserInfoResponse?
    var merchantData: UserInfoResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        guard let user = user, let merchantData = merchantData else {
            return
        }

        print("merchant name : \(merchantData.name)")
    }
}
