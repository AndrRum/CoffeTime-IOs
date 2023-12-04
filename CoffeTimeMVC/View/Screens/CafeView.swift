//
//  CafeView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 08.10.2023.
//

import Foundation
import UIKit

protocol CafeViewDelegate: AnyObject {
    func productSelected(_ product: ProductModel)
}

class CafeView: UIView {
    
    var cafe: CafeModel? {
        didSet {
            updateUI()
        }
    }
    
    var products: [ProductModel]? = [] {
        didSet {
            DispatchQueue.main.async {
                self.productsCollectionView.reloadData()
            }
        }
    }
    
    private var isHeartFilled: Bool = false {
        didSet {
            let imageName = isHeartFilled ? "heart.fill" : "heart"
            let imageColor = isHeartFilled ? Colors.red : Colors.gray
            let image = UIImage(systemName: imageName)
            heartButton.setImage(image, for: .normal)
            heartButton.tintColor = imageColor
        }
    }

    private(set) var pageHeader = PageHeaderView()
    private(set) var cafeImageView = UIImageView()
    private(set) var bottomTextLabel = UILabel()
    private(set) var bottomAddressLabel = UILabel()
    
    private let heartButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(systemName: "heart")
        button.setImage(image, for: .normal)
        button.tintColor = Colors.gray
        button.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private(set) var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
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
        guard let cafeImages = cafe?.images, !cafeImages.isEmpty else {
            cafeImageView.image = UIImage(named: "Cafe10")
            bottomTextLabel.text = cafe?.name
            bottomAddressLabel.text = cafe?.address
            return
        }
        
        loadImage(imageUrl: cafeImages)
        
        bottomTextLabel.text = cafe?.name
        bottomAddressLabel.text = cafe?.address?.components(separatedBy: ",").first?.trimmingCharacters(in: .whitespacesAndNewlines)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gradientLayer = cafeImageView.layer.sublayers?.first as? CAGradientLayer
        gradientLayer?.frame = cafeImageView.bounds
    }
}

private extension CafeView {
    func loadImage(imageUrl: String?) {
        guard let imageUrlString = imageUrl else {
            return
        }
        
        
        if imageUrlString.lowercased().contains("http"), let imageUrl = URL(string: imageUrlString) {
            LoadImageManager.loadImage(from: imageUrl) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.cafeImageView.image = image
                    }
                case .failure(let error):
                    print("Error loading image: \(error)")
                    DispatchQueue.main.async {
                        self.cafeImageView.image = UIImage(named: "DefaultImage")
                    }
                }
            }
        } else {
            self.cafeImageView.image = UIImage(named: imageUrlString)
        }
    }
}

extension CafeView {
    
    func configureUI() {
        self.backgroundColor = .white
        
        setupHeaderView()
        setupCafeImageView()
        setupBottomNameTextLabel()
        setupBottomAddressTextLabel()
        setupHeartButton()
        setupProductsCollectionView()
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
        gradientLayer.opacity = 0.6
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
    
    func setupHeartButton() {
        addSubview(heartButton)

        heartButton.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            heartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            heartButton.bottomAnchor.constraint(equalTo: cafeImageView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupProductsCollectionView() {
        productsCollectionView.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: "ProductsCollectionViewCell")
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        productsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(productsCollectionView)
        
        productsCollectionView.delegate = self
        
        NSLayoutConstraint.activate([
            productsCollectionView.topAnchor.constraint(equalTo: cafeImageView.bottomAnchor, constant: 8),
            productsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension CafeView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionViewCell", for: indexPath) as? ProductsCollectionViewCell else {
            return UICollectionViewCell()
        }

        if let product = products?[indexPath.item] {
            cell.configure(with: product)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 - 12, height: 223)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

extension CafeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let product = products?[indexPath.item] else {
            return
        }
        
        delegate?.productSelected(product)
    }
}


extension CafeView {
    @objc private func heartButtonTapped() {
        isHeartFilled.toggle()
    }
}

