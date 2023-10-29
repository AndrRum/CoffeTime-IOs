//
//  PageHeaderView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 08.10.2023.
//

import Foundation
import UIKit

protocol PageHeaderViewDelegate: AnyObject {
    func backButtonTapped()
    func favoriteButtonTapped()
}

class PageHeaderView: UIView {
    private(set) var pageLabel = PageLabel(title: "CoffeTime")
    private(set) var separatorView = UIView()
    private(set) var backButton: BackButton?
    private(set) var favoritesButton: UIButton?

    weak var delegate: PageHeaderViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI(showBackButton: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI(showBackButton: Bool) {
        backgroundColor = .white

        if showBackButton {
            configureBackButton()
        }

        configurePageTitleLabel()
        configureSeparator()
        configureFavoritesButton()
    }

    func configureBackButton() {
        backButton = BackButton()
        guard let backButton = backButton else { return }

        addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false

        let topConstraint = calculateTopConstraint(for: backButton, constantIphoneV: 20, constantIphoneX: 60)

        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            topConstraint,
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    func configurePageTitleLabel() {
        addSubview(pageLabel)
        pageLabel.translatesAutoresizingMaskIntoConstraints = false

        let topConstraint = calculateTopConstraint(for: pageLabel, constantIphoneV: 20, constantIphoneX: 60)

        NSLayoutConstraint.activate([
            pageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            topConstraint,
            pageLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func configureSeparator() {
        separatorView.backgroundColor = Colors.separator
        addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: pageLabel.bottomAnchor, constant: 8),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configureFavoritesButton() {
        favoritesButton = UIButton(type: .custom)
        guard let favoritesButton = favoritesButton else { return }

        favoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favoritesButton.tintColor = Colors.buttonGreen

        addSubview(favoritesButton)
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false

        let topConstraint = calculateTopConstraint(for: favoritesButton, constantIphoneV: 20, constantIphoneX: 60)

        NSLayoutConstraint.activate([
            favoritesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            topConstraint,
            favoritesButton.widthAnchor.constraint(equalToConstant: 40),
            favoritesButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        favoritesButton.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped() {
        delegate?.backButtonTapped()
    }

    @objc func favoritesButtonTapped() {
        delegate?.favoriteButtonTapped()
    }

    func calculateTopConstraint(for view: UIView, constantIphoneV: CGFloat, constantIphoneX: CGFloat) -> NSLayoutConstraint {
        let topConstraint: NSLayoutConstraint

        if UIScreen.main.bounds.height >= 812 {
            topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: view.superview, attribute: .top, multiplier: 1, constant: constantIphoneX)
        } else {
            topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: view.superview, attribute: .top, multiplier: 1, constant: constantIphoneV)
        }

        return topConstraint
    }
}
