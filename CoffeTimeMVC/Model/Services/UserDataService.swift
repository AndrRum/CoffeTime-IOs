//
//  UserDataServices.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 11.08.2023.
//

import CoreData

protocol UserDataServiceProtocol: AnyObject {
    init(coreDataManager: CoreDataManager)
    func registerUser(email: String, password: String) -> String
    func loginUser(email: String, password: String) -> String
    func saveResponse(sessionId: String, in userModel: UserDataModel)
}

class UserDataService: UserDataServiceProtocol {
    let context: NSManagedObjectContext
    var coreDataManager: CoreDataManager
    
    let httpHelper = HttpRequestHelper()
    
    required init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.context = coreDataManager.mainContext
        self.coreDataManager = coreDataManager
    }
    
    func registerUser(email: String, password: String) -> String {
        return ""
    }
    
    func loginUser(email: String, password: String) -> String {
        return ""
    }
    
    func saveResponse(sessionId: String, in userModel: UserDataModel) {
        do {
           
        }
    }
}

