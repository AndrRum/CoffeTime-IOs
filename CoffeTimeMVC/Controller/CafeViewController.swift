//
//  CafeController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 08.10.2023.
//

import Foundation
import UIKit

class CafeViewController: UIViewController {
    
    var cafe: CafeModel? {
        didSet {
            cafeView.cafe = cafe
        }
    }
    
    private var cafeView = CafeView()
    private var pageHeaderView = PageHeaderView()
    
    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.isHidden = true
        setupCafeView()
    }
    
    func setupCafeView() {
        cafeView.delegate = self
        cafeView.setHeaderViewDelegate(self)
        cafeView.cafe = cafe
        self.view = cafeView
    }
}

extension CafeViewController: PageHeaderViewDelegate {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func favoriteButtonTapped() {
        
    }
}

extension CafeViewController: CafeViewDelegate {
    
}
