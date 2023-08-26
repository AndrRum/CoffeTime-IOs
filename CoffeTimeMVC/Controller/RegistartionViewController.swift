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
    private var registartionService = UserDataService()
    
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
    func regButtonTapped() {
        
        registrationView.setOrigPass()
        let isEmailValid = registrationView.isEmailValid()
        let isPasswordValid = registrationView.isPasswordValid()
        let isRepeatPasswordValid = registrationView.isRepeatPasswordValid()
        let email = registrationView.getEmailValue()
        let pass = registrationView.getPasswordValue()
               
        if isEmailValid && isPasswordValid && isRepeatPasswordValid {
            registartionService.authUser(url: ApiEndpoints.register, email: email, password: pass) { sessionId in
                if let sessionId = sessionId {
                    print("Session ID:", sessionId)
                    self.registartionService.saveResponse(sessionId: sessionId)
                    //navigate
                } else {
                    print("Authentication failed.")
                }
            }
        } else {
            print("Invalid email or password.")
        }
    }
}
