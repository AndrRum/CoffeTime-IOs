//
//  CoreDataManager.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 08.08.2023.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoffeTimeDataList")
        container.loadPersistentStores {_, error
            in if let error = error {
                fatalError("Unable to persistent stores: \(error)")
            }
        }
        return container
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func saveContext() {
        saveContext(mainContext)
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        if context.parent == mainContext {
            saveDerivedContext(context)
            return
        }
        
        context.perform {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func saveDerivedContext(_ context: NSManagedObjectContext) {
        context.perform { [self] in
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Error: \(error.localizedDescription)")
            }
            
            saveContext(mainContext)
        }
    }
}
