//
//  AllCafeProductsModel.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//

import Foundation
import CoreData

struct AllCafeProductsModel {
    
}

extension AllCafeProductsModel: EntityModelMapProtocol {
    
    typealias EntityType = AllCafeProduct
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType {
        let allCafeProducts: AllCafeProduct = .init(context: context)
        
        return allCafeProducts
    }
    
    static func mapFromEntity(_ entity: AllCafeProduct) -> Self {
        
        return .init()
    }
}

