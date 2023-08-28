//
//  UserDataServices.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 11.08.2023.
//

import CoreData

protocol UserDataServiceProtocol: AnyObject {
    init(coreDataManager: CoreDataManager)
    func authUser(url: String, email: String, password: String,  completion: @escaping (String?) -> Void)
    func saveResponse(sessionId: String)
}

class UserDataService: UserDataServiceProtocol {
    
    let context: NSManagedObjectContext
    var coreDataManager: CoreDataManager
    let userModel = UserDataModel()
    
    let httpHelper = HttpRequestHelper()
    
    required init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.context = coreDataManager.mainContext
        self.coreDataManager = coreDataManager
    }
    
    func authUser(url: String, email: String, password: String, completion: @escaping (String?) -> Void) {
        
        let params: [String: String] = [
            "email": email,
            "password": password
        ]
        
        httpHelper.sendPostRequest(url: url, jsonData: params) { result, err in
            if let response = result {
                if let sessionId = response as? String {
                    completion(sessionId)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func saveResponse(sessionId: String) {
        do {
             context.performAndWait {
                let userDataEntity = userModel.mapToEntityInContext(context)
                userDataEntity.sessionId = sessionId
                
                do {
                    try context.save()
                    print("Session ID saved to Core Data.")
                } catch {
                    print("Error saving session ID:", error)
                }
            }
        }
    }
}

