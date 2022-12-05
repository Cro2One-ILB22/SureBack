//
//  MerchantsProcessViewModel.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 05/12/22.
//

import Foundation
import RxSwift
import CoreLocation

class MerchantsProcessViewModel {
    static let shared = MerchantsProcessViewModel()

    var merchantsProcessSubject = PublishSubject<MerchantProcess>()
    private var disposeBag = DisposeBag()
    private let request = RequestFunction()

    private ( set ) var location: CLLocationCoordinate2D?
    private ( set ) var merchantsProcess = MerchantProcess()

    init() {
        merchantsProcessSubject.subscribe(onNext: { [weak self] merchantsProcess in // onNext :
            self?.merchantsProcess = merchantsProcess
        }).disposed(by: disposeBag)
    }

    func setMerchants(merchants: [UserInfoResponse]) {
        merchantsProcess.merchants = merchants
        merchantsProcessSubject.onNext(merchantsProcess)
    }

    func setState(state: LoadingState) {
        merchantsProcess.loadingState = state
        merchantsProcessSubject.onNext(merchantsProcess)
    }

    func setLocation(location: CLLocationCoordinate2D) {
        self.location = location
    }

    func fetchMerchants() {
        setState(state: .loading)
        let coordinate = (location != nil) ? (location!.latitude, location!.longitude) : nil
        request.getListMerchant(locationCoordinate: coordinate) { [weak self] data in
            guard let self = self else {return}
            switch data {
            case let .success(result):
                self.merchantsProcessSubject.onNext(MerchantProcess(loadingState: .success, merchants: result.data))
            case let .failure(error):
                self.setState(state: .failed)
                print(error)
                print("failed to get list merchant")
            }
        }
    }
}

struct MerchantProcess {
    var loadingState: LoadingState = .notStarted
    var merchants = [UserInfoResponse]()
}
