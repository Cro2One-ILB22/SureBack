//
//  Protocol.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 16/11/22.
//

protocol UIViewToController {
    func didToRedeemTapButton(data: Token, user: UserInfoResponse)
}

extension UIViewToController {
    func didToRedeemTapButton(data: Token, user: UserInfoResponse) {
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

protocol SendBookmark {
    func didTapBookmark(merchantId: Int, isFavorite: Bool)
}
