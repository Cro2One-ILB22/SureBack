//
//  APICall.swift
//  SureBack
//
//  Created by Muhamad Fahmi Al Kautsar on 25/10/22.
//

import Foundation

struct API {
    static let baseUrl: String = ProcessInfo.processInfo.environment["BASE_URL"] ?? "http://localhost:8000"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints: Endpoint {
    case login
    case preRegister
    case register
    case getAccount
    case getProfileIG
    case getUserIG
    case generateToken
    case submitStory
    case getStoryIG
    case redeemToken
    case updateUser
    case updatePartnerDetail
    case getListCustomer
    case getListPartner
    case getListTransaction

    public var url: String {
        switch self {
        case .login:
            return "\(API.baseUrl)/api/auth/login"
        case .preRegister:
            return "\(API.baseUrl)/api/auth/instagram-otp"
        case .register:
            return "\(API.baseUrl)/api/auth/verify-instagram-otp"
        case .getAccount:
            return "\(API.baseUrl)/api/auth/me"
        case .getProfileIG:
            return "\(API.baseUrl)/api/ig/profile/"
        case .getUserIG:
            return "\(API.baseUrl)/api/ig/user/"
        case .generateToken:
            return "\(API.baseUrl)/api/ig/token/generate"
        case .submitStory:
            return "\(API.baseUrl)/api/ig/story"
        case .getStoryIG:
            return "\(API.baseUrl)/api/ig/story"
        case .redeemToken:
            return "\(API.baseUrl)/api/ig/token/redeem"
        case .updateUser:
            return "\(API.baseUrl)/api/user"
        case .updatePartnerDetail:
            return "\(API.baseUrl)/api/user/partner-detail"
        case .getListCustomer:
            return "\(API.baseUrl)/api/customer"
        case .getListPartner:
            return "\(API.baseUrl)/api/partner"
        case .getListTransaction:
            return "\(API.baseUrl)/api/transaction"
        }
    }
}
