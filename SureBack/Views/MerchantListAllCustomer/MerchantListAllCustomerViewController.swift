//
//  MerchantListAllCustomerViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 21/11/22.
//

import UIKit

class MerchantListAllCustomerViewController: UIViewController {
    let customSegmentedControl: CustomSegmentedControl = {
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 50, width: UIScreen.screenWidth, height: 50), buttonTitle: ["Waiting", "History"])
        codeSegmented.backgroundColor = .clear
        return codeSegmented
    }()
    let waitingView: UIView = UIView()
    var historyView: UIView = UIView()
    var isFirstTimeOpenHistory = true
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        showHistoryView(false)
    }
    private func showHistoryView(_ isShowing: Bool) {
        self.waitingView.isHidden = isShowing
        self.historyView.isHidden = !isShowing
    }
}

extension MerchantListAllCustomerViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        switch(index) {
        case 0:
            showHistoryView(false)
        case 1:
            if isFirstTimeOpenHistory {
                isFirstTimeOpenHistory = false
                setupHistoryView()
            }
            showHistoryView(true)
        default:
            return
        }
    }
}
