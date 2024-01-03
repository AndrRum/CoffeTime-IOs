//
//  ProductViewController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 03.12.2023.
//

import Foundation
import UIKit

class ProductViewController: UIViewController, CommonLifecycleMethods {
    
    var product: ProductModel? {
        didSet {
            productView.product = product
        }
    }
    
    private let productView = ProductView()
    private let productService = ProductService()
    private var drawerMenuViewController = DrawerMenuViewController()
    
    override func loadView() {
        super.loadView()
        setupProductView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        commonViewWillAppear()
        getProductData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        commonViewWillDisappear()
        
        if drawerMenuViewController.parent != nil {
            drawerMenuDidClose(viewController: drawerMenuViewController)
        }
    }
    
    private func setupProductView() {
        productView.delegate = self
        productView.setHeaderViewDelegate(self)
        self.view = productView
    }
    
    func handleHttpErrorStatus500() {
        let productMock = productMockData
        DispatchQueue.main.async { [self] in
            productView.product = productMock
        }
    }
}

extension ProductViewController: ProductViewDelegate {
    func switchValueChanged(isOn: Bool) {
        
    }
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

extension ProductViewController {
    func getProductData() {
        productService.getProductData(url: ApiEndpoints.cafeProduct, productId: product?.id ?? "") { [weak self] productResponse in
            guard let self = self else { return }

            print("Product ====>: \(String(describing: productResponse))")

            DispatchQueue.main.async {
                if let product = productResponse {
                    self.product = product
                    print("Product ====>: \(product)")
                } else {
                    print("Failed to fetch product data")
                }
            }
        }
    }
}

