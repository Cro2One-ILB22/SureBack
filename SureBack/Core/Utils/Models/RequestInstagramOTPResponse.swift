//
//  PreRegisterResponse.swift
//  SureBack
//
//  Created by Tubagus Adhitya Permana on 31/10/22.
//

import Foundation

struct RequestInstagramOTPResponse: Codable {
    let otp, expiresIn: Int
    let instagramToDM: String

    enum CodingKeys: String, CodingKey {
        case otp
        case expiresIn = "expires_in"
        case instagramToDM = "instagram_to_dm"
    }
}
