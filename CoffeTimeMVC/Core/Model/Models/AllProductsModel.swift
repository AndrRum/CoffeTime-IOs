//
//  AllProductsModel.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//

import Foundation
import CoreData

struct AllProductsModel {
    var productsList: NSSet?
}

extension AllProductsModel: EntityModelMapProtocol {
    
    typealias EntityType = AllProducts
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType {
        let allProducts: AllProducts = .init(context: context)
        allProducts.allproducts = productsList
        return allProducts
    }
    
    static func mapFromEntity(_ entity: AllProducts) -> Self {
        
        return .init()
    }
}
