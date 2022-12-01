//
//  OnboardingViewController.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 30/11/22.
//

import UIKit

class OnboardingViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()

    private let pageController: UIPageControl = {
        let pageController = UIPageControl()
        pageController.numberOfPages = 4
        pageController.currentPage = 0
        pageController.currentPageIndicatorTintColor = .black
        pageController.pageIndicatorTintColor = .gray
        return pageController
    }()

//    private let prevButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("", for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//        button.setTitleColor(.gray, for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET STARTED", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .porcelain
        scrollView.delegate = self

        setupLayout()
    }

//    @objc func prevButtonTapped() {
//        navigationController?.isNavigationBarHidden = true
//        pageController.currentPage -= 1
//        let current = pageController.currentPage
//        scrollView.setContentOffset(CGPoint(x: view.frame.size.width * CGFloat(current), y: -60), animated: true)
//    }
//
//    @objc func nextButtonTapped() {
//        pageController.currentPage += 1
//        let current = pageController.currentPage
//        scrollView.setContentOffset(CGPoint(x: view.frame.size.width * CGFloat(current), y: -60), animated: true)
//    }
    @objc func getStartedTapped() {
        print("Get started tapped")
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageController.frame = CGRect(x: 10, y: view.frame.size.height - 80, width: view.frame.size.width - 20, height: 50)
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)

        if scrollView.subviews.count == 2 {
            configureScrollView()
        }
    }

    private func configureScrollView() {
        scrollView.contentSize = CGSize(width: view.frame.size.width * 4, height: 0)
        for i in 0..<4 {
            let imageView = UIImageView(frame: CGRect(x: (CGFloat(i) * view.frame.size.width) + 30, y: -10, width: view.frame.size.width - 50, height: scrollView.frame.size.height - 70))
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "onboarding\(i+1)")
            scrollView.addSubview(imageView)
        }
        scrollView.showsHorizontalScrollIndicator = false
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let current = scrollView.contentOffset.x / view.frame.size.width
        pageController.currentPage = Int(current)

        if pageController.currentPage == pageController.numberOfPages - 1 {
            nextButton.setTitleColor(.tealishGreen, for: .normal)
            nextButton.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
            nextButton.isEnabled = true
        } else {
            nextButton.setTitleColor(.porcelain, for: .normal)
            nextButton.isEnabled = false
        }
    }
}

extension OnboardingViewController {
    func setupLayout() {
        view.addSubview(scrollView)
        setupBottomControl()
    }

    func setupBottomControl() {
        view.addSubview(pageController)
        view.addSubview(nextButton)
        nextButton.setTopAnchorConstraint(equalTo: pageController.topAnchor, constant: 0)
        nextButton.setTrailingAnchorConstraint(equalTo: view.trailingAnchor, constant: -25)
        nextButton.setBottomAnchorConstraint(equalTo: pageController.bottomAnchor, constant: 0)
        nextButton.setWidthAnchorConstraint(equalToConstant: 100)
    }
}
