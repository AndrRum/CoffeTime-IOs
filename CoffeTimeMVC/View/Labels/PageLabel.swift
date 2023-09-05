//
//  PageLabel.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 05.09.2023.
//

import UIKit

class PageLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }

    required init(title: String) {
        super.init(frame: .zero)
        configure()
        setTitle(title)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        font = UIFont(name: Fonts.logoFont, size: 22)
        textColor = Colors.headerTitle
    }
    
    func setTitle(_ title: String) {
        text = title
    }
}

