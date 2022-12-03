//
//  SnackBarView.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 04/12/22.
//

import UIKit

typealias Handler = (() -> Void)

enum SnackbarViewType {
    case info
    case action(action: Handler)
}

struct SnackbarViewModel {
    let type: SnackbarViewType
    let text: String
}

class SnackbarView: UIView {
    let viewModel: SnackbarViewModel
    private var handler: Handler?
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "x.circle")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    init(viewModel: SnackbarViewModel, frame: CGRect) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        backgroundColor = .darkTerraCotta
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.masksToBounds = true
        setupLayout()
        configure()
    }
    private func configure() {
        label.text = viewModel.text
        switch(viewModel.type) {
        case .action(action: let handler):
            self.handler = handler
            
            isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapSnackbar))
            gesture.numberOfTouchesRequired = 1
            gesture.numberOfTapsRequired = 1
            addGestureRecognizer(gesture)
        case .info:
            break
        }
    }
    @objc func didTapSnackbar() {
        handler?()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [label, imageView])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.setTopAnchorConstraint(equalTo: topAnchor)
        stackView.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 10)
        stackView.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -10)
        stackView.setBottomAnchorConstraint(equalTo: bottomAnchor)
        imageView.setWidthAnchorConstraint(equalToConstant: 25)
        imageView.setHeightAnchorConstraint(equalToConstant: 25)
    }
    //    cara manggil
    //    SnackbarViewModel(type: .info, text: "aa", image: UIImage())
    //    let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.5, height: 60)
    //    let snackbar = SnackbarView(viewModel: viewModel, frame: frame)
    //    showSnackbar(snackbar: snackbar)
}
