//
//  MerchantDashboardViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 09/11/22.
//

import UIKit

class MerchantDashboardViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        setup2()
    }
    private func title(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    private func setup() {
        let textHai = title(text: "Hai")
        view.addSubview(textHai)
        textHai.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
    }
    private func setup2() {
        let textHlo = title(text: "Haloo")
        view.addSubview(textHlo)
        textHlo.setTopAnchorConstraint(equalTo: title(text: "Hai").bottomAnchor)
    }
}

class TitleView: UIView {
    var label: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
