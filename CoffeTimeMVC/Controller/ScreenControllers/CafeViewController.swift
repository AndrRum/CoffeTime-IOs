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
    
    private var drawerMenuViewController: DrawerMenuViewController?
    
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
        
        if let drawerMenuViewController = drawerMenuViewController,
           drawerMenuViewController.parent != nil {
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
        
    }
}

private extension CafeViewController {
    
    func getCafeProductsData() {
        //cafeListView.startLoader()
        
        cafeProductsService.getAllCafeProducts(url: ApiEndpoints.allCafeProducts, cafeId: cafe?.id ?? "") {
            allProductsList in
            
            print("result: \(String(describing: allProductsList))")
        }
    }
}

extension CafeViewController: PageHeaderViewDelegate {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func favoriteButtonTapped() {
        showDrawerMenu()
    }
}

extension CafeViewController: CafeViewDelegate {
    
}

extension CafeViewController: DrawerMenuDelegate, DrawerMenuViewControllerDelegate {
    
    private func showDrawerMenu() {
        drawerMenuViewController = DrawerMenuViewController()
        drawerMenuViewController?.delegate = self
        
        addChildViewController(drawerMenuViewController!)
        view.addSubview(drawerMenuViewController!.view)
        
        let width = view.frame.width / 1.5
        let height = view.frame.height
        
        let initialFrame = CGRect(x: view.frame.width, y: 0, width: width, height: height)
        let finalFrame = CGRect(x: view.frame.width - width, y: 0, width: width, height: height)
        
        showDrawerMenu(viewController: drawerMenuViewController!, initialFrame: initialFrame, finalFrame: finalFrame)
    }
    
    func drawerMenuDidClose() {
        drawerMenuDidClose(viewController: drawerMenuViewController!)
    }
}

