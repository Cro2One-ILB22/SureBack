//
//  PurchaseResponse.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 22/11/22.
//

class PurchaseResponse: Codable {
    let id, purchaseAmount, paymentAmount: Int
    let updatedAt, createdAt: String
    let merchant: UserInfoResponse?
    let token: Token?
    let coinExchange: CoinExchange?

    enum CodingKeys: String, CodingKey {
        case purchaseAmount = "purchase_amount"
        case paymentAmount = "payment_amount"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id, merchant, token
        case coinExchange = "coin_exchange"
    }
}

struct CoinExchange: Codable {
    let id: Int
    let coinType, createdAt, updatedAt: String
    let amount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case coinType = "coin_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case amount
    }
}
