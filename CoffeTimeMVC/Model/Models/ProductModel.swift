//
//  ProductModel.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//

import Foundation

import CoreData

struct ProductModel {
    
}

extension ProductModel: EntityModelMapProtocol {
    
    typealias EntityType = Product
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType {
        let product: Product = .init(context: context)
        
        return product
    }
    
    static func mapFromEntity(_ entity: Product) -> Self {
        
        return .init()
    }
}
