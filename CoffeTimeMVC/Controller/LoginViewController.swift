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
    private let regViewController = RegistrationViewController()
       
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
    
    func navigateToRegistrationScreen() {
        self.navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        show(regViewController, sender: self)
    }
    
    func loginButtonTapped() {
        let isEmailValid = loginView.isEmailValid()
        let isPassValid = loginView.isPasswordValid()
        let email = loginView.getEmailValue()
        let pass = loginView.getPasswordValue()
               
        if isEmailValid && isPassValid {
           
        } else {
            
        }
    }
}
