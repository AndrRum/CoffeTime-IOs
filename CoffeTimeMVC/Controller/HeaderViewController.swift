//
//  HeaderViewController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 04.09.2023.
//

import Foundation
import UIKit

class HeaderViewController: UIViewController {
    
    private var headerView = HeaderView()
    
    override func loadView() {
        super.loadView()
        setupHeaderView()
    }
    
    private func setupHeaderView() {
        headerView.delegate = self
        self.view = headerView
        
        headerView.configureUI()
    }
}

extension HeaderViewController: HeaderDelegate {
    func backButtonTapped() {
        
    }
}
