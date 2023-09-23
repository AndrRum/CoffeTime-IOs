//
//  CafeListView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 03.09.2023.
//

import Foundation
import UIKit

protocol CafeListDelegate: AnyObject {
   
}

class CafeListView: UIView {
    
    private(set) var loaderView = LoaderView()
    private(set) var pageLabel = PageLabel(title: "CoffeTime")
    private(set) var tableView = UITableView(frame: .zero, style: .grouped)
    private(set) var separatorView = UIView()
    private(set) var switchButton = UISegmentedControl(items: ["Map", "List"])
    private(set) var allCafe = [CafeModel]()
    
    private var isLeftSegmentMode = false
    weak var delegate: CafeListDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCafeList(_ cafeList: [CafeModel]) {
        allCafe = cafeList

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CafeListView {
    func configureUI() {
        self.backgroundColor = .white
        
        setupLoaderView()
        configurePageTitleLabel()
        configureSeparator()
        configureSwitchButton()
        configureTableView()
    }
    
    func setupLoaderView() {
        addSubview(loaderView)
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo:centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configurePageTitleLabel() {
        addSubview(pageLabel)
        pageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var topConstraint: NSLayoutConstraint

        if UIScreen.main.bounds.height >= 812 {
            topConstraint = pageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60)
        } else {
            topConstraint = pageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        }

        NSLayoutConstraint.activate([
            pageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            topConstraint,
            pageLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureSeparator() {
        separatorView.backgroundColor = Colors.separator
        addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
           
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: pageLabel.bottomAnchor, constant: 8),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configureSwitchButton() {
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        
        switchButton.backgroundColor = .white
        switchButton.layer.borderWidth = 1.0
        switchButton.layer.borderColor = UIColor.gray.cgColor
        switchButton.selectedSegmentTintColor = Colors.buttonGreen
        
        switchButton.setImage(UIImage(systemName: "mappin.and.ellipse"), forSegmentAt: 0)
        switchButton.imageForSegment(at: 0)?.accessibilityLabel = "Map"
        switchButton.setImage(UIImage(systemName: "list.dash"), forSegmentAt: 1)
        
        switchButton.selectedSegmentIndex = 1
        switchButton.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        addSubview(switchButton)
        
        NSLayoutConstraint.activate([
            switchButton.widthAnchor.constraint(equalToConstant: 130),
            switchButton.heightAnchor.constraint(equalToConstant: 32),
            switchButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            switchButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 16)
        ])
    }
    
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CafeListItem.self, forCellReuseIdentifier: CafeListItem.reuseId)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: switchButton.bottomAnchor, constant: 2),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension CafeListView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCafe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CafeListItem.reuseId, for: indexPath) as! CafeListItem
        cell.setParametersForCafeItem(allCafe[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension CafeListView: CafeListItemDelegate {
    
}

extension CafeListView {
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        
        if selectedIndex == 0 {
            isLeftSegmentMode = true
        } else {
            isLeftSegmentMode = false
        }
    }
    
    func startLoader() {
        loaderView.startLoader()
    }
    
    func stopLoader() {
        loaderView.stopLoader()
    }
}
