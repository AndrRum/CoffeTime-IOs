//
//  PasswordInput.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 16.08.2023.
//

import Foundation
import UIKit

class PasswordInput: UIView {
    
    var placeholder: String? {
        didSet {
               passwordTextField.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
            ])
        }
    };

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let bottomBorder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
}

extension PasswordInput {
    private func configureUI() {
        addSubview(passwordTextField)
        addSubview(bottomBorder)
        addSubview(eyeButton)
        
        passwordTextField.tintColor = .white
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordTextField.leftView = leftView
        passwordTextField.leftViewMode = .always

        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            passwordTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4),
            
            bottomBorder.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            bottomBorder.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1),
            
            eyeButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -10),
            eyeButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            eyeButton.widthAnchor.constraint(equalToConstant: 24),
            eyeButton.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        eyeButton.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func eyeButtonTapped() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        eyeButton.isSelected = !passwordTextField.isSecureTextEntry
    }
    
    func setFocus() {
        passwordTextField.becomeFirstResponder()
    }
}
