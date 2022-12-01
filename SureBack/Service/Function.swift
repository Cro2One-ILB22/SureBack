//
//  Function.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 27/10/22.
//

import Foundation
import UIKit

class Function {
    func generateQR(stringJSON: String) -> UIImage? {
        let myString = String(stringJSON)
        let data = myString.data(using: String.Encoding.ascii)
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        qrFilter.setValue(data, forKey: "inputMessage")

        // Get the output image
        guard let qrImage = qrFilter.outputImage else { return nil }
        // Scale the image
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        // Do some processing to get the UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return nil }
        let processedImage = UIImage(cgImage: cgImage)

        return processedImage
    }
}

typealias Handler = (() -> Void)

enum SnackbarViewType {
    case info
    case action(action: Handler)
}

struct SnackbarViewModel {
    let type: SnackbarViewType
    let text: String
    let image: UIImage?
}

class SnackbarView: UIView {
    let viewModel: SnackbarViewModel
    private var handler: Handler?
    private let label: UILabel = {
       let label = UILabel()
        label.textColor = .systemBlue
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private lazy var imageView: UIImageView = {
       let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    init(viewModel: SnackbarViewModel, frame: CGRect) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        addSubview(label)
        if viewModel.image != nil {
            addSubview(imageView)
        }
        backgroundColor = .blue
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        configure()
    }
    private func configure() {
        label.text = viewModel.text
        imageView.image = viewModel.image
        
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
    override func layoutSubviews() {
        super.layoutSubviews()
        if viewModel.image != nil {
            imageView.frame = CGRect(x: 5,
                                     y: 5,
                                     width: frame.height-10,
                                     height: frame.width-10)
            label.frame = CGRect(
                x: imageView.frame.size.width+5,
                y: 0, width: frame.size.width - imageView.frame.size.width-5,
                height: frame.size.height)
        } else {
            label.frame = bounds
        }
    }
    public func show(on viewController: UIViewController) {
        
    }
//    cara manggil
//    SnackbarViewModel(type: .info, text: "aa", image: UIImage())
//    let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.5, height: 60)
//    let snackbar = SnackbarView(viewModel: viewModel, frame: frame)
//    showSnackbar(snackbar: snackbar)
//    public func showSnackbar(snackbar: SnackbarView) {
//        let width = view.frame.size.width/1.5
//        snackBar.frame = CGRect(x: (view.frame.size.width-width) /2,
//                                y: view.frame. size.height,
//                                width: width,
//                                height: 60)
//
//        view.addSubview(snackbar)
//
//        UIView.animate (withDuration: 0.5, animations: {
//            snackBar.frame = CGRect(x: (self.view.frame.size.width-width) /2,
//                                    y: self.view.frame.size.height - 70,
//                                    width: width,
//                                    height: 60)
//        }, completion: { done in
//            if done {
//                DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
//                    UIView.animate(withDuration: 0.5) {
//                        snackBar.frame = CGRect(x: (self.view.frame.size.width-width) /2,
//                                                y: self.view.frame.size.height,
//                                                width: width,
//                                                height: 60)
//                    }, completion: { finished in
//                        if finished {
//                            snackbar.removeFromSuperview()
//                        }
//                    }
//                })
//            }
//        }
//    }
}
