//
//  DrawerMenuView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 28.10.2023.
//

import Foundation
import UIKit

protocol DrawerMenuDelegate: AnyObject {
    func drawerMenuDidClose()
    func favoritesCafeButtonTapped()
    func favoritesDrinkButtonTapped()
}

extension DrawerMenuDelegate {
    func drawerMenuDidClose() {
        
    }

    func favoritesCafeButtonTapped() {
        
    }

    func favoritesDrinkButtonTapped() {
        
    }
}

class DrawerMenuView: UIView {
    
    weak var delegate: DrawerMenuDelegate?
    private var panGesture: UIPanGestureRecognizer!
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoritesCafeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Любимые кафе", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(favoritesCafeButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    private lazy var favoritesDrinksButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Любимые напитки", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(favoritesDrinksButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Coffee"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupGesture()
    }
    
    
    func setupUI() {
        backgroundColor = UIColor(white: 0.8, alpha: 0.95)
        
        addSubview(closeButton)
        addSubview(favoritesCafeButton)
        addSubview(favoritesDrinksButton)
        addSubview(imageView)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        favoritesCafeButton.translatesAutoresizingMaskIntoConstraints = false
        favoritesDrinksButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            favoritesCafeButton.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16),
            favoritesCafeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            favoritesDrinksButton.topAnchor.constraint(equalTo: favoritesCafeButton.bottomAnchor, constant: 16),
            favoritesDrinksButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
    }
    
    func setupGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        let velocity = recognizer.velocity(in: self)

        switch recognizer.state {
        case .changed:
            let newTransform = CGAffineTransform(translationX: max(0, translation.x), y: 0)
            self.transform = newTransform

        case .ended:
            let closingThreshold: CGFloat = 100.0

            if translation.x > closingThreshold || velocity.x > closingThreshold {
                delegate?.drawerMenuDidClose()
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.transform = .identity
                }
            }

        default:
            break
        }
    }
    
    @objc private func closeButtonTapped() {
        delegate?.drawerMenuDidClose()
    }
    
    @objc private func favoritesCafeButtonTapped() {
        delegate?.favoritesCafeButtonTapped()
    }

    @objc private func favoritesDrinksButtonTapped() {
        delegate?.favoritesDrinkButtonTapped()
    }
}
