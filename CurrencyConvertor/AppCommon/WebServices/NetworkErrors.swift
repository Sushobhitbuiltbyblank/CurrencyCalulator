//
//  NetworkErrors.swift
//  CurrencyConvertor
//
//  Created by Sushobhit.Jain on 23/12/20.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingFailed
    case informational
    case redirection
    case clientError
    case serverError
    case unknown
    
}
