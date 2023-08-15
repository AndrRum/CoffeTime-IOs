//
//  Product+CoreDataProperties.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: String?
    @NSManaged public var productName: String?
    @NSManaged public var price: Int32
    @NSManaged public var cofeId: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var imagesPath: String?
    @NSManaged public var attribute: NSSet?

}

// MARK: Generated accessors for attribute
extension Product {

    @objc(addAttributeObject:)
    @NSManaged public func addToAttribute(_ value: ProductAttribute)

    @objc(removeAttributeObject:)
    @NSManaged public func removeFromAttribute(_ value: ProductAttribute)

    @objc(addAttribute:)
    @NSManaged public func addToAttribute(_ values: NSSet)

    @objc(removeAttribute:)
    @NSManaged public func removeFromAttribute(_ values: NSSet)

}

extension Product : Identifiable {

}
