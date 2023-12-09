//
//  AuthViewControllerExtension.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 04.09.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func authenticateAndNavigate(url: String, email: String, password: String, service: UserDataService, completion: @escaping (String?) -> Void) {
        service.authUser(url: url, email: email, password: password) { sessionId in
            if let sessionId = sessionId {
                print("Session ID:", sessionId)
                service.saveResponse(sessionId: sessionId)
                completion(sessionId)
            } else {
                print("Authentication failed.")
                completion(nil)
            }
        }
    }
    
    func navigateToCafeListScreen() {
        DispatchQueue.main.async {
            if let navigationController = self.navigationController {
                navigationController.navigationBar.barStyle = .black
                let cafeListViewController = CafeListViewController()
                navigationController.setViewControllers([cafeListViewController], animated: true)
            }
        }
    }
}
