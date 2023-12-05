//
//  CafeCarouselView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 11.11.2023.
//

import Foundation
import UIKit

protocol CafeCarouselViewDelegate: AnyObject {
    func didSelectCafe(at index: Int)
}

class CafeCarouselView: UIView {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    weak var delegate: CafeCarouselViewDelegate?

    private var cafeNames: [String] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setupScrollView()
        setupStackView()
    }

    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }

    func configure(with cafe: [CafeModel]) {
        self.cafeNames = cafe.map{ $0.name ?? ""}
        reloadStackView()
    }

    private func reloadStackView() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for cafeName in cafeNames {
            let button = UIButton(type: .system)
            button.setTitle(cafeName, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 16
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.1
            button.layer.shadowRadius = 4
            
            if #available(iOS 15.0, *) {
                var newConfiguration = UIButton.Configuration.plain()
                newConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                button.configuration = newConfiguration
            } else {
                button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            }
            
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        if let index = stackView.arrangedSubviews.firstIndex(of: sender) {
            delegate?.didSelectCafe(at: index)
        }
    }
}
