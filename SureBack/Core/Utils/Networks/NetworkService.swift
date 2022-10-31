//
//  RequestFunction.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 25/10/22.
//

import Foundation
import Alamofire

class NetworkService {
    func postLogin(email: String, password: String) {
        let url = Endpoints.login.url
        let body: [String: String] = [
            "email": email,
            "password": password
        ]
        AF.request(url, method: .post, parameters: body)
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.getAccount(accessToken: data.accessToken)
                self.getProfileIG(accessToken: data.accessToken)
                print(data.accessToken)
            case .failure(_):
                print("Failed to connect")
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
        AF.request(url, parameters: body)
            .validate()
            .responseDecodable(of: PreRegisterResponse.self) { response in
                switch response.result {
                case .success(let data):
                    print("Data", data)
                case .failure(let error):
                    print(error)
                }
            }
    }
    func register(name: String, email: String, password: String, role: String, username: String) {
//        let url = Endpoints.register.url
//        let body: [String: String] = [
//            "name": name,
//            "email": email,
//            "password": password,
//            "role": role,
//            "username": password
//        ]
//        AF.request(url, parameters: body)
//            .validate()
//            .responseDecodable(of: RegisterResponse.self) { response in
//                switch response.result {
//                case .success(let data):
//                    print("Data", data)
//                case .failure(let error):
//                    print(error)
//                }
//            }
    }
    func getAccount(accessToken: String) {
        let url = Endpoints.getAccount.url
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json"
        ]
        AF.request(url, headers: headers).responseDecodable(of: Account.self) { response in
            print(response.result)
        }
    }

    func getProfileIG(accessToken: String) {
        let url = "\(Endpoints.getAccount.url)dithanrchy"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        AF.request(url, headers: headers).responseDecodable(of: ProfileIG.self) { response in
            print(response.result)
        }
    }
}
