//
//  CustomerStoryViewModel.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 05/12/22.
//

import Foundation
import RxSwift

class CustomerStoryViewModel {
    static let shared = CustomerStoryViewModel()
    var customerStorySubject = PublishSubject<CustomerStory>()
    private let disposeBag = DisposeBag()
    private let apiRequest = RequestFunction()
    private ( set ) var customerStory = CustomerStory()
    func setState(state: LoadingState) {
        customerStory.loadingState = state
        customerStorySubject.onNext(customerStory)
    }
    init() {
        customerStorySubject.subscribe { [weak self] customerStory in
            self?.customerStory = customerStory
        }.disposed(by: disposeBag)
    }
    func fetchCustomerStory() {
        setState(state: .loading)
        apiRequest.getCustomerStory(assessed: true) {[weak self] data, statusCode in
            if statusCode != 200 {
                self?.setState(state: .failed)
            }
            let stories = data?.data ?? []
            self?.setState(state: .success)
            self?.customerStorySubject.onNext(CustomerStory(loadingState: .success, stories: stories))
        }
    }
}

struct CustomerStory {
    var loadingState: LoadingState = .notStarted
    var stories: [MyStoryData] = []
}
