//
//  AllCafeModel.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//

import Foundation
import CoreData

struct AllCafeModel {
    
}

extension AllCafeModel: EntityModelMapProtocol {
    
    typealias EntityType = AllCafe
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType {
        let allCafe: AllCafe = .init(context: context)
        
        return allCafe
    }
    
    static func mapFromEntity(_ entity: AllCafe) -> Self {
        
        return .init()
    }
}
