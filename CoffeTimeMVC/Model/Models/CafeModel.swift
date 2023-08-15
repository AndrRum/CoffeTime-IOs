//
//  CafeModel.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//

import Foundation
import CoreData

struct CafeModel {
    
}

extension CafeModel: EntityModelMapProtocol {
    
    typealias EntityType = Cafe
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType {
        let cafe: Cafe = .init(context: context)
        
        return cafe
    }
    
    static func mapFromEntity(_ entity: Cafe) -> Self {
        
        return .init()
    }
}
