//
//  ProductListItem.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 27.11.2023.
//

import Foundation
import UIKit

class ProductListItem: UIView {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = Colors.gray
        label.textAlignment = .left
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "кофейный напиток"
        label.textColor = Colors.gray2
        label.textAlignment = .center
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.buttonGreen
        label.font = UIFont(name: Fonts.logoFont, size: 24)
        label.textAlignment = .left
        return label
    }()
    
    private let cashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Cash")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Colors.buttonGreen
        return imageView
    }()
    
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    init(name: String, price: String, imageUrl: String, isFavorite: Bool) {
        super.init(frame: .zero)
        configureUI(name: name, price: price, imageUrl: imageUrl, isFavorite: isFavorite)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(name: String, price: String, imageUrl: String?, isFavorite: Bool) {
        backgroundColor = .white
        layer.borderWidth = 0
        
        nameLabel.text = name
        priceLabel.text = price
        
        loadImage(imageUrl: imageUrl)
        
        if isFavorite {
            favoriteImageView.image = UIImage(systemName: "heart.fill")
            favoriteImageView.tintColor = .red
        } else {
            favoriteImageView.image = UIImage(systemName: "heart")
            favoriteImageView.tintColor = Colors.gray3
        }
        
        setupConstraints()
    }
    
}

private extension ProductListItem {
    
    func loadImage(imageUrl: String?) {
        
        guard let imageUrlString = imageUrl else {
            return
        }
        
        if imageUrlString.lowercased().contains("http"), let imageUrl = URL(string: imageUrlString) {
            LoadImageManager.loadImage(from: imageUrl) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.productImageView.image = image
                    }
                case .failure(let error):
                    print("Error loading image: \(error)")
                    DispatchQueue.main.async {
                        self.productImageView.image = UIImage(named: "DefaultProductImage")
                    }
                }
            }
        } else {
            self.productImageView.image = UIImage(named: imageUrlString)
        }
        
    }
    
    private func setupConstraints() {
        addSubview(productImageView)
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(priceLabel)
        addSubview(cashImageView)
        addSubview(favoriteImageView)
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cashImageView.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        
        setupShadow()
        
        setupNameLabelConstraints()
        setupSubtitleLabelConstraints()
        setupProductImageViewConstraints()
        setupPriceLabelConstraints()
        setupCashImageViewConstraints()
        setupFavoriteImageViewConstraints()
    }
    
    private func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
    
    private func setupSubtitleLabelConstraints() {
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        ])
    }
    
    private func setupProductImageViewConstraints() {
        NSLayoutConstraint.activate([
            productImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            productImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 8),
            productImageView.widthAnchor.constraint(equalToConstant: 160),
            productImageView.heightAnchor.constraint(equalToConstant: 119),
        ])
    }
    
    private func setupPriceLabelConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        ])
    }
    
    private func setupCashImageViewConstraints() {
        NSLayoutConstraint.activate([
            cashImageView.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: -4),
            cashImageView.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: 24),
            cashImageView.widthAnchor.constraint(equalToConstant: 20),
            cashImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func setupFavoriteImageViewConstraints() {
        NSLayoutConstraint.activate([
            favoriteImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            favoriteImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 22),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
    
    private func setupShadow() {
        layoutIfNeeded()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
}
