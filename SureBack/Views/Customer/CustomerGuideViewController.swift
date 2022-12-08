//
//  CustomerGuideViewController.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 08/12/22.
//

import UIKit

class CustomerGuideViewController: UIViewController {
    let guideImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        return image
    }()
    let backImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        image.image = UIImage(named: "arrow.backward.circle.fill")
        image.setWidthAnchorConstraint(equalToConstant: 40)
        image.setHeightAnchorConstraint(equalToConstant: 40)
        return image
    }()
    var currentGuideImageNumber = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        guideImage.image = UIImage(named: "customer.guide.1")
        guideImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapGuideImage)))
        backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBackImage)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backImage)
        setupLayout()
    }
    @objc func didTapGuideImage() {
        let imagesGuide: [String] = ["customer.guide.1", "customer.guide.2", "customer.guide.3", "customer.guide.4"]
        for (number, imageName) in imagesGuide.enumerated() {
            if currentGuideImageNumber == number {
                guideImage.image = UIImage(named: imageName)
            } else if currentGuideImageNumber == imagesGuide.count {
                navigationController?.popViewController(animated: true)
            }
        }
        currentGuideImageNumber += 1
    }
    @objc func didTapBackImage() {
        navigationController?.popViewController(animated: true)
    }
    private func setupLayout() {
        view.addSubview(guideImage)
        guideImage.translatesAutoresizingMaskIntoConstraints = false
        guideImage.setTopAnchorConstraint(equalTo: view.topAnchor)
        guideImage.setLeadingAnchorConstraint(equalTo: view.leadingAnchor)
        guideImage.setTrailingAnchorConstraint(equalTo: view.trailingAnchor)
        guideImage.setBottomAnchorConstraint(equalTo: view.bottomAnchor)
    }
}
