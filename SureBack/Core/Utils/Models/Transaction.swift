//
//  ListTransactionResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/11/22.
//

import Foundation

// MARK: - Transaction

struct Transaction: Codable {
    let id, amount: Int
    let resultDescription: JSONNull?
    let accountingEntry: AccountingEntry
    let createdAt, updatedAt: String
    let status: Status
    let category: Category
    let paymentInstrument: PaymentInstrument

    enum CodingKeys: String, CodingKey {
        case id, amount
        case resultDescription = "description"
        case accountingEntry = "accounting_entry"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case status, category
        case paymentInstrument = "payment_instrument"
    }
}

enum AccountingEntry: String, Codable {
    case c = "C"
}

enum Category: String, Codable {
    case purchase
    case deposit
    case cashback
    case withdrawal
    case story
    case coinExchange = "coin_exchange"
}

enum PaymentInstrument: String, Codable {
    case other
}

enum Status: String, Codable {
    case created
    case pending
    case processing
    case success
    case failed
    case cancelled
    case refunded
    case expired
    case rejected
}
