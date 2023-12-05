//
//  ProductCollectionViewCell.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 27.11.2023.
//

import Foundation
import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {

    private(set) var productListItem: ProductListItem?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        productListItem = ProductListItem(name: "", price: "", imageUrl: "", isFavorite: false)
        productListItem?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(productListItem!)

        NSLayoutConstraint.activate([
            productListItem!.topAnchor.constraint(equalTo: contentView.topAnchor),
            productListItem!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productListItem!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productListItem!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(with product: ProductModel) {
        productListItem?.configureUI(name: product.productName ?? "unknown", price: "\(product.price)", imageUrl: product.imagesPath ?? "", isFavorite: product.favorite)
    }
}
