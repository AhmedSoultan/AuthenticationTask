//
//  AuthNavigator.swift
//  Authentication
//
//  Created by ahmed sultan on 02/09/2021.
//

import UIKit

class AuthNavigator: Navigator {
        
    enum Destination {
        case login
    }
    
    func viewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .login:
            return AuthViewController(viewModel: AuthViewModel())
        }
    }
}
