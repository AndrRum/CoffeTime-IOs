//
//  LoaderView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 16.09.2023.
//

import Foundation
import UIKit

class LoaderView: UIView {
    private(set) var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.color = .gray
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        addSubview(loader)
        loader.isHidden = true
    }
}

extension LoaderView {
    func startLoader() {
        DispatchQueue.main.async {
            self.loader.isHidden = false
            self.loader.startAnimating()
        }
    }
           
    func stopLoader() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.loader.isHidden = true
        }
    }
}
