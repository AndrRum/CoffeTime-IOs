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
    func fetchSid(completion: @escaping (String?) -> Void) 
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
        
        httpHelper.sendPostRequest(url: url, jsonData: params, withSid: false) { result, err in
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
    
    func fetchSid(completion: @escaping (String?) -> Void) {
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
        
        do {
            guard let userData = try context.fetch(fetchRequest).first else {
                completion(nil)
                return
            }
            
            if let sessionId = userData.sessionId {
                completion(sessionId)
            } else {
                completion(nil)
            }
            
        } catch {
            print("Error fetching UserData from Core Data:", error)
            completion(nil)
        }
    }
}

