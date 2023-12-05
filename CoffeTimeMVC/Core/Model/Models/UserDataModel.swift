//
//  UserDataModel.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//

import Foundation
import CoreData

struct UserDataModel {
    var sessionId: String?
}

extension UserDataModel: EntityModelMapProtocol {
    
    typealias EntityType = UserData
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType {
        let userData: UserData = .init(context: context)
        userData.sessionId = sessionId
        return userData
    }
    
    static func mapFromEntity(_ entity: UserData) -> Self {
        return .init(sessionId: entity.sessionId)
    }
}
