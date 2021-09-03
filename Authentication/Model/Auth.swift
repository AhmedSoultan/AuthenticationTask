//
//  Auth.swift
//  Authentication
//
//  Created by ahmed sultan on 03/09/2021.
//

import Foundation

struct Auth {
    static var token = UserDefaults.standard.string(forKey: "token") as? String
    static var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
}
