//
//  SetupInputViewHelper.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 17.08.2023.
//

import Foundation
import UIKit

class BaseInput: UIView {
    
    func configureUI(textField: UITextField, iconView: UIView, trailingView: UIView, bottomBorder: UIView) {
           addSubview(textField)
           addSubview(bottomBorder)
           addSubview(iconView)
           
           textField.tintColor = .white
           
           let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: 0))
           textField.leftView = leftView
           textField.leftViewMode = .always

           NSLayoutConstraint.activate([
               textField.topAnchor.constraint(equalTo: topAnchor, constant: 5),
               textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
               textField.trailingAnchor.constraint(equalTo: trailingView.leadingAnchor, constant: -10),
               textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4),
                       
               bottomBorder.topAnchor.constraint(equalTo: textField.bottomAnchor),
               bottomBorder.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
               bottomBorder.trailingAnchor.constraint(equalTo: trailingView.trailingAnchor),
               bottomBorder.heightAnchor.constraint(equalToConstant: 1),
               
               trailingView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
               trailingView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
               
               iconView.widthAnchor.constraint(equalToConstant: 24),
               iconView.heightAnchor.constraint(equalToConstant: 24),
           ])
       }
}
