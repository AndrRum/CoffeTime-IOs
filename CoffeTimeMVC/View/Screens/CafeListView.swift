//
//  CafeListView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 03.09.2023.
//

import Foundation
import UIKit

protocol CafeListDelegate: AnyObject {
   
}

class CafeListView: UIView {
    
    private(set) var pageLabel = PageLabel(title: "CoffeTime")
    private var separatorView = UIView()
    
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
        configureSeparator()
    }
    
    func configurePageTitleLabel() {
        addSubview(pageLabel)
        pageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var topConstraint: NSLayoutConstraint

        if UIScreen.main.bounds.height >= 812 {
            topConstraint = pageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60)
        } else {
            topConstraint = pageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        }

        NSLayoutConstraint.activate([
            pageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            topConstraint,
            pageLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureSeparator() {
        separatorView.backgroundColor = Colors.separator
        addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
           
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: pageLabel.bottomAnchor, constant: 9),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
