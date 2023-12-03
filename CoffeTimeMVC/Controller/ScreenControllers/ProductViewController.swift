//
//  ProductViewController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 03.12.2023.
//

import Foundation
import UIKit

class ProductViewController: UIViewController {
    
    var product: ProductModel? {
        didSet {
            productView.configure(with: product?.imagesPath)
        }
    }
    
    private let productView = ProductView()
    private var drawerMenuViewController = DrawerMenuViewController()
    
    override func loadView() {
        super.loadView()
        setupProductView()
    }
    
    private func setupProductView() {
        productView.delegate = self
        productView.setHeaderViewDelegate(self)
        self.view = productView
    }
}

extension ProductViewController: ProductViewDelegate {
    
}

extension ProductViewController: PageHeaderViewDelegate, DrawerMenuViewControllerDelegate {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func favoriteButtonTapped() {
        showDrawerMenu(viewController: drawerMenuViewController)
    }
    
    func drawerMenuDidClose() {
        drawerMenuDidClose(viewController: drawerMenuViewController)
    }
}


