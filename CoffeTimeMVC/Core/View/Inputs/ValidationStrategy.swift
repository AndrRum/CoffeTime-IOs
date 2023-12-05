//
//  ValidationStrategyProtocol.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 21.08.2023.
//

import Foundation


protocol ValidationStrategy {
    func isValid(text: String) -> (isValid: Bool, errorDescription: String)
}

struct EmailValidationStrategy: ValidationStrategy {
    func isValid(text: String) -> (isValid: Bool, errorDescription: String) {
        if text.isEmpty {
            return (false, "Email не может быть пустым")
        } else if text.count > 32 {
            return (false, "Слишком длинный email")
        } else if !text.contains("@") || !text.contains(".") {
            return (false, "Некорректный формат email")
        } else {
            return (true, "")
        }
    }
}

struct PasswordValidationStrategy: ValidationStrategy {
    func isValid(text: String) -> (isValid: Bool, errorDescription: String) {
        if text.count < 6 {
            return (false, "Слишком короткий пароль")
        } else {
            return (true, "")
        }
    }
}

struct RepeatPasswordValidationStrategy: ValidationStrategy {
    let originalPassword: String
    
    func isValid(text: String) -> (isValid: Bool, errorDescription: String) {
        if text != originalPassword {
            return (false, "Пароли не совпадают")
        } else {
            return (true, "")
        }
    }
}

