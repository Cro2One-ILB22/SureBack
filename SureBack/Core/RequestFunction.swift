//
//  RequestFunction.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 25/10/22.
//

import Alamofire
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
    func postLogin(email: String, password: String, completionHandler: @escaping (_ data: LoginResponse) -> Void) {
        let url = Endpoints.login.url

        let body: [String: String] = [
            "email": email,
            "password": password
        ]
        AF.request(url, method: .post, parameters: body).responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case let .success(data):
                completionHandler(data)
            case .failure:
                print("Failed to login")
            }
        }
    }
    func preRegister(name: String, email: String, password: String, role: String, username: String) {
        let url = Endpoints.preRegister.url
        let body: [String: String] = [
            "name": name,
            "email": email,
            "password": password,
            "role": role,
            "username": password
        ]
        AF.request(url, method: .post, parameters: body)
            .validate()
            .responseDecodable(of: RequestInstagramOTPResponse.self) { response in
                switch response.result {
                case let .success(data):
                    print("Data", data)
                case let .failure(error):
                    print(error)
                }
            }
    }

    func register(name: String, email: String, password: String, role: String, username: String) {
        let url = Endpoints.register.url
        let body: [String: String] = [
            "name": name,
            "email": email,
            "password": password,
            "role": role,
            "username": username
        ]
        AF.request(url, method: .post, parameters: body)
            .validate()
            .responseDecodable(of: VerifyInstagramOTPResponse.self) { response in
                switch response.result {
                case let .success(data):
                    print("Data", data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
    }
    func getAccount(completion: @escaping (Result<AccountInfoResponse, AFError>) -> Void) {
        let url = Endpoints.getAccount.url
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json"
        ]
        AF.request(url, headers: headers)
            .validate()
            .responseDecodable(of: AccountInfoResponse.self) {
                completion($0.result)
            }
    }
}

// MARK: User
extension RequestFunction {
    func updateUser(name: String, completionHandler: @escaping (_ data: UpdateUserResponse) -> Void) {
        let url = Endpoints.updateUser.url
        let body: [String: String] = [
            "name": name
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json"
        ]
        AF.request(url, method: .put, parameters: body, headers: headers)
            .validate()
            .responseDecodable(of: UpdateUserResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
}

// MARK: Instagram
extension RequestFunction {
    func approveStory(_ isApproved: Bool, id: Int, completionHandler: @escaping (_ data: ApproveOrRejectStoryResponse) -> Void) {
        let url = Endpoints.approveOrRejectStory.url
        let body: [String: Any] = [
            "id": id,
            "approved": isApproved
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json"
        ]
        AF.request(url, method: .put, parameters: body, headers: headers)
            .validate()
            .responseDecodable(of: ApproveOrRejectStoryResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
    func submitStory(storyId: Int, instagtamStoryId: Int) {
        let url = Endpoints.register.url
        let body: [String: Int] = [
            "story_id": storyId,
            "instagram_story_id": instagtamStoryId
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json"
        ]
        AF.request(url, method: .post, parameters: body, headers: headers)
            .response { response in
                switch response.result {
                case.success(let data):
                    print(data)
                case.failure(let error):
                    print(error)
                }
            }
    }

    func postGenerateTokenOnline(accessToken: String, purchaseAmount: Int, completion: @escaping (Result<GenerateTokenOnlineResponse, AFError>) -> Void) {
        let url = Endpoints.generateToken.url

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]

        let body: [String: Int] = [
            "purchase_amount": purchaseAmount,
        ]

        AF.request(url, method: .post, parameters: body, headers: headers).responseDecodable(of: GenerateTokenOnlineResponse.self) {
            completion($0.result)
        }
    }

    func postGenerateTokenOffline(accessToken: String, customerId: Int, purchaseAmount: Int, completion: @escaping (Result<GenerateTokenOfflineResponse, AFError>) -> Void) {
        let url = Endpoints.generateToken.url

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]

        let body: [String: Int] = [
            "customer_id": customerId,
            "purchase_amount": purchaseAmount,
        ]

        AF.request(url, method: .post, parameters: body, headers: headers).responseDecodable(of: GenerateTokenOfflineResponse.self) {
            completion($0.result)
        }
    }

    func redeemToken(accessToken: String, token: String, completion: @escaping (Result<GenerateTokenOfflineResponse, AFError>) -> Void) {
        let url = Endpoints.redeemToken.url

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]

        let body: [String: String] = [
            "token": token,
        ]

        AF.request(url, method: .post, parameters: body, headers: headers).responseDecodable(of: GenerateTokenOfflineResponse.self) {
            completion($0.result)
        }
    }

    func getProfileIG(accessToken: String, username: String, completion: @escaping (Result<ProfileIGResponse, AFError>) -> Void) {
        let url = Endpoints.getProfileIG.url

        let parameters: [String: String] = [
            "username": username,
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]
        AF.request(url, parameters: parameters, headers: headers).responseDecodable(of: ProfileIGResponse.self) {
            completion($0.result)
        }
    }

    func postGenerateTokenOnline(url: String, accessToken: String, body: [String: Int], completion: @escaping (Result<GenerateTokenOnlineResponse, AFError>) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]
        AF.request(url, method: .post, parameters: body, headers: headers).responseDecodable(of: GenerateTokenOnlineResponse.self) {
            completion($0.result)
        }
    }
    func postGenerateTokenOffline(url: String, accessToken: String, body: [String: Int], completion: @escaping (Result<GenerateTokenOfflineResponse, AFError>) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]

        AF.request(url, method: .post, parameters: body, headers: headers).responseDecodable(of: GenerateTokenOfflineResponse.self) {
            completion($0.result)
        }
    }

    func getStoryIG(accessToken: String, storyId: Int, completion: @escaping (Result<MentionStoryIGResponse, AFError>) -> Void) {
        let url = Endpoints.getStoryIG.url

        let parameters: [String: Int] = [
            "story_id": storyId,
        ]

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]

        AF.request(url, parameters: parameters, headers: headers).responseDecodable(of: MentionStoryIGResponse.self) { response in
            print(response.result)
        }
    }
}

extension RequestFunction {
    func getListCustomer(accessToken: String, completion: @escaping (Result<ListCustomerResponse, AFError>) -> Void) {
        let url = Endpoints.getListCustomer.url

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]

        AF.request(url, headers: headers).responseDecodable(of: ListCustomerResponse.self) {
            completion($0.result)
        }
    }

    func getListPartner(accessToken: String, completion: @escaping (Result<ListPartnerResponse, AFError>) -> Void) {
        let url = Endpoints.getListPartner.url

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]

        AF.request(url, headers: headers).responseDecodable(of: ListPartnerResponse.self) {
            completion($0.result)
        }
    }

    func getListTransaction(accessToken: String, completion: @escaping (Result<ListTransactionResponse, AFError>) -> Void) {
        let url = Endpoints.getListTransaction.url

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]

        AF.request(url, headers: headers).responseDecodable(of: ListTransactionResponse.self) {
            completion($0.result)
        }
    }
}
