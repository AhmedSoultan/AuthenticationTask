//
//  File.swift
//  Authentication
//
//  Created by ahmed sultan on 03/09/2021.
//

import Foundation

class AuthClient {
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void)  {
        var request = URLRequest(url: url)
       
        request.httpMethod = "Get"
        request.addValue("Bearer \(Auth.token ?? "")", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    class func taskForPOSTRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body:Data?, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
       
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    class func postCredentials(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        let username = username.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let dataThing = "username=\(username)&password=\(password)".data(using: .utf8)
        taskForPOSTRequest(url: Endpoints.postCredentials.url, responseType: CredentialsResponse.self, body: dataThing) { response, error in
            if let response = response {
                UserDefaults.standard.set(response.token, forKey: "token")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                Auth.token = response.token
                completion(true, nil)
            } else {
                completion(false, "There is something worng happened, please try again later")
            }
        }
    }
    
    class func getUserProfile(completion: @escaping (ProfileResponse?, String?) -> Void) {
        taskForGETRequest(url: Endpoints.getUserProfile.url, responseType: ProfileResponse.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, "There is something worng happened, please try again later")
            }
        }
    }
}
