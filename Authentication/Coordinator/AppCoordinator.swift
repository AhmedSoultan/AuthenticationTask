//
//  AppCoordinator.swift
//  Authentication
//
//  Created by ahmed sultan on 02/09/2021.
//

import UIKit

class AppCoordinator {
    
    //MARK:- PROPERTIES
    
    static var shared = AppCoordinator()
    
    lazy var authNavigator: AuthNavigator = {
        return AuthNavigator()
    }()
    lazy var profileNavigator: ProfileNavigator = {
        return ProfileNavigator()
    }()

    //MARK:- LIFE CYCLE
    private init() {
    }
    
    //MARK:- CUSTOM ACTION
    func start(with window: UIWindow?) {
        window?.rootViewController = rootViewController()
        window?.makeKeyAndVisible()
    }
    func rootViewController() -> UIViewController {
        var rootVC: UIViewController
        if Auth.isLoggedIn == true {
            rootVC = profileNavigator.viewController(for: .profile)
        } else {
            rootVC = authNavigator.viewController(for: .login)
        }
        let naviagationController = UINavigationController(rootViewController: rootVC)
        return naviagationController
    }
}
