//
//  CafeProductModel.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//

import Foundation

import CoreData

struct CafeProductModel {
    
}

extension CafeProductModel: EntityModelMapProtocol {
    
    typealias EntityType = CafeProduct
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType {
        let cafeProduct: CafeProduct = .init(context: context)
        
        return cafeProduct
    }
    
    static func mapFromEntity(_ entity: CafeProduct) -> Self {
        
        return .init()
    }
}
