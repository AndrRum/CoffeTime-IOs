//
//  FavoriteView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 29.10.2023.
//

import Foundation
import UIKit

protocol FavoriteViewDelegate: AnyObject {
    func closeButtonTapped()
}

class FavoriteView: UIView {
    private var isCafeFavorites: Bool
    
    weak var delegate: FavoriteViewDelegate?

    init(isCafeFavorites: Bool) {
        self.isCafeFavorites = isCafeFavorites
        super.init(frame: .zero)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        backgroundColor = .white

        var titleLabel = ""
        if isCafeFavorites {
            titleLabel = "Empty Cafe Favorites"
        } else {
            titleLabel = "Empty Drink Favorites"
        }
        
        let closeButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            button.tintColor = .lightGray
            button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
            return button
        }()
        
        let emptyView = EmptyView(labelText: titleLabel)
        addSubview(emptyView)
        addSubview(closeButton)
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
    
    @objc private func closeButtonTapped() {
        delegate?.closeButtonTapped()
    }
}
