//
//  Drawer+Extension.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 29.10.2023.
//

import Foundation
import UIKit

extension UIViewController {
    func addChildViewController(_ childViewController: UIViewController) {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }
}

extension DrawerMenuViewControllerDelegate where Self: UIViewController {
    func showDrawerMenu(viewController: DrawerMenuViewController) {
        
        viewController.delegate = self
        
        addChildViewController(viewController)
        view.addSubview(viewController.view)
        
        let width = view.frame.width / 1.5
        let height = view.frame.height
        
        let initialFrame = CGRect(x: view.frame.width, y: 0, width: width, height: height)
        let finalFrame = CGRect(x: view.frame.width - width, y: 0, width: width, height: height)
        
        viewController.view.layer.zPosition = 999
        viewController.view.frame = initialFrame
        
        UIView.animate(withDuration: 0.3) {
            viewController.view.frame = finalFrame
        }
    }

    func drawerMenuDidClose(viewController: DrawerMenuViewController) {
        UIView.animate(withDuration: 0.3, animations: {
            viewController.view.frame.origin.x = self.view.frame.width
        }) { (_) in
            viewController.willMove(toParent: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParent()
        }
    }
}
