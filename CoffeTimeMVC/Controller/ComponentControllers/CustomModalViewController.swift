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
            loadImage(with: imageName)
        } else {
            modalView.cafeImageView.image = UIImage(named: "DefaultProductImage")
        }

        targetCafe = cafe
    }

    func loadImage(with imageName: String) {
        if imageName.lowercased().contains("http"), let imageUrl = URL(string: imageName) {
            downloadImage(from: imageUrl)
        } else if let localImage = UIImage(named: imageName) {
            modalView.cafeImageView.image = localImage
        }
    }

    func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                return
            }

            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.modalView.cafeImageView.image = image
                }
            }
        }.resume()
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


