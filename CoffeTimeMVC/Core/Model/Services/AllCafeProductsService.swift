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
    
    func getAllCafeProducts(url: String, cafeId: String, completion: @escaping (NSSet?) -> Void)
}

class AllCafeProductsService: AllCafeProductsServiceProtocol {
    
    let context: NSManagedObjectContext
    var coreDataManager: CoreDataManager
    let cafeProductsModel = AllCafeProductsModel()
    
    let httpHelper = HttpRequestHelper()
    
    required init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.context = coreDataManager.mainContext
        self.coreDataManager = coreDataManager
    }
    
    func getAllCafeProducts(url: String, cafeId: String, completion: @escaping (NSSet?) -> Void) {
        let json = ["cafeId": cafeId]
        
        httpHelper.sendPostRequest(url: url, jsonData: json, withSid: true) { result, err in
        
            if let jsonString = result as? String {
                print("result: \(jsonString)")

                if let jsonData = jsonString.data(using: .utf8),
                   let jsonArray = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] {
                    
                    let cafeProductsSet = NSSet(array: jsonArray)
                    completion(cafeProductsSet)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
}
