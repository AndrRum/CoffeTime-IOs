//
//  CafeListItem.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 19.09.2023.
//

import Foundation
import UIKit

protocol CafeListItemDelegate: AnyObject {
    func detailsButtonDidTap(for: CafeModel) -> Void
}

class CafeListItem: UITableViewCell {
   
    static let reuseId = "CafeListItem"
    
    private(set) var cafeItem: CafeModel!
    
    private var container = UIView(frame: .zero)
    private var iconView = UIImageView(frame: .zero)
    private var titleLabel = UILabel(frame: .zero)
    private var descriptionLabel = UILabel(frame: .zero)
    private var addressLabel = UILabel(frame: .zero)
    private var detailsButton = UIButton(type: .custom)
    
    weak var delegate: CafeListItemDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setContainer()
        setIcon()
        setTitleLabel()
        setDescriptionLabel()
        setAddressLabel()
        setDetailBtn()
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
        descriptionLabel.text = "мы находимся:"
        addressLabel.text = cafeItem.address
    }
}

private extension CafeListItem {
    
    func setContainer() {
        contentView.backgroundColor = .white
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        container.layer.shadowColor = UIColor.lightGray.cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowOpacity = 0.3
        container.layer.shadowRadius = 4
        contentView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor)
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
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 14),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 14)
        ])
    }
    
    func setDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .gray
        descriptionLabel.font = .systemFont(ofSize: 14)
        container.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 14),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14)
        ])
    }
    
    func setAddressLabel() {
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.textColor = .gray
        addressLabel.font = .systemFont(ofSize: 16)
        container.addSubview(addressLabel)
        
        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 14),
            addressLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5)
        ])
    }
    
    func setDetailBtn() {
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        detailsButton.setTitle("подробнее", for: .normal)
        detailsButton.setTitleColor(.lightGray, for: .normal)
        detailsButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
          
        let arrowImage = UIImage(systemName: "chevron.right")
        let arrowImageView = UIImageView(image: arrowImage)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.tintColor = .lightGray
            
        detailsButton.addSubview(arrowImageView)
        container.addSubview(detailsButton)
            
        NSLayoutConstraint.activate([
            detailsButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30),
            detailsButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
                
            arrowImageView.leadingAnchor.constraint(equalTo: detailsButton.trailingAnchor, constant: 5),
            arrowImageView.centerYAnchor.constraint(equalTo: detailsButton.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 12),
            arrowImageView.heightAnchor.constraint(equalToConstant: 12)
        ])
        detailsButton.addTarget(self, action: #selector(detailsButtonTapped), for: .touchUpInside)
    }
    
    @objc func detailsButtonTapped() {
        delegate?.detailsButtonDidTap(for: cafeItem)
    }
}
