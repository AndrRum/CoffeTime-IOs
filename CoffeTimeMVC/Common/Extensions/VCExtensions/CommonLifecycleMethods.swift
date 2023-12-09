//
//  LifecycleHandling.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 06.12.2023.
//

import UIKit

@objc protocol HttpErrorHandling {
    func handleHttpErrorStatus500()
}


protocol CommonLifecycleMethods: UIViewController, HttpErrorHandling {
    func commonViewWillAppear()
    func commonViewWillDisappear()
}

extension CommonLifecycleMethods where Self: UIViewController {

    func commonViewWillAppear() {
        NotificationManager.shared.addObserver(observer: self, selector: #selector(handleHttpErrorStatus500), name: "HttpErrorStatus500")
    }
    
    func commonViewWillDisappear() {
        NotificationManager.shared.removeAllObservers()
    }
}
