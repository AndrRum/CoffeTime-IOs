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

    private let switchButton = UISwitch()
    weak var delegate: SwitchButtonViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI() {
        addSubview(switchButton)

        switchButton.translatesAutoresizingMaskIntoConstraints = false
        switchButton.tintColor = Colors.gray
        switchButton.onTintColor = Colors.buttonGreen


        switchButton.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)

        NSLayoutConstraint.activate([
            switchButton.topAnchor.constraint(equalTo: topAnchor),
            switchButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            switchButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            switchButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    @objc private func switchValueChanged(_ sender: UISwitch) {
        delegate?.switchValueChanged(isOn: sender.isOn)
    }
}
