//
//  File.swift
//  Authentication
//
//  Created by ahmed sultan on 03/09/2021.
//

import Foundation

class AuthClient {
    private var parser = AuthParser()

    func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void)  {
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
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonDict: [String: Any] = jsonObject as? [String: Any] {
                    let responseObject = self.parser.parse(jsonDict, responseType: ResponseType.self)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    func taskForPOSTRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body:Data?, completion: @escaping (ResponseType?, Error?) -> Void) {
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
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonDict: [String: Any] = jsonObject as? [String: Any] {
                    let responseObject = self.parser.parse(jsonDict, responseType: ResponseType.self)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
}
