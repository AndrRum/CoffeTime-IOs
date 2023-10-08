//
//  CafeController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 08.10.2023.
//

import Foundation
import UIKit

class CafeViewController: UIViewController {
    
    var selectedCafe: CafeModel? {
        didSet {
            if let cafe = selectedCafe {
                print("Selected cafe: \(String(describing: cafe.name))")
            }
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
        self.view = cafeView
    }
}

extension CafeViewController: PageHeaderViewDelegate {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension CafeViewController: CafeViewDelegate {
    
}
