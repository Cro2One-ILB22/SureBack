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
    case broadcastingAuth
    case login
    case logout
    case preRegister
    case register
    case getAccount
    case getProfileIG
    case getUserIG
    case generateToken
    case scanQr
    case toStoryIG
    case redeemToken
    case updateUser
    case updateMerchantDetail
    case getListCustomer
    case getListMerchant
    case getListTransaction
    case approveOrRejectStory
    case submitStory
    case getToken
    case getNotifications
    case getMyStory

    public var url: String {
        switch self {
        case .broadcastingAuth:
            return "\(API.baseUrl)/broadcasting/auth"
        case .login:
            return "\(API.baseUrl)/api/auth/login"
        case .logout:
            return "\(API.baseUrl)/api/auth/logout"
        case .preRegister:
            return "\(API.baseUrl)/api/auth/register/instagram-otp"
        case .register:
            return "\(API.baseUrl)/api/auth/register"
        case .getAccount:
            return "\(API.baseUrl)/api/auth/me"
        case .getProfileIG:
            return "\(API.baseUrl)/api/ig/profile/"
        case .getUserIG:
            return "\(API.baseUrl)/api/ig/user/"
        case .generateToken:
            return "\(API.baseUrl)/api/ig/token/generate"
        case .toStoryIG:
            return "\(API.baseUrl)/api/ig/story"
        case .redeemToken:
            return "\(API.baseUrl)/api/ig/token/redeem"
        case .updateUser:
            return "\(API.baseUrl)/api/user"
        case .updateMerchantDetail:
            return "\(API.baseUrl)/api/user/merchant-detail"
        case .getListCustomer:
            return "\(API.baseUrl)/api/customer"
        case .getListMerchant:
            return "\(API.baseUrl)/api/merchant"
        case .getListTransaction:
            return "\(API.baseUrl)/api/transaction"
        case .approveOrRejectStory:
            return "\(API.baseUrl)/api/ig/story/approval"
        case .scanQr:
            return "\(API.baseUrl)/api/ig/purchase/qr"
        case .submitStory:
            return "\(API.baseUrl)/api/ig/story/submit"
        case .getToken:
            return "\(API.baseUrl)/api/ig/token"
        case .getNotifications:
            return "\(API.baseUrl)/api/user/notification"
        case .getMyStory:
            return "\(API.baseUrl)/api/customer/story"
        }
    }
}
