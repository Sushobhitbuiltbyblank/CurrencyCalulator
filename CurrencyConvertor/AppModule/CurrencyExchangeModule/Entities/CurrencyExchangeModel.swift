//
//  CurrencyExchangeModel.swift
//  CurrencyConvertor
//
//  Created by Sushobhit.Jain on 23/12/20.
//

import Foundation
import UIKit

struct CurrencyModel  {
    let name:String
    var value:Double
}


extension CurrencyModel: Equatable {
    static func == (lhs: CurrencyModel, rhs: CurrencyModel) -> Bool {
        return lhs.name == rhs.name 
    }
}


// response coming from api
struct LiveCurrencylayerResponse: Codable {
    let success: Bool?
    let terms, privacy: String?
    let timestamp: Int?
    let source: String?
    let quotes: [String: Double]?
}
