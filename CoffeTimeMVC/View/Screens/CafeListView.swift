//
//  CafeListView.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 03.09.2023.
//

import Foundation
import UIKit
import GoogleMaps

protocol CafeListDelegate: AnyObject {
    func handleMapTap(_ sender: UITapGestureRecognizer) -> Void
}

class CafeListView: UIView {
    
    private(set) var loaderView = LoaderView()
    private(set) var pageLabel = PageLabel(title: "CoffeTime")
    private(set) var tableView = UITableView(frame: .zero, style: .grouped)
    private(set) var separatorView = UIView()
    private(set) var switchButton = UISegmentedControl(items: ["Map", "List"])
    private(set) var mapView: GMSMapView!
    private(set) var allCafe = [CafeModel]()
    
    private var isLeftSegmentMode = false
    
    private let defaultLatitude: Double = -33.86
    private let defaultLongitude: Double = 151.20
    public var lastCameraCoordinates: CLLocationCoordinate2D?
    
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
        setupMapView()
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
        switchButton.layer.zPosition = 1
        
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
    
    func setupMapView() {
        
        mapView = GMSMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.settings.compassButton = false

        addSubview(mapView)

        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
       
        hideMapView()
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
    
    func startLoader() {
        loaderView.startLoader()
    }
    
    func stopLoader() {
        loaderView.stopLoader()
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
        return 126 + 20
    }
}

extension CafeListView: CafeListItemDelegate {
    func detailsButtonDidTap(for: CafeModel) {
        
    }
}

extension CafeListView {
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        
        if selectedIndex == 0 {
            isLeftSegmentMode = true
            tableView.isHidden = true
            showMapView()
        } else {
            isLeftSegmentMode = false
            tableView.isHidden = false
            hideMapView()
        }
    }
    
    private func showMapView() {
        mapView.isHidden = false
        mapView.isUserInteractionEnabled = true
        
        if mapView.gestureRecognizers?.isEmpty ?? true {
            setupTapRecognizer()
        }
        
        setupCamera(cafeList: allCafe)
    }
    
    private func hideMapView() {
        mapView.isHidden = true
        mapView.isUserInteractionEnabled = false
        
        if let gestures = mapView.gestureRecognizers {
            for gesture in gestures {
                mapView.removeGestureRecognizer(gesture)
            }
        }
    }
    
    func setupCamera(cafeList: [CafeModel]) {
        var camera: GMSCameraPosition
        
        if let firstCafe = cafeList.first,
           let coordinates = firstCafe.coordinates,
           let coordinatesComponents = coordinates.split(separator: ",").map(String.init) as? [String],
           coordinatesComponents.count == 2,
           let latitude = Double(coordinatesComponents[0].trimmingCharacters(in: .whitespaces)),
           let longitude = Double(coordinatesComponents[1].trimmingCharacters(in: .whitespaces)) {
            
            let newCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            if newCoordinates.latitude == lastCameraCoordinates?.latitude && newCoordinates.longitude == lastCameraCoordinates?.longitude {
                camera = mapView.camera
            } else {
                camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 11)
                lastCameraCoordinates = newCoordinates
            }
        } else {
            camera = GMSCameraPosition.camera(withLatitude: defaultLatitude, longitude: defaultLongitude, zoom: 11)
        
            lastCameraCoordinates = CLLocationCoordinate2D(latitude: defaultLatitude, longitude: defaultLongitude)
        }
        
        mapView.camera = camera
    }
    
    private func setupTapRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleMapTap(_ sender: UITapGestureRecognizer) {
        delegate?.handleMapTap(sender)
    }
}
