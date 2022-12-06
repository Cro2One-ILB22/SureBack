//
//  UICollectionView+Ext.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/12/22.
//

import UIKit

extension UICollectionView {
    func setEmptyMessage(
        image: UIImage,
        title: String,
        message: String,
        centerYAnchorConstant: CGFloat = 0,
        username: String? = nil
    ) {
        let emptyView = UIView(frame: CGRect(x: center.x, y: center.y, width: bounds.size.width, height: bounds.size.height))
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
        // imageEmpty scale to fit
        imageEmpty.contentMode = .scaleAspectFit
        imageEmpty.setWidthAnchorConstraint(equalToConstant: 80)
        imageEmpty.setHeightAnchorConstraint(equalToConstant: 50)
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
        messageLabel.isUserInteractionEnabled = true
        backgroundView = emptyView

        guard let text = messageLabel.text else { return }
        let underlineAttriString = NSMutableAttributedString(string: text)

        let range1 = (text as NSString).range(of: "@\(username ?? "")")
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.tealishGreen, range: range1)
        messageLabel.attributedText = underlineAttriString
        messageLabel.isUserInteractionEnabled = true
        let tappy = MyTapGesture(target: self, action: #selector(tapped))
        messageLabel.addGestureRecognizer(tappy)
    }

    func restore() {
        backgroundView = nil
    }

    @objc func tapped(sender: MyTapGesture) {
        UIApplication.shared.open(URL(string: "https://instagram.com/\(sender.username)")!)
    }

}

class MyTapGesture: UITapGestureRecognizer {
    var username = String()
}
