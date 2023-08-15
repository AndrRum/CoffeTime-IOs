//
//  AllCafeProduct+CoreDataProperties.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//
//

import Foundation
import CoreData


extension AllCafeProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AllCafeProduct> {
        return NSFetchRequest<AllCafeProduct>(entityName: "AllCafeProduct")
    }

    @NSManaged public var allcafeproducts: NSSet?

}

// MARK: Generated accessors for allcafeproducts
extension AllCafeProduct {

    @objc(addAllcafeproductsObject:)
    @NSManaged public func addToAllcafeproducts(_ value: CafeProduct)

    @objc(removeAllcafeproductsObject:)
    @NSManaged public func removeFromAllcafeproducts(_ value: CafeProduct)

    @objc(addAllcafeproducts:)
    @NSManaged public func addToAllcafeproducts(_ values: NSSet)

    @objc(removeAllcafeproducts:)
    @NSManaged public func removeFromAllcafeproducts(_ values: NSSet)

}

extension AllCafeProduct : Identifiable {

}
