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
    
    var cafe: CafeModel? {
        didSet {
            updateUI()
        }
    }
    
    private(set) var pageHeader = PageHeaderView()
    private let cafeImageView = UIImageView()
    
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
    
    private func updateUI() {
        if let cafeImages = cafe?.images, !cafeImages.isEmpty {
            cafeImageView.image = UIImage(named: cafeImages)
        } else {
            cafeImageView.image = UIImage(named: "Espresso")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gradientLayer = cafeImageView.layer.sublayers?.first as? CAGradientLayer
        gradientLayer?.frame = cafeImageView.bounds
    }
}

extension CafeView {
    
    func configureUI() {
        self.backgroundColor = .white
        
        setupHeaderView()
        setupCafeImageView()
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
    
    func setupCafeImageView() {
        cafeImageView.contentMode = .scaleAspectFit
        cafeImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cafeImageView)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = cafeImageView.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, Colors.gradientColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        cafeImageView.layer.addSublayer(gradientLayer)
        
        NSLayoutConstraint.activate([
            cafeImageView.topAnchor.constraint(equalTo: pageHeader.bottomAnchor),
            cafeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cafeImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cafeImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45)
        ])
    }

}

