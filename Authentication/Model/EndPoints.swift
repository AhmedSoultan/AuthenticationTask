//
//  EndPoints.swift
//  Authentication
//
//  Created by ahmed sultan on 03/09/2021.
//

import Foundation


enum Endpoints {
    static let base = "https://vidqjclbhmef.herokuapp.com/"
    
    case postCredentials
    case getUserProfile
    
    var stringValue: String {
        switch self {
        case .postCredentials: return Endpoints.base + "credentials"
        case .getUserProfile:
            return Endpoints.base + "user"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
