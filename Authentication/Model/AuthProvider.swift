//
//  AuthProvider.swift
//  Authentication
//
//  Created by ahmed sultan on 04/09/2021.
//

import UIKit

class AuthProvider {
    
    private var authClient = AuthClient()
    
    func postCredentials(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        let username = username.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let dataThing = "username=\(username)&password=\(password)".data(using: .utf8)
        authClient.taskForPOSTRequest(url: Endpoints.postCredentials.url, responseType: CredentialsResponse.self, body: dataThing) { response, error in
            if let response = response {
                UserDefaults.standard.set(response.token, forKey: "token")
                UserDefaults.standard.set(response.refreshToken, forKey: "refreshToken")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                Auth.token = response.token
                completion(true, nil)
            } else {
                completion(false, "There is something worng happened, please try again later")
            }
        }
    }
    
    func getUserProfile(completion: @escaping (ProfileResponse?, String?) -> Void) {
        authClient.taskForGETRequest(url: Endpoints.getUserProfile.url, responseType: ProfileResponse.self) { responseObject, error in
            if let responseObject = responseObject {
                completion(responseObject, nil)
            } else {
                completion(nil, "There is something worng happened, please try again later")
            }
        }
    }
}
