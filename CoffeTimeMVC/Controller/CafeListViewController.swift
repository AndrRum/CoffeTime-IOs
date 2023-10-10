//
//  CafeListViewController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 03.09.2023.
//

import Foundation
import UIKit

class CafeListViewController: UIViewController {
    
    private var cafeListView = CafeListView()
    private var allCafeService = AllCafeService()
    private var customModalViewController = CustomModalViewController()
    private var cafeVC = CafeViewController()
    
    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.isHidden = true
        setupCafeListView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationManager.shared.addObserver(observer: self, selector: #selector(handleHttpErrorStatus500), name: "HttpErrorStatus500")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationManager.shared.addObserver(observer: self, selector: #selector(goToCafeScreen), name: "ModalClosed")
        
        getAllCafeData()
    }
    
    deinit {
        NotificationManager.shared.removeObserver(name: "ModalClosed")
    }

    func setupCafeListView() {
        cafeListView.delegate = self
        self.view = cafeListView
    }
    
    @objc func handleHttpErrorStatus500() {
        cafeListView.stopLoader()
        let cafeMocks = allCafeMockDataArray
        cafeListView.setCafeList(cafeMocks as [CafeModel])
    }
}

private extension CafeListViewController {
    
    func getAllCafeData() {
        cafeListView.startLoader()
        
        allCafeService.getAllCafe(url: ApiEndpoints.allCafe) { [weak self] cafeList in
            
            self?.cafeListView.loaderView.stopLoader()
            
            if let cafeSet = cafeList {
                let cafeArray = cafeSet.allObjects.compactMap { $0 as? CafeModel }
                                
                self?.cafeListView.setCafeList(cafeArray)
            } else {
                print("Failed to fetch cafe data")
            }
        }
    }
}


extension CafeListViewController: CafeListDelegate {
    
    func handleMapTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: cafeListView.mapView)
        let coordinate = cafeListView.mapView.projection.coordinate(for: location)
        
        cafeListView.lastCameraCoordinates?.latitude = coordinate.latitude
        cafeListView.lastCameraCoordinates?.longitude = coordinate.longitude
        print("coord \(coordinate)")
    }
    
    func showCustomModal(for cafe: CafeModel) {
        customModalViewController.configure(with: cafe)
        self.present(customModalViewController, animated: true, completion: nil)
    }
    
    func detailsButtonDidTap() {
        goToCafeScreen()

    }
    
    @objc func goToCafeScreen() {
        
        if let existingCafeVC = navigationController?.viewControllers.first(where: { $0 is CafeViewController }) as? CafeViewController {
            navigationController?.popToViewController(existingCafeVC, animated: true)
        } else {
            show(cafeVC, sender: self)
        }
    }
}
