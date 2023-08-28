//
//  UIViewControllerExtension.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 29.08.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showHttpErrorView(from presentingViewController: UIViewController, errorViewController: ErrorViewController) {
        DispatchQueue.main.async {
            errorViewController.modalPresentationStyle = .overFullScreen
            presentingViewController.present(errorViewController, animated: true, completion: nil)
        }
    }
}
