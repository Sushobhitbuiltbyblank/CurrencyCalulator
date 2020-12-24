//
//  HttpClient.swift
//  CurrencyConvertor
//
//  Created by Sushobhit.Jain on 23/12/20.
//

import Foundation
typealias completionBlock = (Data?, Bool, String?,Int) -> (Void)

enum HTTPMethod:String {
    case GET
    case POST
    case DELET
    case PUT
}

class HttpClient
{
    public static func get(urlRequest: URLRequest, completionBlock: @escaping completionBlock) -> Void {
        var request = urlRequest
        request.httpMethod = HTTPMethod.GET.rawValue
        let task = URLSession.shared.dataTask(with: request) { (responseData, responseUrl, error) in
            guard let dataResponse = responseData else {
                completionBlock(nil, true, error?.localizedDescription,0)
                return
            }
            if let httpResponse = responseUrl as? HTTPURLResponse {
                completionBlock(dataResponse, true, error?.localizedDescription,httpResponse.statusCode)
            }
        }
        task.resume()
    }
}



// other method will describe here same way like above get method defined
