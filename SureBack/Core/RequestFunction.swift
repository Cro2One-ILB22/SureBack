//
//  RequestFunction.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 25/10/22.
//

import Alamofire
import FirebaseMessaging
import Foundation

// MARK: Auth
class RequestFunction {
    private var accessToken: String {
        do {
            return try KeychainHelper.standard.read(key: .accessToken)
        } catch {
            print(error)
            return "noToken"
        }
    }

    func postLogin(email: String, password: String, completionHandler: @escaping (Result<AuthResponse, AFError>) -> Void) {
        let url = Endpoints.login.url
        let body: [String: String] = [
            "email": email,
            "password": password
        ]

        fetchHeadersForDeviceRegistration { response in
            switch response {
            case let .success(headers):
                AF.request(url, method: .post, parameters: body, headers: headers).validate().responseDecodable(of: AuthResponse.self) { response in
                    switch response.result {
                    case let .success(data):
                        do {
                            KeychainHelper.standard.delete(key: .accessToken)
                            try KeychainHelper.standard.save(key: .accessToken, value: data.accessToken)
                        } catch {
                            print(error)
                        }
                    case .failure:
                        if let data = response.data {
                            let json = String(data: data, encoding: .utf8)
                            print("Failure Response: \(String(describing: json))")
                        }
                    }
                    completionHandler(response.result)
                }
            case let .failure(error):
                print(error)
                completionHandler(.failure(error.asAFError(orFailWith: "Error fetching FCM token")))
            }
        }
    }

    func preRegister(name: String, email: String, password: String, role: String, username: String, completion: @escaping (RequestInstagramOTPResponse?, AFError?) -> Void) {
        let url = Endpoints.preRegister.url
        let body: [String: Any] = [
            "name": name,
            "email": email,
            "password": password,
            "role": role,
            "username": username,
        ]
        AF.request(url, method: .post, parameters: body)
            .validate()
            .responseDecodable(of: RequestInstagramOTPResponse.self) { response in
                switch response.result {
                case let .success(data):
                    completion(data, nil)
                case let .failure(error):
                    completion(nil, error)
                    print("Error: \(error.localizedDescription)")
                }
            }
    }

    func register(name: String, email: String, password: String, role: String, username: String, completion: @escaping (AuthResponse?, AFError?) -> Void) {
        let url = Endpoints.register.url
        let body: [String: Any] = [
            "name": name,
            "email": email,
            "password": password,
            "role": role,
            "username": username
        ]

        fetchHeadersForDeviceRegistration { response in
            switch response {
            case let .success(headers):
                AF.request(url, method: .post, parameters: body, headers: headers)
                    .validate()
                    .responseDecodable(of: AuthResponse.self) { response in
                        switch response.result {
                        case let .success(data):
                            completion(data, nil)
                        case let .failure(error):
                            completion(nil, error)
                            print(error.localizedDescription)
                        }
                    }
            case let .failure(error):
                print(error)
            }
        }
    }

    func getUserInfo(completion: @escaping (Result<UserInfoResponse, AFError>) -> Void) {
        let url = Endpoints.getAccount.url

        requestWithToken(url: url, decodable: UserInfoResponse.self) {
            completion($0.result)
        }
    }
}

// MARK: User

extension RequestFunction {
    func updateUser(name: String, completionHandler: @escaping (_ data: UserInfoResponse) -> Void) {
        let url = Endpoints.updateUser.url
        let body: [String: String] = [
            "name": name,
        ]
        requestWithToken(url: url, method: .put, parameters: body, decodable: UserInfoResponse.self) { response in
            switch response.result {
            case let .success(data):
                completionHandler(data)
            case let .failure(error):
                print(error)
            }
        }
    }
}

// MARK: Partner
extension RequestFunction {
    func updatePartnerCashbackPercent(cashbackPercent: Float, completion: @escaping (Result<MerchantDetailResponse, AFError>) -> Void) {
        let url = Endpoints.updateMerchantDetail.url
        var body: [String: Float] = [:]
        body["cashback_percent"] = cashbackPercent

        requestWithToken(url: url, method: .put, parameters: body, decodable: MerchantDetailResponse.self) {
            completion($0.result)
        }
    }

    func updatePartnerCashbackLimit(cashbackLimit: Int, completion: @escaping (Result<MerchantDetailResponse, AFError>) -> Void) {
        let url = Endpoints.updateMerchantDetail.url
        let body: [String: Int] = [
            "cashback_limit": cashbackLimit,
        ]

        requestWithToken(url: url, method: .put, parameters: body, decodable: MerchantDetailResponse.self) {
            completion($0.result)
        }
    }

    func updatePartnerDailyTokenLimit(dailyTokenLimit: Int, completion: @escaping (Result<MerchantDetailResponse, AFError>) -> Void) {
        let url = Endpoints.updateMerchantDetail.url
        let body: [String: Int] = [
            "daily_token_limit": dailyTokenLimit,
        ]

        requestWithToken(url: url, method: .put, parameters: body, decodable: MerchantDetailResponse.self) {
            completion($0.result)
        }
    }

    func updatePartnerIsActiveToken(isActiveToken: Bool, completion: @escaping (Result<MerchantDetailResponse, AFError>) -> Void) {
        let url = Endpoints.updateMerchantDetail.url
        let body: [String: Bool] = [
            "is_active_generating_token": isActiveToken,
        ]

        requestWithToken(url: url, method: .put, parameters: body, decodable: MerchantDetailResponse.self) {
            completion($0.result)
        }
    }
}

// MARK: Instagram

extension RequestFunction {
    func approveStory(_ isApproved: Bool, id: Int, completionHandler: @escaping (_ data: ApproveOrRejectStoryResponse) -> Void) {
        let url = Endpoints.approveOrRejectStory.url
        let body: [String: Any] = [
            "id": id,
            "approved": isApproved,
        ]
        requestWithToken(url: url, method: .put, parameters: body, decodable: ApproveOrRejectStoryResponse.self) { response in
            switch response.result {
            case let .success(data):
                completionHandler(data)
            case let .failure(error):
                print(error)
            }
        }
    }

    func submitStory(storyId: Int, instagtamStoryId: Int) {
        let url = Endpoints.register.url
        let body: [String: Int] = [
            "story_id": storyId,
            "instagram_story_id": instagtamStoryId,
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json",
        ]
        AF.request(url, method: .post, parameters: body, headers: headers)
            .response { response in
                switch response.result {
                case let .success(data):
                    print(data)
                case let .failure(error):
                    print(error)
                }
            }
    }

    func postGenerateTokenOnline(purchaseAmount: Int, completion: @escaping (Result<GenerateTokenOnlineResponse, AFError>) -> Void) {
        let url = Endpoints.generateToken.url
        let body: [String: Int] = [
            "purchase_amount": purchaseAmount,
        ]

        requestWithToken(url: url, method: .post, parameters: body, decodable: GenerateTokenOnlineResponse.self) {
            completion($0.result)
        }
    }

    func postGenerateTokenOffline(customerId: Int, purchaseAmount: Int, completion: @escaping (Result<GenerateTokenOfflineResponse, AFError>) -> Void) {
        let url = Endpoints.generateToken.url
        let body: [String: Int] = [
            "customer_id": customerId,
            "purchase_amount": purchaseAmount,
        ]

        requestWithToken(url: url, method: .post, parameters: body, decodable: GenerateTokenOfflineResponse.self) {
            completion($0.result)
        }
    }

    func redeemToken(token: String, completion: @escaping (Result<GenerateTokenOfflineResponse, AFError>) -> Void) {
        let url = Endpoints.redeemToken.url
        let body: [String: String] = [
            "token": token,
        ]

        requestWithToken(url: url, method: .post, parameters: body, decodable: GenerateTokenOfflineResponse.self) {
            completion($0.result)
        }
    }

    func getProfileIG(username: String, completion: @escaping (Result<ProfileIGResponse, AFError>) -> Void) {
        let url = "\(Endpoints.getProfileIG.url)\(username)"

        requestWithToken(url: url, decodable: ProfileIGResponse.self) {
            completion($0.result)
        }
    }

    func getUserIG(id: String, completion: @escaping (Result<ProfileIGResponse, AFError>) -> Void) {
        let url = "\(Endpoints.getUserIG.url)\(id)"

        requestWithToken(url: url, decodable: ProfileIGResponse.self) {
            completion($0.result)
        }
    }

    func getStoryIG(storyId: Int, completion: @escaping (Result<MentionStoryIGResponse, AFError>) -> Void) {
        let url = Endpoints.toStoryIG.url
        let parameters: [String: Int] = [
            "story_id": storyId,
        ]

        requestWithToken(url: url, parameters: parameters, decodable: MentionStoryIGResponse.self) {
            completion($0.result)
        }
    }
}

extension RequestFunction {
    func getListCustomer(completion: @escaping (Result<ListCustomerResponse, AFError>) -> Void) {
        let url = Endpoints.getListCustomer.url

        requestWithToken(url: url, decodable: ListCustomerResponse.self) {
            completion($0.result)
        }
    }

    func getListMerchant(completion: @escaping (Result<ListMerchantResponse, AFError>) -> Void) {
        let url = Endpoints.getListMerchant.url

        requestWithToken(url: url, decodable: ListMerchantResponse.self) {
            completion($0.result)
        }
    }

    func getListTransaction(completion: @escaping (Result<ListTransactionResponse, AFError>) -> Void) {
        let url = Endpoints.getListTransaction.url

        requestWithToken(url: url, decodable: ListTransactionResponse.self) {
            completion($0.result)
        }
    }
}

extension RequestFunction {
    private func requestWithToken<T: Decodable>(
        url: String,
        method: HTTPMethod = .get,
        parameters: Dictionary<String, Any>? = nil,
        decodable: T.Type = T.self,
        completionHandler: @escaping (DataResponse<T, AFError>) -> Void) {
        AuthManager.shared.withValidToken { token in
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)",
                "Accept": "application/json",
            ]
            AF.request(url, method: method, parameters: parameters, headers: headers)
                .validate()
                .responseDecodable(of: decodable) { response in
                    completionHandler(response)
                }
        }
    }

    private func fetchHeadersForDeviceRegistration(completion: @escaping (Result<HTTPHeaders, Error>) -> Void
    ) {
        var headers: HTTPHeaders = [
            "x-device-identifier": UIDevice.current.identifierForVendor?.uuidString ?? "",
            "x-device-name": UIDevice.current.name,
            "x-device-os": UIDevice.current.systemName,
            "x-device-os-version": UIDevice.current.systemVersion,
            "x-device-model": UIDevice.current.model,
        ]

        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
                completion(.failure(error))
            } else if let token = token {
                headers["x-device-notification-token"] = token
                completion(.success(headers))
            }
        }
    }
}
