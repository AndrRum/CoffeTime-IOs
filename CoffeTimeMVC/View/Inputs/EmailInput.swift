//
//  LoginInput.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 13.08.2023.
//

import UIKit

class EmailInput: UIView {

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
}

extension EmailInput {
    private func configureUI() {
        addSubview(emailTextField)
        addSubview(bottomBorder)
        addSubview(loginIconImageView)
        
        emailTextField.tintColor = .white
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        emailTextField.leftView = leftView
        emailTextField.leftViewMode = .always

        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4),
            
            bottomBorder.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            bottomBorder.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1),
            
            loginIconImageView.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor, constant: -10),
            loginIconImageView.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor),
            loginIconImageView.widthAnchor.constraint(equalToConstant: 20),
            loginIconImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func setFocus() {
        emailTextField.becomeFirstResponder()
    }
}
