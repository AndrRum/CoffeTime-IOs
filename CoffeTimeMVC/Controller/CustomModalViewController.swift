//
//  CustomModalViewController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 02.10.2023.
//

import UIKit

protocol ModalDelegate: AnyObject {
    func modalDidClose(data: CafeModel?)
}

class CustomModalViewController: UIViewController {
    
    private var modalView = ModalView()
    private var cafeListView = CafeListView()
    
    public var targetCafe: CafeModel? = nil
    
    weak var delegate: ModalDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModalView()
    }
    
    func configure(with cafe: CafeModel) {
        modalView.titleLabel.text = cafe.name
        modalView.descriptionLabel.text = cafe.descr
        if let imageName = cafe.images, !imageName.isEmpty {
            modalView.cafeImageView.image = UIImage(named: imageName)
        } else {
            modalView.cafeImageView.image = UIImage(named: "Espresso")
        }
        
        targetCafe = cafe
    }
    
    func setupModalView() {
        modalView.delegate = self
        modalView.setupUI()
        self.view = modalView
    }
}

extension CustomModalViewController: ModalViewDelegate {
    func goToCafeButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.modalDidClose(data: self.targetCafe)
        }
    }
}


