//
//  UIView+Ext.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 08/11/22.
//

import UIKit

extension UIView {
    func setTopAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) {
        topAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    func setBottomAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) {
        bottomAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    func setLeftAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) {
        leftAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    func setRightAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) {
        rightAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    func setLeadingAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) {
        leadingAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    func setTrailingAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) {
        trailingAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    func setCenterXAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) {
        centerXAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
    func setCenterYAnchorConstraint(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) {
        centerYAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
    }
}
