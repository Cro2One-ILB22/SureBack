//
//  UpdateUserResponse.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 03/11/22.
//
import Foundation

struct UpdateUserResponse: Codable {
    let id: Double
    let name: String
    let instagramID, balance, points: Int
    let email: String
    let emailVerifiedAt: String?
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
