//
//  RegistartionViewController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 06.12.2023.
//

import Foundation
import UIKit

class RegistrationViewController: UIViewController, CommonLifecycleMethods {
    
    private var registrationView = RegistrationView()
    private var registartionService = UserDataService()
    private var errorViewController = ErrorViewController()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        commonViewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        commonViewWillDisappear()
    }
    
    private func setupRegistrationView() {
        registrationView.delegate = self
        self.view = registrationView
        
        registrationView.configureBackground()
    }
    
    @objc func handleHttpErrorStatus500() {
        showHttpErrorView(from: self, errorViewController: errorViewController)
        self.registrationView.registrationButton.stopLoader()
    }
}


extension RegistrationViewController: RegistrationViewDelegate {
    
    func regButtonTapped() {
        
        registrationView.setOrigPass()
        
        let isEmailValid = registrationView.isEmailValid()
        let isPasswordValid = registrationView.isPasswordValid()
        let isRepeatPasswordValid = registrationView.isRepeatPasswordValid()
        let email = registrationView.getEmailValue()
        let pass = registrationView.getPasswordValue()
        
        let validationCondition = isEmailValid && isPasswordValid && isRepeatPasswordValid
        
        if (!validationCondition) {
            return
        }
               
        registrationView.registrationButton.startLoader()
            
        registartionService.authUser(url: ApiEndpoints.register, email: email, password: pass) { sessionId in
            if let sessionId = sessionId {
                print("Session ID:", sessionId)
                self.registartionService.saveResponse(sessionId: sessionId)
                self.navigateToCafeListScreen()
            } else {
                print("Authentication failed.")
            }
            self.registrationView.registrationButton.stopLoader()
        }
    }
}
