//
//  RegistrationButton.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 16.08.2023.
//

import Foundation
import UIKit

class RegistrationButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setTitle("Зарегистрироваться", for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .clear
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
