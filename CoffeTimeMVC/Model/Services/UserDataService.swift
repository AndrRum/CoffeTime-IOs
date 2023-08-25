//
//  UserDataServices.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 11.08.2023.
//

import CoreData

protocol UserDataServiceProtocol: AnyObject {
    init(coreDataManager: CoreDataManager)
    func authUser(url: String, email: String, password: String) -> String
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
    
    func authUser(url: String, email: String, password: String) -> String {
        
        let params: [String: String] = [
            "email": email,
            "password": password
        ]
        
        httpHelper.sendPostRequest(url: url, jsonData: params, completion:{result, err  in
            if let error = err {
                    print("Error:", error)
                    return
                }
                
            if let response = result {
                print("Response:", response)
                    
                if let sessionId = response["sessionId"] as? String {
                     print("Sid \(sessionId)")
                }
            }
        })
        
        return ""
    }
    
    func saveResponse(sessionId: String, in userModel: UserDataModel) {
        do {
           
        }
    }
}

