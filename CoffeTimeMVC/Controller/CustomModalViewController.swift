//
//  CustomModalViewController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 02.10.2023.
//

import UIKit

class CustomModalViewController: UIViewController {
    
    private var modalView = ModalView()
    private var cafeListView = CafeListView()
    
    public var targetCafe: CafeModel? = nil
    
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
            modalView.cafeImageView.image = UIImage(named: "ErrorImg")
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
            NotificationManager.shared.postNotification(name: "ModalClosed")
            let cafeVC = CafeViewController()
            cafeVC.selectedCafe = self.targetCafe
        }
    }
}


