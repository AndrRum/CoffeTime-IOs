//
//  HeaderView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 04.09.2023.
//

import Foundation
import UIKit

protocol HeaderDelegate: AnyObject {
    func backButtonTapped() -> Void
}

class HeaderView: UIView {
    
    weak var delegate: HeaderDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "CoffeTime"
        label.font =  UIFont(name: Fonts.logoFont, size: 22)
        label.textColor = Colors.headerTitle
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderView {
    func configureUI() {
        self.backgroundColor = .gray
        
        configureLabel()
        
        _ = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButtonTapped))
    }
    
    private func configureLabel() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}

extension HeaderView: HeaderDelegate {
    
    @objc func backButtonTapped() {
        delegate?.backButtonTapped()
    }
}
