//
//  UITableView+Ext.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 22/11/22.
//

import UIKit

extension UITableView {
    func setEmptyMessage(
        image: UIImage,
        title: String,
        message: String,
        centerYAnchorConstant: CGFloat = 0
    ) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let imageEmpty = UIImageView()
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        imageEmpty.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(imageEmpty)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
//        imageEmpty.setWidthAnchorConstraint(equalToConstant: 50)
//        imageEmpty.setHeightAnchorConstraint(equalToConstant: 50)
        imageEmpty.setCenterYAnchorConstraint(equalTo: emptyView.centerYAnchor, constant: centerYAnchorConstant)
        imageEmpty.setCenterXAnchorConstraint(equalTo: emptyView.centerXAnchor)
        titleLabel.setTopAnchorConstraint(equalTo: imageEmpty.bottomAnchor, constant: 5)
        titleLabel.setLeftAnchorConstraint(equalTo: emptyView.leftAnchor, constant: 20)
        titleLabel.setRightAnchorConstraint(equalTo: emptyView.rightAnchor, constant: -20)
        messageLabel.setTopAnchorConstraint(equalTo: titleLabel.bottomAnchor, constant: 5)
        messageLabel.setLeftAnchorConstraint(equalTo: emptyView.leftAnchor, constant: 20)
        messageLabel.setRightAnchorConstraint(equalTo: emptyView.rightAnchor, constant: -20)
        imageEmpty.image = image
        titleLabel.text = title
        titleLabel.textAlignment = .center
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
