//
//  UserViewModel.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 27/11/22.
//

import Foundation
import RxSwift

class UserViewModel {
    static let shared = UserViewModel()
    private let request = RequestFunction()

    var userSubject = PublishSubject<UserInfoResponse>() // jadi object yg bisa diobserve
    var disposeBag = DisposeBag()

    private ( set ) var user: UserInfoResponse?

    init() {
        userSubject.subscribe(onNext: { [weak self] user in // onNext :
            self?.user = user
        }).disposed(by: disposeBag)
    }

    func fetchUser() {
        request.getUserInfo { [weak self] data in
            guard let self = self else {return}
            switch data {
            case let .success(result):
                self.userSubject.onNext(result)
            case let .failure(error):
                print(error)
                print("failed to login")
            }
        }
    }
}
