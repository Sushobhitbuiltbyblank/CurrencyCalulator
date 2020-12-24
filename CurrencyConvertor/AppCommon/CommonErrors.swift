//
//  CommonErrors.swift
//  CurrencyConvertor
//
//  Created by Sushobhit.Jain on 23/12/20.
//

import Foundation

struct CommonError {
    static let listEmply = "we get an empty list in response"
    static let coreDataWhileGet = "core data throwing error while retrive values"
    static let coreDataWhileSave = "core data throwing error while saving values"
}
enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotSaveObject
    case objectNotFound
}
