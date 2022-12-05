//
//  TokenViewModel.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 04/12/22.
//

import Foundation
import RxSwift

class ActiveTokensViewModel {
    static let shared = ActiveTokensViewModel()

    var activeTokensSubject = PublishSubject<ActiveTokens>()
    private var disposeBag = DisposeBag()
    private let request = RequestFunction()

    private ( set ) var activeTokens = ActiveTokens()

    init() {
        activeTokensSubject.subscribe(onNext: { [weak self] activeTokens in // onNext :
            self?.activeTokens = activeTokens
        }).disposed(by: disposeBag)
    }

    func setActiveTokens(tokens: [Token]) {
        activeTokens.tokens = tokens
        activeTokensSubject.onNext(activeTokens)
    }

    func setState(state: LoadingState) {
        activeTokens.loadingState = state
        activeTokensSubject.onNext(activeTokens)
    }

    func fetchTokens() {
        setState(state: .loading)
        request.getListToken(expired: 0, submitted: 0, redeemed: 1) { [weak self] data in
            guard let self = self else {return}
            switch data {
            case let .success(result):
                self.activeTokensSubject.onNext(ActiveTokens(loadingState: .success, tokens: result.data))
            case let .failure(error):
                self.setState(state: .failed)
                print(error)
                print("failed to get active token")
            }
        }
    }

}

struct ActiveTokens {
    var loadingState: LoadingState = .notStarted
    var tokens = [Token]()
}
