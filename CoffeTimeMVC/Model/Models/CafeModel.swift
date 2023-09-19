//
//  CafeModel.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 09.08.2023.
//

import Foundation
import CoreData

struct CafeModel {
    var address: String?
    var coordinates: String?
    var descr: String?
    var id: String?
    var images: String?
    var name: String?
}

extension CafeModel: EntityModelMapProtocol {
    
    typealias EntityType = Cafe
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType {
        let cafe: Cafe = .init(context: context)
        cafe.address = address
        cafe.coordinates = coordinates
        cafe.descr = descr
        cafe.id = id
        cafe.images = images
        cafe.name = name
        return cafe
    }
    
    static func mapFromEntity(_ entity: Cafe) -> Self {
        
        return .init(address: entity.address, coordinates: entity.coordinates, descr: entity.descr, id: entity.id, images: entity.images, name: entity.name)
    }
}
