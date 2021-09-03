//
//  AppDelegate.swift
//  Authentication
//
//  Created by ahmed sultan on 02/09/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator = AppCoordinator.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        coordinator.start(with: window)

        return true
    }

}

