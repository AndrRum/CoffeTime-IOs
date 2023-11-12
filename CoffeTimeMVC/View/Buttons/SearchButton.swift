//
//  SearchButton.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 10.11.2023.
//

import UIKit

class SearchButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        configureButton()
        configureIcon()
    }

    private func configureButton() {
        backgroundColor = .white
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        
        if #available(iOS 15.0, *) {
            var newConfiguration = UIButton.Configuration.plain()
            newConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            configuration = newConfiguration
        } else {
            contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }

    private func configureIcon() {
        let searchIcon = UIImage(systemName: "magnifyingglass")
        setImage(searchIcon, for: .normal)
        tintColor = .gray
        imageView?.contentMode = .center
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        imageView?.frame = bounds
    }
}
