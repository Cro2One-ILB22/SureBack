//
//  RequestFunction.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 25/10/22.
//

import Alamofire
import Foundation

class RequestFunction {
    // MARK: Auth

    func postLogin(email: String, password: String) {
        let url = Endpoints.login.url

        let body: [String: String] = [
            "email": email,
            "password": password,
        ]

        AF.request(url, method: .post, parameters: body).responseDecodable(of: ResponsePostLogin.self) { response in
            switch response.result {
            case let .success(data):

                print(data.roles)

                self.getAccount(accessToken: data.accessToken) { result in
                    print(result)
                }

                self.getProfileIG(accessToken: data.accessToken, username: "dithanrchy") { result in
                    print(result)
                }

                self.postGenerateTokenOnline(accessToken: data.accessToken, purchaseAmount: 1000) { result in
                    print(result)
                }

                self.postGenerateTokenOffline(accessToken: data.accessToken, customerId: 810194945419968513, purchaseAmount: 1000) { result in
                    switch result {
                    case let .success(data):
                        print("story id: \(data.story.id)")
                    case let .failure(error):
                        print(error.localizedDescription)
                    }
                }

                self.getStoryIG(accessToken: data.accessToken, storyId: 810204763009581058) { result in
                    print(result)
                }

                self.redeemToken(accessToken: data.accessToken, token: "09c7e080") { result in
                    print(result)
                }

                print(data.accessToken)
            case .failure:
                print("Failed to login")
            }
        }
    }

    func getAccount(accessToken: String, completion: @escaping (Result<Account, AFError>) -> Void) {
        let url = Endpoints.getAccount.url

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json",
        ]
        AF.request(url, headers: headers).responseDecodable(of: Account.self) {
            completion($0.result)
        }
    }

    func postGenerateTokenOnline(accessToken: String, purchaseAmount: Int, completion: @escaping (Result<GenerateTokenOnline, AFError>) -> Void) {
        let url = Endpoints.generateToken.url

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]

        let body: [String: Int] = [
            "purchase_amount": purchaseAmount,
        ]

        AF.request(url, method: .post, parameters: body, headers: headers).responseDecodable(of: GenerateTokenOnline.self) {
            completion($0.result)
        }
    }

    func postGenerateTokenOffline(accessToken: String, customerId: Int, purchaseAmount: Int, completion: @escaping (Result<GenerateTokenOffline, AFError>) -> Void) {
        let url = Endpoints.generateToken.url

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]

        let body: [String: Int] = [
            "customer_id": customerId,
            "purchase_amount": purchaseAmount,
        ]

        AF.request(url, method: .post, parameters: body, headers: headers).responseDecodable(of: GenerateTokenOffline.self) {
            completion($0.result)
        }
    }

    func redeemToken(accessToken: String, token: String, completion: @escaping (Result<GenerateTokenOffline, AFError>) -> Void) {
        let url = Endpoints.redeemToken.url

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]

        let body: [String: String] = [
            "token": token,
        ]

        AF.request(url, method: .post, parameters: body, headers: headers).responseDecodable(of: GenerateTokenOffline.self) {
            completion($0.result)
        }
    }

    // MARK: Instagram

    func getProfileIG(accessToken: String, username: String, completion: @escaping (Result<ProfileIG, AFError>) -> Void) {
        let url = "\(Endpoints.getProfileIG.url)\(username)"

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]

        AF.request(url, headers: headers).responseDecodable(of: ProfileIG.self) {
            completion($0.result)
        }
    }

    func getStoryIG(accessToken: String, storyId: Int, completion: @escaping (Result<StoryIG, AFError>) -> Void) {
        let url = "\(Endpoints.getStoryIG.url)\(storyId)"

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]

        AF.request(url, headers: headers).responseDecodable(of: StoryIG.self) { response in
            print(response.result)
        }
    }
}
