//
//  ErrorView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 26.08.2023.
//

import Foundation
import UIKit

protocol ErrorViewDelegate: AnyObject {
    func tapToTryAgain() -> Void
    func closeButtonTapped() -> Void
}

class ErrorView: UIView {
    
    weak var delegate: ErrorViewDelegate?
    
    private(set) var firstLabel = UILabel()
    private(set) var secondLabel = UILabel()
    private(set) var closeButton = UIButton()
    private(set) var scrollingLabel = UILabel()
    private(set) var imageView = UIImageView(image: UIImage(named: "ErrorImg"))
    
    private var isConfigured = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ErrorView {
    
    func configureUI() {
        self.backgroundColor = .black
                
        configureLabel()
        configureCloseButton()
    }
    
    func configureLabel() {
        
        firstLabel.text = "Directed by"
        firstLabel.textColor = .white
        firstLabel.textAlignment = .center
        firstLabel.font = UIFont.systemFont(ofSize: 24)
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(firstLabel)
                       
        firstLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        firstLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20).isActive = true

        secondLabel.text = "ROBERT B. WEIDE"
        secondLabel.textColor = .white
        secondLabel.textAlignment = .center
        secondLabel.font = UIFont.boldSystemFont(ofSize: 26)
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
           self.addSubview(secondLabel)
                       
        secondLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    func configureCloseButton() {
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal) //
        closeButton.tintColor = .white
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(closeButton)
                
        closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 64).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
                
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    func configureScrollingLabel() {
        scrollingLabel.text = "Status code: 500"
        scrollingLabel.textColor = .white
        scrollingLabel.font = UIFont.boldSystemFont(ofSize: 22)
        scrollingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollingLabel)
        
        let centerYBetweenSecondLabelAndTop = self.bounds.height / 4
        
        scrollingLabel.centerYAnchor.constraint(equalTo: self.topAnchor, constant: centerYBetweenSecondLabelAndTop).isActive = true
        scrollingLabel.leadingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        UIView.animate(withDuration: 6.0, delay: 0, options: [.repeat, .curveLinear], animations: {
            self.scrollingLabel.frame.origin.x = -self.scrollingLabel.bounds.width
            self.scrollingLabel.alpha = 1.0
        }, completion: { [weak self] _ in
            UIView.animate(withDuration: 0.5, animations: {
                self?.scrollingLabel.frame.origin.y += 20
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, animations: {
                    self?.scrollingLabel.alpha = 0.0
                }, completion: { _ in
                    self?.scrollingLabel.frame.origin.x = self?.bounds.width ?? 0
                    self?.scrollingLabel.frame.origin.y = centerYBetweenSecondLabelAndTop
                    self?.startScrolling()
                })
            })
        })
    }

    private func startScrolling() {
        UIView.animate(withDuration: 6.0, delay: 0, options: [.repeat, .curveLinear], animations: {
            self.scrollingLabel.frame.origin.x = -self.scrollingLabel.bounds.width
            self.scrollingLabel.alpha = 1.0
        }, completion: nil)
    }
    
    func configureImage() {
        guard !isConfigured else {
            return
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
           self.addSubview(imageView)

        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        imageView.alpha = 0.0

        UIView.animate(withDuration: 3.0, delay: 1.0, options: [], animations: {
            self.imageView.alpha = 1.0
        }, completion: nil)
        
        isConfigured = true
    }
    
    @objc func closeButtonTapped() {
        delegate?.closeButtonTapped()
    }
    
}
