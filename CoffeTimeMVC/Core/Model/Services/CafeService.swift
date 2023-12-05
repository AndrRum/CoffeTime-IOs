//
//  CafeServices.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 11.08.2023.
//

import Foundation

import CoreData

protocol CafeServiceProtocol: AnyObject {
    init(coreDataManager: CoreDataManager)
}

class CafeService: CafeServiceProtocol {
    
    let context: NSManagedObjectContext
    var coreDataManager: CoreDataManager
    let cafeModel = CafeModel()
    
    let httpHelper = HttpRequestHelper()
    
    required init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.context = coreDataManager.mainContext
        self.coreDataManager = coreDataManager
    }
    
   
}
