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
    
    private(set) var headerView = HeaderView()
    
    weak var delegate: CafeListDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CafeListView {
    func setupUI() {
        
        self.backgroundColor = .white
        addSubview(headerView)
        
        headerView.configureUI()

        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            headerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
           }
        
        headerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 65).isActive = true
    }
}

extension CafeListView: CafeListDelegate {
   
}
