//
//  CafeListView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 03.09.2023.
//

import Foundation
import UIKit

protocol CafeListDelegate: AnyObject {
    func navigateBack() -> Void
}

class CafeListView: UIView {
    
    private(set) var backButton = BackButton(frame: .zero)
    private(set) var pageLabel = PageLabel(title: "CoffeTime")
    
    weak var delegate: CafeListDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CafeListView {
    func configureUI() {
        self.backgroundColor = .white
        
        configurePageTitleLabel()
        configureBackButton()
    }
    
    func configurePageTitleLabel() {
        addSubview(pageLabel)
        
        NSLayoutConstraint.activate([
            pageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            pageLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureBackButton() {
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func backAction() {
        delegate?.navigateBack()
    }
}
