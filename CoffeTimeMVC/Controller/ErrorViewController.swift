//
//  ErrorViewController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 26.08.2023.
//

import Foundation
import UIKit

class ErrorViewController: UIViewController {
    
    private var errorView = ErrorView()
    
    override func loadView() {
        super.loadView()
        setupErrView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        errorView.configureScrollingLabel()
        errorView.configureImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    private func setupErrView() {
        errorView.delegate = self
        errorView.configureUI()
        self.view = errorView
    }
}


extension ErrorViewController: ErrorViewDelegate {
    
    func tapToTryAgain() {
        
    }
    
    func closeButtonTapped() {
        self.dismiss(animated: true)
    }
}
