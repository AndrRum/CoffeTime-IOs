//
//  CafeController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 08.10.2023.
//

import Foundation
import UIKit

class CafeViewController: UIViewController {
    
    var cafe: CafeModel? {
        didSet {
            cafeView.cafe = cafe
        }
    }
    
    private var cafeView = CafeView()
    private var cafeProductsService = AllCafeProductsService()
    
    private var drawerMenuViewController = DrawerMenuViewController()
    
    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.isHidden = true
        setupCafeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationManager.shared.addObserver(observer: self, selector: #selector(handleHttpErrorStatus500), name: "HttpErrorStatus500")
        
        getCafeProductsData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if drawerMenuViewController.parent != nil {
            drawerMenuDidClose(viewController: drawerMenuViewController)
        }
    }
    
    func setupCafeView() {
        cafeView.delegate = self
        cafeView.setHeaderViewDelegate(self)
        cafeView.cafe = cafe
        self.view = cafeView
    }
    
    @objc private func handleHttpErrorStatus500() {
        let cafeProductsMocks = cafeProductsMockDataArray
        cafeView.products = cafeProductsMocks
    }
}

private extension CafeViewController {
    
    func getCafeProductsData() {
        cafeProductsService.getAllCafeProducts(url: ApiEndpoints.allCafeProducts, cafeId: cafe?.id ?? "") { [weak self] allProductsList in
            guard let self = self else { return }
            
            if let productSet = allProductsList {
                let productArray = productSet.allObjects.compactMap { dict -> ProductModel? in
                    guard let productDict = dict as? [String: Any] else {
                        return nil
                    }
                    
                    return ProductModel(
                        cofeId: productDict["cofeId"] as? String,
                        id: productDict["id"] as? String,
                        productName: productDict["name"] as? String,
                        price: productDict["price"] as! Int32,
                        favorite: productDict["favorite"] as! Bool,
                        imagesPath: productDict["imagesPath"] as? String,
                        attribute: productDict["attribute"] as? NSSet
                    )
                }
                
                self.cafeView.products = productArray
            } else {
                print("Failed to fetch cafe data")
            }
        }
    }
}


extension CafeViewController: PageHeaderViewDelegate, DrawerMenuViewControllerDelegate {
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


extension CafeViewController: CafeViewDelegate {
    func productSelected(_ product: ProductModel) {
        let productViewController = ProductViewController()
        productViewController.product = product
        navigationController?.pushViewController(productViewController, animated: true)
    }
}

