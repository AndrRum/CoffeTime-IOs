//
//  FavoriteViewController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 29.10.2023.
//

import Foundation
import UIKit

class FavoriteViewController: UIViewController {
    var isCafeFavorites: Bool = false
    
    override func loadView() {
        let view = FavoriteView(isCafeFavorites: isCafeFavorites)
        view.delegate = self
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension FavoriteViewController: FavoriteViewDelegate {
    func closeButtonTapped() {
        self.dismiss(animated: true)
    }
}
