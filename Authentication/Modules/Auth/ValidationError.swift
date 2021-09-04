//
//  ValidationError.swift
//  Authentication
//
//  Created by ahmed sultan on 02/09/2021.
//

import Foundation

enum ValidationError: LocalizedError {
    case incorrectUsername
    case incorrectPassword
    case incorrectCredentials
}
extension ValidationError {
    var errerDescription: String {
        switch self {
        case .incorrectUsername:
            return "incorrectUsername"
        case .incorrectPassword:
            return "incorrectUsername"
        case .incorrectCredentials:
            return "incorrectUsername"
        }
    }
}
