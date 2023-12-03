//
//  ProductView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 03.12.2023.
//

import Foundation
import UIKit

protocol ProductViewDelegate: AnyObject {
   
}

class ProductView: UIView {
    
    private(set) var pageHeader = PageHeaderView()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    weak var delegate: ProductViewDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHeaderViewDelegate(_ delegate: PageHeaderViewDelegate?) {
        pageHeader.delegate = delegate
    }
    
}

extension ProductView {
    func configureUI() {
        backgroundColor = .white
        
        setupHeaderView()
        setupImg()
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
    
    func setupImg() {
        addSubview(productImageView)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(with imageUrl: String?) {
        loadImage(imageUrl: imageUrl)
    }
    
    private func loadImage(imageUrl: String?) {
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
                        self.productImageView.image = UIImage(named: "DefaultImage")
                    }
                }
            }
        } else {
            self.productImageView.image = UIImage(named: imageUrlString)
        }
    }
}
