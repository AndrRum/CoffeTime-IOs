//
//  BackButton.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 05.09.2023.
//

import Foundation
import UIKit

protocol BackButtonDelegate: AnyObject {
    func navigateBack()
}

class BackButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false

        let image = UIImage(named: "BackButton")?
            .withTintColor(Colors.headerTitle, renderingMode: .alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 30.0))
        setImage(image, for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
