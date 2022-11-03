//
//  ListTransactionResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/11/22.
//

import Foundation

struct ListTransactionResponse: Codable {
    let results: [Transactions]
}

// MARK: - Transactions
struct Transactions: Codable {
    let id: Double
    let amount, balanceAfter, balanceBefore, pointsBefore: Int
    let pointsAfter: Int
    let category: Category
    let resultDescription: JSONNull?
    let type: TypeEnum
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, amount
        case balanceAfter = "balance_after"
        case balanceBefore = "balance_before"
        case pointsBefore = "points_before"
        case pointsAfter = "points_after"
        case category
        case resultDescription = "description"
        case type
        case createdAt = "created_at"
    }
}

enum Category: String, Codable {
    case story = "story"
}

enum TypeEnum: String, Codable {
    case d = "D"
}
