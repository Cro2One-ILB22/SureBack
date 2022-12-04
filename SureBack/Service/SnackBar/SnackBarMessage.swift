//
//  SnackBarMessage.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 03/12/22.
//

import UIKit

class SnackBarMessage {
    
    let view: UIView
    
    init(view: UIView) {
        self.view = view
    }
    
    public func showResponseMessage(statusCode: Int) {
        let viewModel: SnackbarViewModel?
        switch statusCode {
        case 400:
            viewModel = SnackbarViewModel(type: .info, text: "Invalid Request")
        case 401:
            viewModel = SnackbarViewModel(type: .info, text: "Unauthorized")
        case 500:
            viewModel = SnackbarViewModel(type: .info, text: "The server is undergoing repairs")
        default:
            return
        }
        let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.5, height: 60)
        guard let viewModel = viewModel else {return}
        let snackBar = SnackbarView(viewModel: viewModel, frame: frame)
        showSnackbar(snackBar: snackBar)
    }
    
    private func showSnackbar(snackBar: SnackbarView) {
        let width = view.frame.size.width/1.2
        snackBar.frame = CGRect(x: (view.frame.size.width-width) / 2,
                                y: -view.frame.size.height,
                                width: width,
                                height: 60)

        view.addSubview(snackBar)

        UIView.animate(withDuration: 0.5, animations: {
            snackBar.frame = CGRect(x: (self.view.frame.size.width - width) / 2,
                                    y: 70,
                                    width: width,
                                    height: 60)
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        snackBar.frame = CGRect(x: (self.view.frame.size.width-width) / 2,
                                                y: -self.view.frame.size.height,
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
