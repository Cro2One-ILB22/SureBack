//
//  ProfileIGResponse.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 02/11/22.
//

import Foundation

// MARK: - ProfileIGResponse
struct ProfileIGResponse: Codable {
    let id, username, fullName: String
    let profilePicURL, profilePicURLHD: String
    let biography: String
    let externalURL: String?
    let isPrivate, isVerified: Bool
    let mediaCount, followerCount, followingCount: Int

    enum CodingKeys: String, CodingKey {
        case id, username
        case fullName = "full_name"
        case profilePicURL = "profile_pic_url"
        case profilePicURLHD = "profile_pic_url_hd"
        case biography
        case externalURL = "external_url"
        case isPrivate = "is_private"
        case isVerified = "is_verified"
        case mediaCount = "media_count"
        case followerCount = "follower_count"
        case followingCount = "following_count"
    }
}
