//
//  AllCafeProductsService.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 11.08.2023.
//

import Foundation
import CoreData

protocol AllCafeProductsServiceProtocol: AnyObject {
    init(coreDataManager: CoreDataManager)
    
    func getAllCafeProducts(url: String, completion: @escaping (NSSet?) -> Void)
}

class AllCafeProductsService: AllCafeProductsServiceProtocol {
    
    let context: NSManagedObjectContext
    var coreDataManager: CoreDataManager
    let cafeModel = CafeModel()
    
    let httpHelper = HttpRequestHelper()
    
    required init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.context = coreDataManager.mainContext
        self.coreDataManager = coreDataManager
    }
    
    func getAllCafeProducts(url: String, completion: @escaping (NSSet?) -> Void) {
        httpHelper.sendPostRequest(url: url, jsonData: nil, withSid: true) { result, err in
            if let response = result {
                if let cafeProductsList = response as? NSSet {
                    completion(cafeProductsList)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
}
