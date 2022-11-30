//
//  SectionMonth.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 27/11/22.
//

import UIKit

import UIKit

class SectionMonth: UITableViewHeaderFooterView {
    static let id = "SectionMonth"
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "Month"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(monthLabel)
        monthLabel.setTopAnchorConstraint(equalTo: topAnchor, constant: 10)
        monthLabel.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        monthLabel.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        monthLabel.setBottomAnchorConstraint(equalTo: bottomAnchor, constant: -10)
    }
}
