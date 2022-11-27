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
            "password": password,
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
    
    func postLogout(completionHandler: @escaping (Result<Data?, AFError>) -> Void) {
        let url = Endpoints.logout.url
        
        fetchHeadersForDeviceRegistration { response in
            switch response {
            case let .success(headers):
                self.requestWithToken(url: url, method: .post) { response in
                    switch response.result {
                    case .success:
                        do {
                            KeychainHelper.standard.delete(key: .accessToken)
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
            "username": username,
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
    func updateUser(name: String? = nil, email: String? = nil, completionHandler: @escaping (_ data: UserInfoResponse) -> Void) {
        let url = Endpoints.updateUser.url
        var body: [String: String] = [:]

        if name != nil {
            body["name"] = name
        }
        if email != nil {
            body["email"] = email
        }

        requestWithToken(url: url, method: .put, parameters: body, decodable: UserInfoResponse.self) { response in
            switch response.result {
            case let .success(data):
                completionHandler(data)
            case let .failure(error):
                if let data = response.data {
                    let json = String(data: data, encoding: .utf8)
                    print("Failure Response: \(String(describing: json))")
                }
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
    
    func submitStory(storyId: Int, instagtamStoryId: Int, completion: @escaping (Result<Data?, AFError>) -> Void) {
        let url = Endpoints.submitStory.url
        let body: [String: Int] = [
            "story_id": storyId,
            "instagram_story_id": instagtamStoryId,
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json",
        ]
        AF.request(url, method: .post, parameters: body, headers: headers)
            .validate()
            .response { response in
                completion(response.result)
                switch response.result {
                case .success:
                    break
                case let .failure(error):
                    if let data = response.data {
                        let json = String(data: data, encoding: .utf8)
                        print("Failure Response: \(String(describing: json))")
                    }
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
    
    func postGenerateTokenOffline(customerId: Int, purchaseAmount: Int, isRequestingToken: Int, completion: @escaping (Result<ScanQrResponse, AFError>) -> Void) {
        let url = Endpoints.scanQr.url
        let body: [String: Int] = [
            "customer_id": customerId,
            "purchase_amount": purchaseAmount,
            "is_requesting_for_token": isRequestingToken,
        ]
        
        requestWithToken(url: url, method: .post, parameters: body, decodable: ScanQrResponse.self) {
            response in
            completion(response.result)
            switch response.result {
            case .success:
                break
            case let .failure(error):
                if let data = response.data {
                    let json = String(data: data, encoding: .utf8)
                    print("Failure Response: \(String(describing: json))")
                }
            }
        }
    }
    
    func redeemToken(token: String, completion: @escaping (Result<Token, AFError>) -> Void) {
        let url = Endpoints.redeemToken.url
        let body: [String: String] = [
            "token": token,
        ]
        
        requestWithToken(url: url, method: .post, parameters: body, decodable: Token.self) {
            //            completion($0.result)
            response in
            completion(response.result)
            switch response.result {
            case .success:
                break
            case let .failure(error):
                //                print(error.localizedDescription)
                if let data = response.data {
                    let json = String(data: data, encoding: .utf8)
                    print("Failure Response: \(String(describing: json))")
                }
            }
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
    
    func getStoryIG(storyId: Int, completion: @escaping (Result<ResponseData<ResultStoryIG>, AFError>) -> Void) {
        let url = Endpoints.toStoryIG.url
        let parameters: [String: Int] = [
            "story_id": storyId,
        ]
        
        requestWithToken(url: url, parameters: parameters, decodable: ResponseData<ResultStoryIG>.self) {
            completion($0.result)
        }
    }
}

extension RequestFunction {
    func getListCustomer(completion: @escaping (Result<ResponseData<UserInfoResponse>, AFError>) -> Void) {
        let url = Endpoints.getListCustomer.url
        
        requestWithToken(url: url, decodable: ResponseData<UserInfoResponse>.self) {
            completion($0.result)
        }
    }
    
    func getListMerchant(completion: @escaping (Result<ResponseData<UserInfoResponse>, AFError>) -> Void) {
        let url = Endpoints.getListMerchant.url
        
        requestWithToken(url: url, decodable: ResponseData<UserInfoResponse>.self) {
            completion($0.result)
        }
    }

    func getListTransaction(merchantId: Int? = nil, accountingEntry: String? = nil, status: String? = nil, category: String? = nil, completion: @escaping (Result<ResponseData<Transaction>, AFError>) -> Void) {
        let url = Endpoints.getListTransaction.url

        var parameters: [String: Any] = [:]

        if merchantId != nil {
            parameters["merchant_id"] = merchantId
        }
        if accountingEntry != nil {
            parameters["accounting_entry"] = accountingEntry
        }
        if status != nil {
            parameters["status"] = status
        }
        if category != nil {
            parameters["category"] = category
        }

        requestWithToken(url: url, parameters: parameters, decodable: ResponseData<Transaction>.self) {
            completion($0.result)
        }
    }
    
    func getListToken(expired: Int? = nil, submitted: Int? = nil, redeemed: Int? = nil, completion: @escaping (Result<ResponseData<Token>, AFError>) -> Void) {
        let url = Endpoints.getToken.url
        var parameters: [String: Any] = [:]
        if expired != nil {
            parameters["expired"] = expired
        }
        if submitted != nil {
            parameters["submitted"] = submitted
        }
        if redeemed != nil {
            parameters["redeemed"] = redeemed
        }
        parameters["order_by"] = "updated_at"

        requestWithToken(url: url, parameters: parameters, decodable: ResponseData<Token>.self){ response in
            completion(response.result)
            if let data = response.data {
                let json = String(data: data, encoding: .utf8)
                print("Failure Response: \(String(describing: json))")
            }

        }
    }
    
    func getNotifications(completionHandler: @escaping (NotificationsResponses) -> Void) {
        let url = Endpoints.getNotifications.url
        requestWithToken(url: url, decodable: NotificationsResponses.self) { response in
            switch response.result {
            case let .success(data):
                completionHandler(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    func getCustomerStory(expired: Bool? = nil,
                          submitted: Bool? = nil,
                          approved: Bool? = nil,
                          assessed: Bool? = nil,
                          searchCustomerByName customerName: String? = nil,
                          searchCustomerById customerId: Int? = nil,
                          searchMerchantByName merchantName: String? = nil,
                          searchMerchantById merchantId: Int? = nil,
                          completionHandler: @escaping (MyStoryResponses) -> Void) {
        let url = Endpoints.getMyStory.url + "?customer_name=dit"
        var parameters: [String: Any?] = [:]
        parameters["expired"] = expired
        parameters["submitted"] = submitted
        parameters["approved"] = approved
        parameters["assessed"] = assessed
        parameters["customer_name"] = nil
        parameters["customer_id"] = customerId
        parameters["merchant_name"] = merchantName
        parameters["merchant_id"] = merchantId
        requestWithToken(url: url,
                         parameters: parameters as Dictionary<String, Any>,
                         decodable: MyStoryResponses.self) { response in
            switch response.result {
            case let .success(data):
                completionHandler(data)
            case let .failure(error):
                print("Errornya bos", error)
            }
        }
    }

    // MARK: ntar digabung sm yg diatas

    func getMyStoryCustomer(customerId: Int? = nil, merchantId: Int? = nil, customerName: String? = nil, merchantName: String? = nil, expired: Int? = nil, submitted: Int? = nil, approved: Int? = nil, assessed: Int? = nil, completionHandler: @escaping (Result<ResponseData<MyStoryData>, AFError>) -> Void) {
        let url = Endpoints.getMyStory.url

        var parameters: [String: Any?] = [:]

        parameters["customer_id"] = customerId
        parameters["merchant_id"] = merchantId
        parameters["customer_name"] = customerName
        parameters["merchant_name"] = merchantName
        parameters["expired"] = expired
        parameters["submitted"] = submitted
        parameters["approved"] = approved
        parameters["assessed"] = assessed

        requestWithToken(url: url, parameters: parameters, decodable: ResponseData<MyStoryData>.self) { response in
            completionHandler(response.result)
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
    
    private func requestWithToken(
        url: String,
        method: HTTPMethod = .get,
        parameters: Dictionary<String, Any>? = nil,
        headers: HTTPHeaders = [],
        completionHandler: @escaping (DataResponse<Data?, AFError>) -> Void) {
            AuthManager.shared.withValidToken { token in
                var generalHeaders: HTTPHeaders = [
                    "Authorization": "Bearer \(token)",
                    "Accept": "application/json",
                ]
                for header in headers {
                    generalHeaders.add(header)
                }
                AF.request(url, method: method, parameters: parameters, headers: headers)
                    .validate()
                    .response { response in
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
