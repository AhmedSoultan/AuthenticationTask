//
//  ProfileNavigator.swift
//  Authentication
//
//  Created by ahmed sultan on 03/09/2021.
//

import UIKit

class ProfileNavigator: Navigator {
        
    enum Destination {
        case profile
    }
    
    func viewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .profile:
            return ProfileViewController(viewModel: ProfileViewModel())
        }
    }
}
