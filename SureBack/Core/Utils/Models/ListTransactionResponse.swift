//
//  ListTransactionResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/11/22.
//

import Foundation

// MARK: - ListTransactionResponse
struct ListTransactionResponse: Codable {
    let results: [Transaction]
}

// MARK: - Result
struct Transaction: Codable {
    let id, amount: Int
    let category: Category
    let resultDescription: JSONNull?
    let type: TypeEnum
    let instrument: Instrument
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, amount, category
        case resultDescription = "description"
        case type, instrument
        case createdAt = "created_at"
    }
}

enum Category: String, Codable {
    case story = "story"
}

enum Instrument: String, Codable {
    case coins = "coins"
}

enum TypeEnum: String, Codable {
    case d = "D"
}
