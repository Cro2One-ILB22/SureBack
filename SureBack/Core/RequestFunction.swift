//
//  RequestFunction.swift
//  SureBack
//
//  Created by Ditha Nurcahya Avianty on 25/10/22.
//

import Foundation
import Alamofire

class RequestFunction {
    
    func postLogin(url: String, bodyLogin: [String: String]) {
        
        AF.request(url, method: .post, parameters: bodyLogin).responseDecodable(of: ResponsePostLogin.self) { response in
            switch response.result {
            case .success(let data):
                self.getAccount(url: Endpoints.getAccount.url, accessToken: data.accessToken)
                print(data.accessToken)
            case .failure(_):
                print("Failed to connect")
            }
        }
    }
    
    func getAccount(url: String, accessToken: String){
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json"
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: Account.self) { response in
            print(response.result)
        }
    }
    
    
}
