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
    let waitingView: WaitingView = {
        let segmented = WaitingView()
        return segmented
    }()
    let historyView: HistoryView = {
        let segmented = HistoryView()
        return segmented
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.waitingView.tableView.isHidden = true
        setupLayout()
        showHistoryView(false)
        getMyStory()
    }
    func getMyStory() {
        let rf = RequestFunction()
        rf.getMyStory { data in
            self.waitingView.listUserStory = data.data
            self.waitingView.tableView.reloadData()
            self.waitingView.tableView.isHidden = false
        }
    }
    private func showHistoryView(_ isShowing: Bool) {
        self.waitingView.isHidden = isShowing
        self.historyView.isHidden = !isShowing
    }
}

extension MerchantListAllCustomerViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        print("change to", index)
        switch(index) {
        case 0:
            showHistoryView(false)
        case 1:
            showHistoryView(true)
        default:
            break
        }
    }
}
