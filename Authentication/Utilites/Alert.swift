//
//  Alert.swift
//  Authentication
//
//  Created by ahmed sultan on 02/09/2021.
//

import UIKit

class Alert {
    class func present(Title alertTitle:String, Message alertBody:String, _ viewController:UIViewController, completion: (() -> Void)? = nil) {
       
        let alertAction = UIAlertController(title: alertTitle, message: alertBody, preferredStyle: UIAlertController.Style.alert)
                   
        alertAction.addAction(UIAlertAction(title: "OK", style:UIAlertAction.Style.cancel) {
            action in
            completion?()
        })
        viewController.present(alertAction, animated: true, completion: nil)
    }
}
