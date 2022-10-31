//
//  RequestFunction.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 25/10/22.
//

import Foundation
import Alamofire

class RequestFunction {

    // MARK: Auth
    func postLogin(url: String, body: [String: String]) {
        AF.request(url, method: .post, parameters: body).responseDecodable(of: ResponsePostLogin.self) { response in
            switch response.result {
            case .success(let data):

                print(data.roles)
                self.getAccount(url: Endpoints.getAccount.url, accessToken: data.accessToken) { result in
                    print(result)
                }

                self.getProfileIG(url: "\(Endpoints.getProfileIG.url)dithanrchy", accessToken: data.accessToken) { result in
                    print(result)
                }

                //body ntar ubah jadi model
                let bodyGenerateTokenOnline: [String: Int] = [
                    "purchase_amount": 1000,
                ]
                self.postGenerateTokenOnline(url: Endpoints.generateToken.url, accessToken: data.accessToken, body: bodyGenerateTokenOnline) { result in
                    print(result)
                }

                let bodyGenerateTokenffline: [String: Int] = [
                    "customer_id": 2,
                    "purchase_amount": 100
                ]

                self.postGenerateTokenOffline(url: Endpoints.generateToken.url, accessToken: data.accessToken, body: bodyGenerateTokenffline) { result in
                    print(result)
                }

                print(data.accessToken)
            case .failure(_):
                print("Failed to connect")
            }
        }
    }

    func getAccount(url: String, accessToken: String, completion: @escaping (Result<Account, AFError>) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json"
        ]
        AF.request(url, headers: headers).responseDecodable(of: Account.self) {
            completion($0.result)
        }
    }

    // MARK: Instagram

    func getProfileIG(url: String, accessToken: String, completion: @escaping (Result<ProfileIG, AFError>) -> Void) {

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]

        AF.request(url, headers: headers).responseDecodable(of: ProfileIG.self) {
            completion($0.result)
        }
    }

    func postGenerateTokenOnline(url: String, accessToken: String, body: [String: Int], completion: @escaping (Result<GenerateTokenOnline, AFError>) -> Void){

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]

        AF.request(url, method: .post, parameters: body, headers: headers).responseDecodable(of: GenerateTokenOnline.self) {
            completion($0.result)
        }
    }

    func postGenerateTokenOffline(url: String, accessToken: String, body: [String: Int], completion: @escaping (Result<GenerateTokenOffline, AFError>) -> Void){

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]

        AF.request(url, method: .post, parameters: body, headers: headers).responseDecodable(of: GenerateTokenOffline.self) { 
            completion($0.result)
        }
    }


}


