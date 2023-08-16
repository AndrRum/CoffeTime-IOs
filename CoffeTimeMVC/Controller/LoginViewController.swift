//
//  LoginViewController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 08.08.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var loginView = LoginView()
    private var loginService: UserDataServiceProtocol!
       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginView.animConfigureUI()
    }

    
    override func loadView() {
        super.loadView()
        setupLoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginView.configureEmailInput()
        self.loginView.configurePassInput()
        self.loginView.configureLoginButton()
        self.loginView.configureRegistrationButton()
    }
    
    private func setupLoginView() {
        loginView.delegate = self
        self.view = loginView
        
        loginView.configureBackground()
    }
}


extension LoginViewController: LoginViewDelegate {
    
}
