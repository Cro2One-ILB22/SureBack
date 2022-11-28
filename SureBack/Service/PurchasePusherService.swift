//
//  PurchasePusherService.swift
//  SureBack
//
//  Created by Muhamad Fahmi Al Kautsar on 28/11/22.
//

import Foundation
import PusherSwift

class PurchasePusherSerivce {
    let delegate: PusherDelegate
    var pusherService: PusherService?

    init(delegate: PusherDelegate) {
        self.delegate = delegate
    }

    func purchase(customerId: Int, merchantId: Int, completion: @escaping (QRScanPurchase) -> Void) {
        pusherService = PusherService(delegate: delegate, channelName: "qr-scan.purchase.\(merchantId).\(customerId)", eventName: "qr-scan.purchase")
        pusherService?.didReceive(of: QRScanPurchase.self, completion: completion)
    }

    func requestQRScan(customerId: Int, completion: @escaping (QRScanRequest) -> Void) {
        pusherService = PusherService(delegate: delegate, channelName: "qr-scan.request.\(customerId)", eventName: "qr-scan.request")
        pusherService?.didReceive(of: QRScanRequest.self, completion: completion)
    }

    func disconnect() {
        pusherService?.disconnect()
    }

    deinit {
        disconnect()
    }
}
