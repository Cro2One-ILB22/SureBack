//
//  PreRegisterResponse.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 31/10/22.
//

import Foundation

struct PreRegisterResponse: Codable {
    let otp, expiresIn: Int

    enum CodingKeys: String, CodingKey {
        case otp
        case expiresIn = "expires_in"
    }
}
