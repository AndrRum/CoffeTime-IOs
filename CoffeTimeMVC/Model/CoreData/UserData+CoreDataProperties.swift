//
//  UserData+CoreDataProperties.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var sessionId: String?

}

extension UserData : Identifiable {

}
