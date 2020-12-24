//
//  CurrencyLocalDataManager.swift
//  CurrencyConvertor
//
//  Created by Sushobhit.Jain on 23/12/20.
//

import Foundation
import UIKit
import CoreData

class CurrencyLocalDataManager {
    
    var persistentStoreCoordinator: NSPersistentStoreCoordinator? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            return appDelegate.persistentContainer.persistentStoreCoordinator
        }
        return nil
    }
    
    var managedObjectModel: NSManagedObjectModel? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.persistentContainer.managedObjectModel
        }
        return nil
    }
    
    var managedObjectContext: NSManagedObjectContext? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.persistentContainer.viewContext
        }
        return nil
    }
    
    func saveCurrency(name:String,value:Double) throws {
        guard let managedOC = self.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        if let newCurrency = NSEntityDescription.entity(forEntityName: "CurrencyEntity",
                                                     in: managedOC) {
            let movie = CurrencyEntity(entity: newCurrency, insertInto: managedOC)
            movie.name = name
            movie.exchangeValue = NSNumber(value: value)
            try managedOC.save()
        }
    }
    
    func retrieveCurrencyList() throws -> [CurrencyEntity]  {
        
        guard let managedOC = self.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        let request: NSFetchRequest<CurrencyEntity> = NSFetchRequest(entityName: String(describing: CurrencyEntity.self))
        
        return try managedOC.fetch(request)
    }
    
    
    
}
