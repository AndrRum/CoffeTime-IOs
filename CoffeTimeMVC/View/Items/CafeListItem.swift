//
//  CafeListItem.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 19.09.2023.
//

import Foundation
import UIKit

protocol CafeListItemDelegate: AnyObject {
   
}

class CafeListItem: UITableViewCell {
   
    static let reuseId = "CafeListItem"
    
    private(set) var cafeItem: CafeModel!
    
    private var container = UIView(frame: .zero)
    private var iconView = UIImageView(frame: .zero)
    private var titleLabel = UILabel(frame: .zero)
    private var descriptionLabel = UILabel(frame: .zero)
    private var addressLabel = UILabel(frame: .zero)
    
    weak var delegate: CafeListItemDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setContainer()
        setIcon()
        setTitleLabel()
        setDescriptionLabel()
        setAddressLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setParametersForCafeItem(_ cafeItem: CafeModel) {
        self.cafeItem = cafeItem
        
        if (cafeItem.images?.count == 0) {
            if let gifURL = Bundle.main.url(forResource: "Ricardo", withExtension: "gif") {
                if let imageData = try? Data(contentsOf: gifURL) {
                    let animatedImage = UIImage.gifImageWithData(imageData)
                    iconView.image = animatedImage
                }
            }
        } else {
            iconView.image = UIImage(named: cafeItem.images ?? "")
        }
        
        titleLabel.text = cafeItem.name
        descriptionLabel.text = "Мы находимся:"
        addressLabel.text = cafeItem.address
    }
}

private extension CafeListItem {
    
    func setContainer() {
        contentView.backgroundColor = .white
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        contentView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
        ])
    }
    
    func setIcon() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        container.addSubview(iconView)
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            iconView.topAnchor.constraint(equalTo: container.topAnchor),
            iconView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 126),
        ])
    }

    
    func setTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = Colors.buttonGreen
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        container.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10)
        ])
    }
    
    func setDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .black
        descriptionLabel.font = .systemFont(ofSize: 16)
        container.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
        ])
    }
    
    func setAddressLabel() {
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.textColor = .black
        addressLabel.font = .systemFont(ofSize: 16)
        container.addSubview(addressLabel)
        
        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            addressLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5)
        ])
    }
}
