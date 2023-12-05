//
//  EmptyView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 29.10.2023.
//

import Foundation
import UIKit

class EmptyView: UIView {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(white: 0.85, alpha: 1)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    init(labelText: String) {
        super.init(frame: .zero)
        configureUI(labelText: labelText)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI(labelText: String) {
        backgroundColor = .white

        imageView.image = UIImage(named: "Coffee")
        addSubview(imageView)

        label.text = labelText
        addSubview(label)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),

            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16)
        ])
    }
}

