//
//  SnackBarMessage.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 03/12/22.
//

import UIKit

class SnackBarMessage {

    private let currentWindow: UIWindow = UIApplication.shared.keyWindow!
    public func showResponseMessage(statusCode: Int, message: String? = nil) {
        let viewModel: SnackbarViewModel?
        switch statusCode {
        case 400:
            viewModel = SnackbarViewModel(type: .info, text: "Invalid Request")
        case 401:
            viewModel = SnackbarViewModel(type: .info, text: "Unauthorized")
        case 404:
            viewModel = SnackbarViewModel(type: .info, text: message ?? "Not found")
        case 500:
            viewModel = SnackbarViewModel(type: .info, text: "The server is undergoing repairs")
        default:
            viewModel = SnackbarViewModel(type: .info, text: "Something Wrong")
        }
        let frame = CGRect(x: 0, y: 0, width: currentWindow.frame.size.width/1.5, height: 60)
        guard let viewModel = viewModel else {return}
        let snackBar = SnackbarView(viewModel: viewModel, frame: frame)
        showSnackbar(snackBar: snackBar)
    }
    private func showSnackbar(snackBar: SnackbarView) {
        let width = currentWindow.frame.size.width/1.1
        snackBar.frame = CGRect(x: (currentWindow.frame.size.width-width) / 2,
                                y: -currentWindow.frame.size.height,
                                width: width,
                                height: 60)

        currentWindow.addSubview(snackBar)
        let isFullScreenDevice = currentWindow.frame.size.height >= 852 ? true : false
        UIView.animate(withDuration: 0.5, animations: {
            snackBar.frame = CGRect(x: (self.currentWindow.frame.size.width - width) / 2,
                                    y: isFullScreenDevice ? 100 : 60,
                                    width: width,
                                    height: 60)
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        snackBar.frame = CGRect(x: (self.currentWindow.frame.size.width-width) / 2,
                                                y: -self.currentWindow.frame.size.height,
                                                width: width,
                                                height: 60)
                    }, completion: { finished in
                        if finished {
                            snackBar.removeFromSuperview()
                        }
                    })
                })
            }
        })
    }
}
