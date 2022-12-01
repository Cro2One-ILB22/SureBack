//
//  SettingCardView.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 26/11/22.
//

import UIKit

class SettingCardView: UIView {
    var titleImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    var title: UILabel = {
        let label = UILabel()
        label.text = "Text"
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.osloGray.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        addSubview(titleImage)
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        titleImage.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        titleImage.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 10)
        titleImage.setCenterYAnchorConstraint(equalTo: centerYAnchor)
        titleImage.setWidthAnchorConstraint(equalToConstant: 24)
        titleImage.setHeightAnchorConstraint(equalToConstant: 24)
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        title.setLeadingAnchorConstraint(equalTo: titleImage.trailingAnchor, constant: 10)
        title.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -10)
        title.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -10)
    }

}

//class SettingCardView: UIView {
//
//    var titleImage: UIImageView = {
//        let image = UIImageView()
//        image.contentMode = .scaleAspectFill
//        image.layer.cornerRadius = 10
//        image.clipsToBounds = true
//        return image
//    }()
//
//    var title: UILabel = {
//       let label = UILabel()
//        label.text = "Text"
//        return label
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .white
//        layer.cornerRadius = 10
//        layer.borderWidth = 2
//        layer.borderColor = UIColor.black.cgColor
//        setWidthAnchorConstraint(equalToConstant: UIScreen.screenWidth)
//        translatesAutoresizingMaskIntoConstraints = false
//        setupLayout()
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    func setupLayout() {
//        addSubview(titleImage)
//        titleImage.translatesAutoresizingMaskIntoConstraints = false
////        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
//        titleImage.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 10)
//        titleImage.setCenterYAnchorConstraint(equalTo: centerYAnchor)
//
//        addSubview(title)
//        title.translatesAutoresizingMaskIntoConstraints = false
////        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
//        title.setLeadingAnchorConstraint(equalTo: titleImage.trailingAnchor, constant: 10)
//        title.setCenterYAnchorConstraint(equalTo: centerYAnchor)
//
//
//
////        let stackView = UIStackView(arrangedSubviews: [titleImage, title])
////        stackView.distribution = .equalSpacing
////        stackView.spacing = 15
////
////        addSubview(stackView)
////        stackView.translatesAutoresizingMaskIntoConstraints = false
//////        stackView.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
////        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 10)
////        stackView.setCenterYAnchorConstraint(equalTo: centerYAnchor)
//    }
//
//}
