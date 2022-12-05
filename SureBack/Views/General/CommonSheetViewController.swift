//
//  CommonSheetViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 05/12/22.
//

import UIKit

class CommonSheetViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let closeImage: UIImageView = {
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "multiply.circle.fill.green")
        iconImage.setWidthAnchorConstraint(equalToConstant: 24)
        iconImage.setHeightAnchorConstraint(equalToConstant: 24)
        iconImage.isUserInteractionEnabled = true
        return iconImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopLayout()
        closeImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
    }
    @objc func close() {
        dismiss(animated: true)
    }
}

extension CommonSheetViewController {
    private func setupTopLayout() {
        let hStackView = UIStackView(arrangedSubviews: [titleLabel, closeImage])
        hStackView.axis = .horizontal
        hStackView.distribution = .equalSpacing
        hStackView.alignment = .fill
        hStackView.layer.cornerRadius = 10
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hStackView)
        hStackView.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        hStackView.setLeadingAnchorConstraint(equalTo: view.leadingAnchor, constant: 16)
        hStackView.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -16)
    }
}
