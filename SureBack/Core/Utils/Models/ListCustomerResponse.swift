//
//  ListCustomerResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/11/22.
//

import Foundation

struct ListCustomerResponse: Codable {
    let results: [Customers]
}

// MARK: - Customers
struct Customers: Codable {
    let id: Double
    let name: String
    let instagramID, balance, points: Int
    let email: String
    let emailVerifiedAt: JSONNull?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case instagramID = "instagram_id"
        case balance, points, email
        case emailVerifiedAt = "email_verified_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
