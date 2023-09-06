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
    private let switchButton = UISegmentedControl(items: ["Map", "List"])
    
    private var isLeftSegmentMode = false
    
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
        configureSwitchButton()
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
            separatorView.topAnchor.constraint(equalTo: pageLabel.bottomAnchor, constant: 8),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configureSwitchButton() {
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        
        switchButton.backgroundColor = .white
        switchButton.layer.borderWidth = 1.0
        switchButton.layer.borderColor = UIColor.gray.cgColor
        switchButton.selectedSegmentTintColor = Colors.buttonGreen
        
        switchButton.setImage(UIImage(systemName: "mappin.and.ellipse"), forSegmentAt: 0)
        switchButton.imageForSegment(at: 0)?.accessibilityLabel = "Map"
        switchButton.setImage(UIImage(systemName: "list.dash"), forSegmentAt: 1)
        
        switchButton.selectedSegmentIndex = 1
        switchButton.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        addSubview(switchButton)
        
        NSLayoutConstraint.activate([
            switchButton.widthAnchor.constraint(equalToConstant: 130),
            switchButton.heightAnchor.constraint(equalToConstant: 32),
            switchButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            switchButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 16)
        ])
    }
}

extension CafeListView {
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        
        if selectedIndex == 0 {
            isLeftSegmentMode = true
            
            if (switchButton.imageForSegment(at: 0)?.accessibilityLabel == "Map") {
                switchButton.setImage(UIImage(systemName: "heart"), forSegmentAt: 0)
            }
        } else {
            isLeftSegmentMode = false
        }
    }
}
