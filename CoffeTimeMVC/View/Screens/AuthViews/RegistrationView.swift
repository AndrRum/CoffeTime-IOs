//
//  RegisterView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 20.08.2023.
//

import Foundation
import UIKit

protocol RegistrationViewDelegate: AnyObject {
    func regButtonTapped()
}

class RegistrationView: BaseAuthView {
    
    private(set) var logoLabel = LogoLabel()
    private(set) var emailInput = EmailInput()
    private(set) var passwordInput = PasswordInput()
    private(set) var repeatPassInput = PasswordInput()
    private(set) var registrationButton = BaseButton()
    
    weak var delegate: RegistrationViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLogo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegistrationView {
    
    func configureLogo() {
        let screenHeight = UIScreen.main.bounds.height
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.setTitle("CoffeTime", subtitle: "территория кофе", isTypedSubtitle: false)
        addSubview(logoLabel)

        let yOffset = screenHeight * 0.3
        let centerY = self.center.y - yOffset

        NSLayoutConstraint.activate([
            logoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: centerY),
        ])
    }
    
    func configureEmailInput() {
        super.configureInput(input: emailInput, yValue: -40)
    }
    
    func configurePassInput() {
        passwordInput.placeholder = "Password"
        super.configureInput(input: passwordInput, yValue: 30)
    }
    
    func configureRepeatPassInput() {
        repeatPassInput.placeholder = "Repeat password"
        super.configureInput(input: repeatPassInput, yValue: 100)
    }
    
    
    func configureRegistrationButton() {
        registrationButton.title = "Зарегистрироваться"
        super.configureButton(button: registrationButton, offset: 0.13)
        
        self.registrationButton.addTarget(self, action: #selector(regButtonTapped), for: .touchUpInside)
    }
}

extension RegistrationView {
    
}

extension RegistrationView {
    
    func isEmailValid() -> Bool {
        return emailInput.isValidEmail()
    }
    
    func isPasswordValid() -> Bool {
        return passwordInput.isValidPassword()
    }
    
    func isRepeatPasswordValid() -> Bool {
        return repeatPassInput.isValidRepeatPassword()
    }
    
    func getEmailValue() -> String {
        return emailInput.getEmailInputValue()
    }
    
    func getPasswordValue() -> String {
        return passwordInput.getPasswordInputValue()
    }
    
    func setOrigPass() {
        let orig = getPasswordValue()
        repeatPassInput.setOriginalPassword(orig)
    }
}

extension RegistrationView: RegistrationViewDelegate {

    @objc func regButtonTapped() {
        delegate?.regButtonTapped()
    }
}
