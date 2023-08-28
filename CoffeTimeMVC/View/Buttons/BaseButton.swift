//
//  ResumeButton.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 16.08.2023.
//

import Foundation
import UIKit

class BaseButton: UIButton {
    
    var title: String? {
        didSet {
            setTitle(title ?? "", for: .normal)
        }
    };
    
    private(set) var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.color = .white
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

private extension BaseButton {
    func commonInit() {
        setTitleColor(.white, for: .normal)
        backgroundColor = Colors.buttonGreen
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        layer.cornerRadius = 24
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(loader)
        setupLoaderConstraints()
        
        loader.isHidden = true
    }
    
    func setupLoaderConstraints() {
        NSLayoutConstraint.activate([
            loader.centerYAnchor.constraint(equalTo: centerYAnchor),
            loader.leadingAnchor.constraint(equalTo: titleLabel!.trailingAnchor, constant: 10)
        ])
    }
}

extension BaseButton {
    func startLoader() {
        DispatchQueue.main.async {
            self.isEnabled = false
            self.loader.isHidden = false
            self.loader.startAnimating()
        }
    }
           
    func stopLoader() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.loader.isHidden = true
            self.isEnabled = true
        }
    }
}
