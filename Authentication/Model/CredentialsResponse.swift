//
//  CredentialsResponse.swift
//  Authentication
//
//  Created by ahmed sultan on 03/09/2021.
//

import Foundation

struct CredentialsResponse: Codable {
    
    let token : String?
    let refreshToken : String?

    enum CodingKeys: String, CodingKey {

        case token = "token"
        case refreshToken = "refreshToken"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        refreshToken = try values.decodeIfPresent(String.self, forKey: .refreshToken)
    }
}
