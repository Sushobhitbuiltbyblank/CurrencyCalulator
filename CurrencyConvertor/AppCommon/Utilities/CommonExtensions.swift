//
//  CommonExtensions.swift
//  CurrencyConvertor
//
//  Created by Sushobhit.Jain on 24/12/20.
//

import Foundation

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
