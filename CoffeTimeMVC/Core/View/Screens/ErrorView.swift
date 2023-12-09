//
//  ErrorView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 26.08.2023.
//

import Foundation
import UIKit

protocol ErrorViewDelegate: AnyObject {
    func tapToTryAgain() -> Void
    func closeButtonTapped() -> Void
}

class ErrorView: UIView {
    
    weak var delegate: ErrorViewDelegate?
    
    private(set) var firstLabel = UILabel()
    private(set) var secondLabel = UILabel()
    private(set) var closeButton = UIButton()
    private(set) var scrollingLabel = UILabel()
    private(set) var imageView = UIImageView(image: UIImage(named: "ErrorImg"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ErrorView {
    
    func configureUI() {
        self.backgroundColor = .black
                
        configureLabel()
        configureCloseButton()
    }
    
    func configureLabel() {
        firstLabel.text = "Directed by"
        firstLabel.textColor = .white
        firstLabel.textAlignment = .center
        firstLabel.font = UIFont.systemFont(ofSize: 24)
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(firstLabel)
                       
        firstLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        firstLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20).isActive = true

        secondLabel.text = "ROBERT B. WEIDE"
        secondLabel.textColor = .white
        secondLabel.textAlignment = .center
        secondLabel.font = UIFont.boldSystemFont(ofSize: 26)
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
           self.addSubview(secondLabel)
                       
        secondLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    func configureCloseButton() {
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .white
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(closeButton)
                
        closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 64).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
                
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    func configureScrollingLabel() {
        scrollingLabel.text = "Я нормально 👍👍👍"
        scrollingLabel.textColor = .white
        scrollingLabel.font = UIFont.boldSystemFont(ofSize: 22)
        scrollingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollingLabel)
        
        let centerYBetweenSecondLabelAndTop = self.bounds.height / 4
        
        scrollingLabel.centerYAnchor.constraint(equalTo: self.topAnchor, constant: centerYBetweenSecondLabelAndTop).isActive = true
        scrollingLabel.leadingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        configureScrollingAnimation(startScrollPosition: centerYBetweenSecondLabelAndTop)
    }
    
    func configureImage() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imageView)

        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        imageView.alpha = 0.0

        UIView.animate(withDuration: 3.0, delay: 1.0, options: [], animations: {
            self.imageView.alpha = 1.0
        }, completion: nil)
    }
}

extension ErrorView {
    
    func resetAnimations() {
        scrollingLabel.layer.removeAllAnimations()
        scrollingLabel.frame.origin.x = bounds.width
        scrollingLabel.alpha = 0.0

        imageView.layer.removeAllAnimations()
        imageView.alpha = 0.0
    }
    
    @objc func closeButtonTapped() {
        delegate?.closeButtonTapped()
    }
    
}

private extension ErrorView {
    
    func configureScrollingAnimation(startScrollPosition: CGFloat) {
        let animationDuration: TimeInterval = 6.0
        
        let moveLeftAnimation = CABasicAnimation(keyPath: "position.x")
        moveLeftAnimation.fromValue = bounds.width + scrollingLabel.bounds.width / 2
        moveLeftAnimation.toValue = -scrollingLabel.bounds.width / 2
        moveLeftAnimation.duration = animationDuration
        moveLeftAnimation.repeatCount = .infinity
        moveLeftAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOutAnimation.fromValue = 1.0
        fadeOutAnimation.toValue = 0.0
        fadeOutAnimation.duration = animationDuration
        fadeOutAnimation.repeatCount = .infinity
        fadeOutAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [moveLeftAnimation, fadeOutAnimation]
        animationGroup.duration = animationDuration
        animationGroup.repeatCount = .infinity
        animationGroup.timingFunction = CAMediaTimingFunction(name: .linear)
        
        scrollingLabel.layer.add(animationGroup, forKey: "scrollingAnimation")
        
        scrollingLabel.layer.position.x = -scrollingLabel.bounds.width / 2
        scrollingLabel.layer.opacity = 0.0
        scrollingLabel.layer.speed = 1.0
        scrollingLabel.frame.origin.y = startScrollPosition
    }
}
