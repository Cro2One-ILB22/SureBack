//
//  IsLoginViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 13/11/22.
//

import Foundation
import UIKit

class IsLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        if AuthManager.shared.isSignedIn {
//            KeychainHelper.standard.delete(key: .accessToken)
            print("Ada tokennya? : ",AuthManager.shared.isSignedIn)
//            print("Isi tokennya : ", try! KeychainHelper.standard.read(key: .accessToken))
            self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            self.navigationController?.isNavigationBarHidden = true
        } else {
            self.navigationController?.pushViewController(OnboardingViewController(), animated: true)
            self.navigationController?.isNavigationBarHidden = true
        }
    }
}
