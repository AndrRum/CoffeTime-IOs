//
//  ModalView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 02.10.2023.
//

import UIKit

protocol ModalViewDelegate: AnyObject {
    func goToButtonTapped()
}

class ModalView: UIView {
    
    weak var delegate: ModalViewDelegate?
    
    let cafeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let goToButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Перейти", for: .normal)
        button.tintColor = Colors.buttonGreen
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let backgroundTopView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backgroundBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() {
        setupContainer()
    }
    
    private func setupContainer() {
        self.addSubview(backgroundTopView)
        self.addSubview(backgroundBottomView)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundBottomView.layer.cornerRadius = 15
        backgroundBottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        var bottomMultiplier: CGFloat
                
        if UIScreen.main.bounds.height >= 812 {
            bottomMultiplier = 0.7
        } else {
            bottomMultiplier = 0.65
        }

        NSLayoutConstraint.activate([
            backgroundTopView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundTopView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundTopView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundTopView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: bottomMultiplier),
            
            backgroundBottomView.topAnchor.constraint(equalTo: backgroundTopView.bottomAnchor),
            backgroundBottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundBottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundBottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        backgroundBottomView.addSubview(cafeImageView)
        backgroundBottomView.addSubview(titleLabel)
        backgroundBottomView.addSubview(descriptionLabel)
        backgroundBottomView.addSubview(goToButton)
        
        setupImage()
        setupTitle()
        setupDescription()
        setupButton()
    }

    private func setupImage() {
        cafeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cafeImageView.leadingAnchor.constraint(equalTo: backgroundBottomView.leadingAnchor, constant: 20),
            cafeImageView.centerYAnchor.constraint(equalTo: backgroundBottomView.centerYAnchor),
            cafeImageView.heightAnchor.constraint(equalToConstant: 100),
            cafeImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: cafeImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: cafeImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundBottomView.trailingAnchor, constant: -20)
        ])
    }

    private func setupDescription() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: cafeImageView.trailingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: backgroundBottomView.trailingAnchor, constant: -20)
        ])
    }

    private func setupButton() {
        goToButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            goToButton.bottomAnchor.constraint(equalTo: backgroundBottomView.bottomAnchor, constant: -20),
            goToButton.centerXAnchor.constraint(equalTo: backgroundBottomView.centerXAnchor)
        ])

        goToButton.addTarget(self, action: #selector(goToButtonTapped), for: .touchUpInside)
    }

}

extension ModalView: ModalViewDelegate {
    @objc func goToButtonTapped() {
        delegate?.goToButtonTapped()
    }
}
