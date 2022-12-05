//
//  APICall.swift
//  SureBack
//
//  Created by Muhamad Fahmi Al Kautsar on 25/10/22.
//

import Foundation

struct API {
//    static let baseUrl: String = ProcessInfo.processInfo.environment["BASE_URL"] ?? "http://localhost:8000"
    static let baseUrl: String = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? "http://localhost:8000"
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
    case updateMerchantLocation
    case getListCustomer
    case getCustomerById(Int)
    case getListMerchant
    case getMerchantById(Int)
    case getListTransaction
    case approveOrRejectStory
    case submitStory
    case getToken
    case getNotifications
    case getMyStory
    case responseQRPurchase
    case requestPurchase
    case sendTotalPurchase

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
        case .updateMerchantLocation:
            return "\(API.baseUrl)/api/user/merchant/location"
        case .getListCustomer:
            return "\(API.baseUrl)/api/customer"
        case let .getCustomerById(id):
            return "\(API.baseUrl)/api/customer/\(id)"
        case .getListMerchant:
            return "\(API.baseUrl)/api/merchant"
        case let .getMerchantById(id):
            return "\(API.baseUrl)/api/merchant/\(id)"
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
        case .responseQRPurchase:
            return "\(API.baseUrl)/api/broadcasting/qr/response"
        case .requestPurchase:
            return "\(API.baseUrl)/api/broadcasting/qr/purchase"
        case .sendTotalPurchase:
            return "\(API.baseUrl)/api/broadcasting/qr/total-purchase"
        }
    }
}
