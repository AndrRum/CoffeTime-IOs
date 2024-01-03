//
//  ProductService.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 11.08.2023.
//

import Foundation
import CoreData

protocol ProductServiceProtocol: AnyObject {
    init(coreDataManager: CoreDataManager)
    
    func getProductData(url: String, productId: String, completion: @escaping (_ res: ProductModel?) -> Void)
}

class ProductService: ProductServiceProtocol {

    let context: NSManagedObjectContext
    var coreDataManager: CoreDataManager
    let productModel = ProductModel(attribute: nil)
    
    let httpHelper = HttpRequestHelper()
    
    required init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.context = coreDataManager.mainContext
        self.coreDataManager = coreDataManager
    }
    
    func getProductData(url: String, productId: String, completion: @escaping (_ res: ProductModel?) -> Void) {
        let json = ["productId": productId]
        
        httpHelper.sendPostRequest(url: url, jsonData: json, withSid: true) { result, err in
        
        
            if let jsonData = result as? Data {
                do {
                    print("JSON", result as Any)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
}
