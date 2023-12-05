//
//  ProductAttribute+CoreDataProperties.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//
//

import Foundation
import CoreData


extension ProductAttribute {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductAttribute> {
        return NSFetchRequest<ProductAttribute>(entityName: "ProductAttribute")
    }

    @NSManaged public var id: String?
    @NSManaged public var descr: String?
    @NSManaged public var iconType: String?

}

extension ProductAttribute : Identifiable {

}
