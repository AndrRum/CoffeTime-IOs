//
//  AllCafe+CoreDataProperties.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//
//

import Foundation
import CoreData


extension AllCafe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AllCafe> {
        return NSFetchRequest<AllCafe>(entityName: "AllCafe")
    }

    @NSManaged public var cafelist: NSSet?

}

// MARK: Generated accessors for cafelist
extension AllCafe {

    @objc(addCafelistObject:)
    @NSManaged public func addToCafelist(_ value: Cafe)

    @objc(removeCafelistObject:)
    @NSManaged public func removeFromCafelist(_ value: Cafe)

    @objc(addCafelist:)
    @NSManaged public func addToCafelist(_ values: NSSet)

    @objc(removeCafelist:)
    @NSManaged public func removeFromCafelist(_ values: NSSet)

}

extension AllCafe : Identifiable {

}
