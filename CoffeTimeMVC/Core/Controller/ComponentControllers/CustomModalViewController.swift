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
            loadImage(imageUrl: imageName)
        } else {
            modalView.cafeImageView.image = UIImage(named: "DefaultProductImage")
        }

        targetCafe = cafe
    }
    
    func loadImage(imageUrl: String?) {
        guard let imageUrlString = imageUrl else {
            return
        }
        
        
        if imageUrlString.lowercased().contains("http"), let imageUrl = URL(string: imageUrlString) {
            LoadImageManager.loadImage(from: imageUrl) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.modalView.cafeImageView.image = image
                    }
                case .failure(let error):
                    print("Error loading image: \(error)")
                    DispatchQueue.main.async {
                        self.modalView.cafeImageView.image = UIImage(named: "DefaultImage")
                    }
                }
            }
        } else {
            self.modalView.cafeImageView.image = UIImage(named: imageUrlString)
        }
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


