//
//  AuthViewControllerExtension.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 04.09.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
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
