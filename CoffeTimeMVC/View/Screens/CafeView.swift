//
//  CafeView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 08.10.2023.
//

import Foundation
import UIKit

protocol CafeViewDelegate: AnyObject {
   
}

class CafeView: UIView {
    
    private(set) var pageHeader = PageHeaderView()
    
    weak var delegate: CafeViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHeaderViewDelegate(_ delegate: PageHeaderViewDelegate?) {
        pageHeader.delegate = delegate
    }
}

extension CafeView {
    
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

extension CafeView: CafeViewDelegate {
    
}
