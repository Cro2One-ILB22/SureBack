//
//  Protocol.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 16/11/22.
//

protocol UIViewToController {
    func didToRedeemTapButton(data: GenerateTokenOnlineResponse, user: UserInfoResponse)
}

extension UIViewToController {
    func didToRedeemTapButton(data: GenerateTokenOnlineResponse, user: UserInfoResponse) {
    }
}

protocol SendDataDelegate: AnyObject {
    func passData(data: String)
    func passData(data: Int)
}

extension SendDataDelegate {
    func passData(data: String) {
    }
    func passData(data: Int) {
    }
}

protocol CustomSegmentedControlDelegate: AnyObject {
    func change(to index: Int)
}
