//
//  AllProducts+CoreDataProperties.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//
//

import Foundation
import CoreData


extension AllProducts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AllProducts> {
        return NSFetchRequest<AllProducts>(entityName: "AllProducts")
    }

    @NSManaged public var allproducts: NSSet?

}

// MARK: Generated accessors for allproducts
extension AllProducts {

    @objc(addAllproductsObject:)
    @NSManaged public func addToAllproducts(_ value: CafeProduct)

    @objc(removeAllproductsObject:)
    @NSManaged public func removeFromAllproducts(_ value: CafeProduct)

    @objc(addAllproducts:)
    @NSManaged public func addToAllproducts(_ values: NSSet)

    @objc(removeAllproducts:)
    @NSManaged public func removeFromAllproducts(_ values: NSSet)

}

extension AllProducts : Identifiable {

}
