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
    private let bottomTextLabel = UILabel()
    private let bottomAddressLabel = UILabel()
    
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
            if cafeImages.lowercased().contains("http") {
                if let imageUrl = URL(string: cafeImages) {
                    URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.cafeImageView.image = image
                            }
                        }
                    }.resume()
                }
            } else {
                if let localImage = UIImage(named: cafeImages) {
                    self.cafeImageView.image = localImage
                }
            }
        } else {
            self.cafeImageView.image = UIImage(named: "Cafe10")
        }
        
        bottomTextLabel.text = cafe?.name
        bottomAddressLabel.text = cafe?.address
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
        setupBottomNameTextLabel()
        setupBottomAddressTextLabel()
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
    
    func setupBottomNameTextLabel() {
        addSubview(bottomTextLabel)
        
        bottomTextLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomTextLabel.font = UIFont(name: Fonts.logoFont, size: 28)
        bottomTextLabel.textColor = Colors.gray
        
        NSLayoutConstraint.activate([
            bottomTextLabel.leadingAnchor.constraint(equalTo: cafeImageView.leadingAnchor, constant: 16),
            bottomTextLabel.bottomAnchor.constraint(equalTo: cafeImageView.bottomAnchor, constant: -40)
        ])
    }
    
    func setupBottomAddressTextLabel() {
        addSubview(bottomAddressLabel)
        
        bottomAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomAddressLabel.font = .systemFont(ofSize: 18)
        bottomAddressLabel.textColor = Colors.gray2
        
        NSLayoutConstraint.activate([
            bottomAddressLabel.leadingAnchor.constraint(equalTo: cafeImageView.leadingAnchor, constant: 16),
            bottomAddressLabel.bottomAnchor.constraint(equalTo: cafeImageView.bottomAnchor, constant: -8)
        ])
    }
}

