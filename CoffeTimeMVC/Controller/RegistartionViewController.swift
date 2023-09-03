//
//  RegistartionViewController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 20.08.2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private var registrationView = RegistrationView()
    private var registartionService = UserDataService()
    private var errorViewController = ErrorViewController()
    
    override func loadView() {
        super.loadView()
        setupRegistrationView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationManager.shared.addObserver(observer: self, selector: #selector(handleHttpErrorStatus500), name: "HttpErrorStatus500")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationManager.shared.removeAllObservers()
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
               
        if isEmailValid && isPasswordValid && isRepeatPasswordValid {
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
        } else {
            print("Invalid email or password.")
        }
    }
}
