//
//  CafeListViewController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 03.09.2023.
//

import Foundation

import UIKit

class CafeListViewController: UIViewController {
    
    private var cafeListView = CafeListView()
    
    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.isHidden = true
        setupCafeListView()
    }
    
    
    func setupCafeListView() {
        cafeListView.delegate = self
        self.view = cafeListView
    }
    
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}


extension CafeListViewController: CafeListDelegate {
    func navigateBack() {
        goBack()
    }
}
