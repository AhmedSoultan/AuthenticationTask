//
//  Navigator.swift
//  Authentication
//
//  Created by ahmed sultan on 02/09/2021.
//

import UIKit
enum NavigationTpe {
    case push
    case present
    case root
}

protocol Navigator {
    associatedtype Destination
    
    func viewController(for destination: Destination) -> UIViewController
    func navigate(to destination: Destination, with navigationTpe:NavigationTpe, and navigationController:UINavigationController?)
}
extension Navigator {
    func navigate(to destination: Destination, with navigationTpe:NavigationTpe, and navigationController:UINavigationController?) {
        switch navigationTpe {
        case .push:
            navigationController?.pushViewController(self.viewController(for: destination), animated: true)
        case .present:
            let naviagationController = UINavigationController(rootViewController: self.viewController(for: destination))
            naviagationController.modalPresentationStyle = .fullScreen
            navigationController?.present(naviagationController, animated: true, completion: nil)
        case .root:
            navigationController?.setViewControllers([self.viewController(for: destination)], animated: true)
        }
    }
}
