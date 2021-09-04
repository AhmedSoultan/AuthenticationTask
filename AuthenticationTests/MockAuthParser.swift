//
//  MockAuthParser.swift
//  AuthenticationTests
//
//  Created by ahmed sultan on 04/09/2021.
//


import UIKit
@testable import Authentication

class MockAuthParser {
    
    var shouldReturnError = false
    
    func reset() {
        shouldReturnError = false
    }
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }

    let jsonResponse: [String: Any] =
        [
            "uuid": "96935a77-e4bc-4605-bb62-4259e8a618e6",
            "image": "https://placeimg.com/480/480/tech",
            "firstName": "John",
            "lastName": "Doe",
            "address": "Nowhere st. 12345, Everywhere",
            "phone": "+370 XXX XXXXX"
        ]
}

extension MockAuthParser: ParsingProtocol {
 
    func parseResponse<ResponseType: Decodable>(_ jsonDict: [AnyHashable : Any], responseType: ResponseType.Type) -> ResponseType? {
        
        // shouldReturnError simulate the failure

        if shouldReturnError {
            return nil
        } else {
            guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict,
                                                             options: []) else {return nil}
            let decoder = JSONDecoder()
            return try? decoder.decode(ResponseType.self, from: jsonData)
        }
    }
    
    func parse<ResponseType>(_ jsonDict: [AnyHashable : Any], responseType: ResponseType.Type) -> ResponseType? where ResponseType : Decodable {
        
        // shouldReturnError simulate the failure
        
        if shouldReturnError {
            return nil
        } else {
            return parseResponse(jsonDict, responseType: ResponseType.self)
        }
    }
}
