//
//  CardRoleView.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 30/11/22.
//

import UIKit

class CardRoleView: UIView {
    let imageRole: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    let titleRole: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: -5, height: 5)
        layer.shadowRadius = 5
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardRoleView {
    func setupLayout() {
        addSubview(imageRole)
        imageRole.translatesAutoresizingMaskIntoConstraints = false
        imageRole.setTopAnchorConstraint(equalTo: topAnchor)
        imageRole.setLeadingAnchorConstraint(equalTo: leadingAnchor)
        imageRole.setTrailingAnchorConstraint(equalTo: trailingAnchor)
        imageRole.setHeightAnchorConstraint(equalToConstant: 121)
        addSubview(titleRole)
        titleRole.translatesAutoresizingMaskIntoConstraints = false
        titleRole.setTopAnchorConstraint(equalTo: imageRole.bottomAnchor, constant: 15)
        titleRole.setLeadingAnchorConstraint(equalTo: leadingAnchor)
        titleRole.setTrailingAnchorConstraint(equalTo: trailingAnchor)
    }
}
