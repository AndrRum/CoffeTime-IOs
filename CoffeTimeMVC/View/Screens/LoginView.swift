//
//  LoginView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 11.08.2023.
//

import Foundation
import UIKit


protocol LoginViewDelegate: AnyObject {
  
}

class LoginView: UIView {
    
    private(set) var logoLabel = LogoLabel()
    private(set) var emailInput = EmailInput()
    private(set) var passwordInput = PasswordInput()
    private(set) var loginButton = BaseButton()
    private(set) var registrationButton = RegistrationButton()
    
    private let screenHeight = UIScreen.main.bounds.height
    private let screenWidth = UIScreen.main.bounds.width
    
    weak var delegate: LoginViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        opacityUIHandler(alphaValue: 0)
        configureLogo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView {
    
    func animConfigureUI() {
        let yOffset = screenHeight * 0.3

        let initialY = self.center.y - self.logoLabel.frame.size.height / 2 - yOffset
        self.logoLabel.center = CGPoint(x: self.center.x, y: self.center.y)

        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
            self.logoLabel.center = CGPoint(x: self.center.x, y: initialY)
            
            self.opacityUIHandler(alphaValue: 1)
            self.emailInput.setFocus()
        })
    }
    
    func configureBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "LoginBkg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.insertSubview(backgroundImage, at: 0)

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = backgroundImage.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        backgroundImage.layer.addSublayer(gradientLayer)
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
    
    func configureInput(input: UIView, yValue: CGFloat) {
        input.translatesAutoresizingMaskIntoConstraints = false
        addSubview(input)
        
        NSLayoutConstraint.activate([
            input.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            input.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: yValue),
            input.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            input.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func configureButton(button: UIButton, offset: CGFloat) {
        let buttonBottomOffset = -screenHeight * offset
        let buttonWidth = screenWidth * 0.8
        
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: buttonWidth),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: buttonBottomOffset),
        ])
    }
}
