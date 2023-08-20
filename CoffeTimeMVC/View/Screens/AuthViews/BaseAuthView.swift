//
//  BaseAuthView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 20.08.2023.
//

import Foundation
import UIKit

class BaseAuthView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func configureBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "LoginBkg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.insertSubview(backgroundImage, at: 0)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = backgroundImage.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, Colors.gradientColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        backgroundImage.layer.addSublayer(gradientLayer)
    }
    
    internal func configureInput(input: BaseInput, yValue: CGFloat) {
        input.translatesAutoresizingMaskIntoConstraints = false
        addSubview(input)
        
        NSLayoutConstraint.activate([
            input.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            input.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: yValue),
            input.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            input.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    internal func configureButton(button: UIButton, offset: CGFloat) {
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        
        let buttonBottomOffset = -screenHeight * offset
        let buttonWidth = screenWidth * 0.8
        
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: buttonWidth),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: buttonBottomOffset),
        ])
    }
}
