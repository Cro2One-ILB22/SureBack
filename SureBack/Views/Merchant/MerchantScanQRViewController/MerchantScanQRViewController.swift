//
//  MerchantScanQRViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 02/12/22.
//

import UIKit

class MerchantScanQRViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .black
        let scanQRVC = ScanQrViewController()
        scanQRVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(scanQRVC, animated: true)
    }
}
