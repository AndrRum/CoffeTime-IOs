//
//  AllCafeServices.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 11.08.2023.
//

import CoreData

protocol AllCafeServiceProtocol: AnyObject {
    init(coreDataManager: CoreDataManager)
    func getAllCafe(url: String, completion: @escaping (NSSet?) -> Void) -> Void
    func saveResponse(cafeList: NSSet) -> Void
    func fetchCafeListFromCoreData(completion: @escaping (NSSet?) -> Void) -> Void
}

class AllCafeService: AllCafeServiceProtocol {
    
    let context: NSManagedObjectContext
    var coreDataManager: CoreDataManager
    let allCafeModel = AllCafeModel()
    
    let httpHelper = HttpRequestHelper()
    
    required init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.context = coreDataManager.mainContext
        self.coreDataManager = coreDataManager
    }
    
    func getAllCafe(url: String, completion: @escaping (NSSet?) -> Void) {
        httpHelper.sendPostRequest(url: url, jsonData: nil, withSid: false) { result, err in
            if let response = result {
                if let cafeList = response as? NSSet {
                    completion(cafeList)
                } else {
                    let cafeSet = NSMutableSet(array: allCafeMockDataArray)
                    completion(cafeSet)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func saveResponse(cafeList: NSSet) {
        do {
            context.performAndWait {
                let allCafeDataEntity = allCafeModel.mapToEntityInContext(context)
                allCafeDataEntity.cafelist = cafeList
                
                do {
                    try context.save()
                    print("Cafe List saved to Core Data.")
                } catch {
                    print("Error saving cafelist:", error)
                }
            }
        }
    }
    
    func fetchCafeListFromCoreData(completion: @escaping (NSSet?) -> Void) {
        let fetchRequest: NSFetchRequest<AllCafe> = AllCafe.fetchRequest()
        do {
            let allCafeDataArray = try context.fetch(fetchRequest)
            if let allCafeData = allCafeDataArray.first {
                if let list = allCafeData.cafelist {
                    completion(list)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        } catch {
            print("Error fetching AllCafeData from Core Data:", error)
            completion(nil)
        }
    }
}
