//
//  NotificationCenterManager.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 29.08.2023.
//

import Foundation

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    private var observerTokens: [Any] = []
    
    func addObserver(observer: Any, selector: Selector, name: String) {
        
        print("observer: \(observer)")
        let token = NotificationCenter.default.addObserver(forName: NSNotification.Name(name), object: nil, queue: nil) { _ in
            (observer as AnyObject).perform(selector, with: nil)
        }
        observerTokens.append(token)
    }
    
    func postNotification(name: String) {
        NotificationCenter.default.post(name: NSNotification.Name(name), object: nil)
    }
    
    func removeObserver(observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
    
    func removeAllObservers() {
        for token in observerTokens {
            NotificationCenter.default.removeObserver(token)
        }
        observerTokens.removeAll()
    }
}
