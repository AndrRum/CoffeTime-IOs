//
//  SwitchButtonView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 17.11.2023.
//

import UIKit

protocol SwitchButtonViewDelegate: AnyObject {
    func switchValueChanged(isOn: Bool)
}

class SwitchButtonView: UIView {

    private let heartButton = UIButton(type: .system)
    weak var delegate: SwitchButtonViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI() {
        addSubview(heartButton)

        heartButton.translatesAutoresizingMaskIntoConstraints = false
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)

        heartButton.tintColor = Colors.red
        heartButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

        NSLayoutConstraint.activate([
            heartButton.topAnchor.constraint(equalTo: topAnchor),
            heartButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            heartButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            heartButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        delegate?.switchValueChanged(isOn: !sender.isSelected)
        sender.isSelected.toggle()
    }
}

