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
        setupCafeListView()
    }
    
    override func viewDidLoad() {
        cafeListView.setupUI()
    }
    
    func setupCafeListView() {
        cafeListView.delegate = self
        self.view = cafeListView
    }
}


extension CafeListViewController: CafeListDelegate {
    
}
