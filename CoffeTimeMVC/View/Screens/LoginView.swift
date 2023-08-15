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
    
    weak var delegate: LoginViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLogo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension LoginView {
    
    func animConfigureUI() {
        let screenHeight = UIScreen.main.bounds.height
        let yOffset = screenHeight * 0.3

        let initialY = self.center.y - self.logoLabel.frame.size.height / 2 - yOffset
        self.logoLabel.center = CGPoint(x: self.center.x, y: self.center.y)
        self.logoLabel.alpha = 0
        self.emailInput.alpha = 0
        self.passwordInput.alpha = 0

        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
            self.logoLabel.alpha = 1
            self.logoLabel.center = CGPoint(x: self.center.x, y: initialY)
            
            self.emailInput.alpha = 1
            self.passwordInput.alpha = 1
            
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
    
    func configureInputs() {
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.placeholder = "Password"
            
        addSubview(emailInput)
        addSubview(passwordInput)
        
        NSLayoutConstraint.activate([
            emailInput.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailInput.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: -40),
            emailInput.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            emailInput.heightAnchor.constraint(equalToConstant: 40),
                
            passwordInput.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 30),
            passwordInput.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            passwordInput.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
