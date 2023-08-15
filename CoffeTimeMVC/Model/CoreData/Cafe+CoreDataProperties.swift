//
//  Cafe+CoreDataProperties.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//
//

import Foundation
import CoreData


extension Cafe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cafe> {
        return NSFetchRequest<Cafe>(entityName: "Cafe")
    }

    @NSManaged public var address: String?
    @NSManaged public var coordinates: String?
    @NSManaged public var descr: String?
    @NSManaged public var id: String?
    @NSManaged public var images: String?
    @NSManaged public var name: String?

}

extension Cafe : Identifiable {

}
