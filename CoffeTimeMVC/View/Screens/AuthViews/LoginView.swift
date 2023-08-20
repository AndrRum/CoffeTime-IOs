//
//  LoginView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 11.08.2023.
//

import Foundation
import UIKit


protocol LoginViewDelegate: AnyObject {
    func navigateToRegistrationScreen()
}

class LoginView: BaseAuthView {
    
    private(set) var logoLabel = LogoLabel()
    private(set) var emailInput = EmailInput()
    private(set) var passwordInput = PasswordInput()
    private(set) var loginButton = BaseButton()
    private(set) var registrationButton = RegistrationButton()
    
    private let screenHeight = UIScreen.main.bounds.height
    private let screenWidth = UIScreen.main.bounds.width
    private var isConfigured = false
    
    weak var delegate: LoginViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        UINavigationBar.appearance().tintColor = .white
        
        opacityUIHandler(alphaValue: 0)
        configureLogo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView {
    
    func animConfigureUI() {
        
        guard !isConfigured else {
            return
        }
        
        let yOffset = screenHeight * 0.3

        let initialY = self.center.y - self.logoLabel.frame.size.height / 2 - yOffset
        self.logoLabel.center = CGPoint(x: self.center.x, y: self.center.y)

        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
            self.logoLabel.center = CGPoint(x: self.center.x, y: initialY)
            
            self.opacityUIHandler(alphaValue: 1)
            self.emailInput.setFocus()
        })
        
        isConfigured = true
    }
    
    func configureLogo() {
        addSubview(logoLabel)
        logoLabel.setTitle("CoffeTime", subtitle: "территория кофе")
    }
    
    func configureEmailInput() {
        configureInput(input: emailInput, yValue: -40)
    }
    
    func configurePassInput() {
        passwordInput.placeholder = "Password"
        configureInput(input: passwordInput, yValue: 30)
    }
    
    
    func configureLoginButton() {
        loginButton.title = "Далее"
        configureButton(button: loginButton, offset: 0.20)
    }
    
    func configureRegistrationButton() {
        configureButton(button: registrationButton, offset: 0.13)
        registrationButton.addTarget(self, action: #selector(navigateToRegistrationScreen), for: .touchUpInside)
    }
}

private extension LoginView {
    
    func opacityUIHandler(alphaValue: CGFloat) {
        self.logoLabel.alpha = alphaValue
        self.emailInput.alpha = alphaValue
        self.passwordInput.alpha = alphaValue
        self.loginButton.alpha = alphaValue
        self.registrationButton.alpha = alphaValue
    }
}

extension LoginView: LoginViewDelegate {
    @objc func navigateToRegistrationScreen() {
        delegate?.navigateToRegistrationScreen()
    }
}
