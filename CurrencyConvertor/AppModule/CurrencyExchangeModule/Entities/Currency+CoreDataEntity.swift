//
//  Currency+CoreDataEntity.swift
//  CurrencyConvertor
//
//  Created by Sushobhit.Jain on 23/12/20.
//

import Foundation
import CoreData


public class CurrencyEntity: NSManagedObject {
    
}

extension CurrencyEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyEntity> {
        return NSFetchRequest<CurrencyEntity>(entityName: "CurrencyEntity");
    }

    @NSManaged public var name: String?
    @NSManaged public var exchangeValue: NSNumber?
}



