//
//  LoadingService.swift
//  SureBack
//
//  Created by Muhamad Fahmi Al Kautsar on 01/12/22.
//

import Foundation
import UIKit

class LoadingService {
    private let loadingIndicator: UIActivityIndicatorView
    private(set) var loadingState: LoadingState = .notStarted
    
    init(loadingIndicator: UIActivityIndicatorView) {
        self.loadingIndicator = loadingIndicator
        self.loadingIndicator.hidesWhenStopped = true
    }
    
    func setState(state: LoadingState) {
        loadingState = state
        switch state {
        case .loading:
            loadingIndicator.startAnimating()
        case .notStarted, .success, .failed:
            loadingIndicator.stopAnimating()
        }
    }
}
