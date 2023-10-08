//
//  FavoritesView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 08.10.2023.
//

import Foundation
import UIKit

protocol FavoritesViewDelegate: AnyObject {
   
}

class FavoritesView: UIView {
    
    private(set) var pageHeader = PageHeaderView()
    
    weak var delegate: FavoritesViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoritesView {
    
    func configureUI() {
        self.backgroundColor = .white
        
        setupHeaderView()
    }
    
    func setupHeaderView() {
        addSubview(pageHeader)
        pageHeader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageHeader.topAnchor.constraint(equalTo: topAnchor),
            pageHeader.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageHeader.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageHeader.bottomAnchor.constraint(equalTo: pageHeader.bottomAnchor)
        ])
        
        pageHeader.configureUI(showBackButton: true)
    }
}

extension FavoritesView: FavoritesViewDelegate {
    
}
