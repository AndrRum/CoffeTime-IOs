//
//  LoginInput.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 13.08.2023.
//

import UIKit

class EmailInput: BaseInput {
    
    private var validationStrategy: ValidationStrategy?

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
        ])
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "pencil"))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let bottomBorder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init() {
        super.init(frame: .zero, textField: emailTextField, bottomBorder: bottomBorder, iconView: loginIconImageView, errorLabel: errorLabel)
        
        validationStrategy = EmailValidationStrategy()
        configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
}

extension EmailInput {
    
    private func configureUI() {
        super.configureUI(trailingView: loginIconImageView)
    }
    
    func isValidEmail() -> Bool {
        super.isValidInput(validationStrategy: validationStrategy!)
    }
    
    func setFocus() {
        emailTextField.becomeFirstResponder()
    }
}
