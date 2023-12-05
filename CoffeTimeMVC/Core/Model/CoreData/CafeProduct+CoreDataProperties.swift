//
//  CafeProduct+CoreDataProperties.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//
//

import Foundation
import CoreData


extension CafeProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CafeProduct> {
        return NSFetchRequest<CafeProduct>(entityName: "CafeProduct")
    }

    @NSManaged public var id: String?
    @NSManaged public var cofeId: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Int32
    @NSManaged public var favorite: Bool
    @NSManaged public var imagesPath: String?

}

extension CafeProduct : Identifiable {

}
