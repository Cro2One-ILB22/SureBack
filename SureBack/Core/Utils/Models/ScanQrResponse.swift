//
//  GenerateTokenOfflineResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/11/22.
//

import Foundation

// MARK: - ScanQrResponse
class ScanQrResponse: Codable {
    let purchaseAmount, paymentAmount: Int
    let updatedAt, createdAt: String
    let id: Int
    let token: Token?
    let merchant: UserInfoResponse?

    enum CodingKeys: String, CodingKey {
        case purchaseAmount = "purchase_amount"
        case paymentAmount = "payment_amount"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id, token, merchant
    }

    init(purchaseAmount: Int, paymentAmount: Int, updatedAt: String, createdAt: String, id: Int, token: Token?, merchant: UserInfoResponse?) {
        self.purchaseAmount = purchaseAmount
        self.paymentAmount = paymentAmount
        self.updatedAt = updatedAt
        self.createdAt = createdAt
        self.id = id
        self.token = token
        self.merchant = merchant
    }
}
