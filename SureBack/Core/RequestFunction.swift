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
        AF.request(url, method: .post, parameters: body).responseDecodable(of: LoginResponse.self) { response in
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
    
    func preRegister(name: String, email: String, password: String, role: String, username: String) {
        let url = Endpoints.preRegister.url
        let body: [String: String] = [
            "name": name,
            "email": email,
            "password": password,
            "role": role,
            "username": password
        ]
        print("URL", url)
        AF.request(url, method: .post, parameters: body)
            .validate()
            .responseDecodable(of: RequestInstagramOTPResponse.self) { response in
                switch response.result {
                case .success(let data):
                    print("Data", data)
                case .failure(let error):
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
                case .success(let data):
                    print("Data", data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func submitStory(storyId: Int, instagtamStoryId: Int, accessToken: String) {
        let url = Endpoints.register.url
        let body: [String: Int] = [
            "story_id": storyId,
            "instagram_story_id": instagtamStoryId,
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json"
        ]
        AF.request(url, method: .post, parameters: body, headers: headers)
            .validate()
            .responseDecodable(of: VerifyInstagramOTPResponse.self) { response in
                switch response.result {
                case .success(let data):
                    print("Data", data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func getAccount(url: String, accessToken: String, completion: @escaping (Result<Account, AFError>) -> Void) {
        let url = Endpoints.getAccount.url
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json"
        ]
        AF.request(url, headers: headers)
            .validate()
            .responseDecodable(of: Account.self) {
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


