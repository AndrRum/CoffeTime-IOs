//
//  DrawerMenuViewController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 28.10.2023.
//

import Foundation
import UIKit

protocol DrawerMenuViewControllerDelegate: AnyObject {
    func drawerMenuDidClose()
}

class DrawerMenuViewController: UIViewController {
    
    private let drawerView = DrawerMenuView()
    
    weak var delegate: DrawerMenuViewControllerDelegate?
    
    override func loadView() {
        drawerView.delegate = self
        self.view = drawerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawerView.setupUI()
    }
}

extension DrawerMenuViewController: DrawerMenuDelegate, DrawerMenuViewControllerDelegate {
    func drawerMenuDidClose() {
        delegate?.drawerMenuDidClose()
    }
}


