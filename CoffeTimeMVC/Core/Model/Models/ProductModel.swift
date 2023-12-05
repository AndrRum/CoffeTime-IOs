//
//  ProductModel.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//

import Foundation
import CoreData

struct ProductModel {
    var cofeId: String?
    var id: String?
    var productName: String?
    var price: Int32
    var favorite: Bool
    var imagesPath: String?
    var attribute: NSSet?
}

extension ProductModel: EntityModelMapProtocol {
    
    typealias EntityType = Product
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType {
        let product: Product = .init(context: context)
        
        return product
    }
    
    static func mapFromEntity(_ entity: Product) -> Self {
        
        return .init(
            cofeId: entity.cofeId,
            id: entity.id, 
            price: entity.price,
            favorite: entity.favorite,
            imagesPath: entity.imagesPath,
            attribute: entity.attribute
        )
    }
}
