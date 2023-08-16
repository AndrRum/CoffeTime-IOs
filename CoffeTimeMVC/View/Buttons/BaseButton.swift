//
//  ResumeButton.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 16.08.2023.
//

import Foundation
import UIKit

class BaseButton: UIButton {
    
    var title: String? {
        didSet {
            setTitle(title ?? "", for: .normal)
        }
    };
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setTitleColor(.white, for: .normal)
        backgroundColor = Colors.buttonGreen
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        layer.cornerRadius = 24
        translatesAutoresizingMaskIntoConstraints = false
    }
}
