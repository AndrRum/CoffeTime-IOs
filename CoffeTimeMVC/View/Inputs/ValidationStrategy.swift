//
//  ValidationStrategyProtocol.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 21.08.2023.
//

import Foundation


protocol ValidationStrategy {
    func isValid(text: String) -> Bool
}


struct EmailValidationStrategy: ValidationStrategy {
    func isValid(text: String) -> Bool {
        return !text.isEmpty && text.count <= 32 && text.contains("@") && text.contains(".")
    }
}

struct PasswordValidationStrategy: ValidationStrategy {
    func isValid(text: String) -> Bool {
        return text.count >= 6
    }
}

struct RepeatPasswordValidationStrategy: ValidationStrategy {
    let originalPassword: String
    
    func isValid(text: String) -> Bool {
        return text == originalPassword
    }
}

