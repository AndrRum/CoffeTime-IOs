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
        label.textAlignment = .center
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.textAlignment = .left
        return label
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
    
    func configureUI(name: String, price: String, imageUrl: String, isFavorite: Bool) {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        nameLabel.text = name
        priceLabel.text = price
        
        if let imageUrl = URL(string: imageUrl) {
            loadImage(from: imageUrl, into: productImageView)
        }
        
        if isFavorite {
            favoriteImageView.image = UIImage(systemName: "heart.fill")
            favoriteImageView.tintColor = .red
        } else {
            favoriteImageView.image = UIImage(systemName: "heart")
            favoriteImageView.tintColor = Colors.gray3
        }
        
        setupConstraints()
    }
    
    private func loadImage(from url: URL, into imageView: UIImageView) {
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
    }
    
    private func setupConstraints() {
        addSubview(productImageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(favoriteImageView)

        productImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            productImageView.widthAnchor.constraint(equalTo: widthAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 100),

            nameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),

            favoriteImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            favoriteImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 20),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
