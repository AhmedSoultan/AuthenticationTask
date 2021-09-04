//
//  AuthParser.swift
//  Authentication
//
//  Created by ahmed sultan on 04/09/2021.
//

import Foundation

class AuthParser: ParsingProtocol {
    
    func parse<ResponseType: Decodable>(_ jsonDict: [AnyHashable : Any], responseType: ResponseType.Type) -> ResponseType? {
        return parseResponse(jsonDict, responseType: responseType)
    }
    private func parseResponse<ResponseType: Decodable>(_ jsonDict: [AnyHashable : Any], responseType: ResponseType.Type) -> ResponseType? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict,
                                                         options: []) else { return nil }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(responseType.self, from: jsonData)
        } catch {
            return nil
        }
    }
}
