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
}

class DrawerMenuView: UIView {
    weak var delegate: DrawerMenuDelegate?
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoritesCafeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Любимые кафе", for: .normal)
        button.addTarget(self, action: #selector(favoritesCafeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoritesDrinksButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Любимые напитки", for: .normal)
        button.addTarget(self, action: #selector(favoritesDrinksButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = UIColor(white: 1.0, alpha: 0.9)
        
        addSubview(closeButton)
        addSubview(favoritesCafeButton)
        addSubview(favoritesDrinksButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        favoritesCafeButton.translatesAutoresizingMaskIntoConstraints = false
        favoritesDrinksButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            favoritesCafeButton.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16),
            favoritesCafeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            favoritesDrinksButton.topAnchor.constraint(equalTo: favoritesCafeButton.bottomAnchor, constant: 16),
            favoritesDrinksButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    @objc private func closeButtonTapped() {
        delegate?.drawerMenuDidClose()
    }
    
    @objc private func favoritesCafeButtonTapped() {
        // Handle favorites cafe button tap
    }
    
    @objc private func favoritesDrinksButtonTapped() {
        // Handle favorites drinks button tap
    }
}
