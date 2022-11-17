//
//  CardFieldView.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 16/11/22.
//

import UIKit

class CardFieldView: UIView {
    var title: UILabel = {
       let label = UILabel()
        label.text = "Text"
        return label
    }()
    var value: UILabel = {
       let label = UILabel()
        label.text = "Value"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth)
        translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        title.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 10)
        title.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -10)
        addSubview(value)
        value.translatesAutoresizingMaskIntoConstraints = false
        value.setTopAnchorConstraint(equalTo: title.bottomAnchor, constant: 10)
        value.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 10)
        value.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -10)
        value.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -10)
    }

}
