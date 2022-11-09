//
//  AuthResponse.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 31/10/22.
//

import Foundation

struct AuthResponse: Codable {
    let roles: [String]
    let accessToken, tokenType: String
    let expiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        case roles
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}
