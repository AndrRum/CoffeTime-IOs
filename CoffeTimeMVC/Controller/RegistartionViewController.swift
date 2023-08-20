//
//  RegistartionViewController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 20.08.2023.
//

import Foundation
import UIKit

class RegistrationViewController: UIViewController {
    
    private var registrationView = RegistrationView()
    private var registartionService: UserDataServiceProtocol!
    
    override func loadView() {
        super.loadView()
        setupRegistrationView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registrationView.configureEmailInput()
        self.registrationView.configurePassInput()
        self.registrationView.configureRepeatPassInput()
        self.registrationView.configureRegistrationButton()
    }
    
    private func setupRegistrationView() {
        registrationView.delegate = self
        self.view = registrationView
        
        registrationView.configureBackground()
    }
}


extension RegistrationViewController: RegistrationViewDelegate {
    
}
