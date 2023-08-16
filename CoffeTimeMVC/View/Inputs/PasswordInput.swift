//
//  PasswordInput.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 16.08.2023.
//

import Foundation
import UIKit

class PasswordInput: BaseInput {
    
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
        super.configureUI(textField: passwordTextField, iconView: eyeButton, trailingView: eyeButton, bottomBorder: bottomBorder)
        
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
