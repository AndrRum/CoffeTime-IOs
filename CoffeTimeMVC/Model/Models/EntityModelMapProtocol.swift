//
//  EntityModelMapProtocol.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//

import CoreData

protocol EntityModelMapProtocol {
    
    associatedtype EntityType: NSManagedObject
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType
    static func mapFromEntity(_ entity: EntityType) -> Self
}
