//
//  CurrencyDataProvider.swift
//  CurrencyConvertor
//
//  Created by Sushobhit.Jain on 23/12/20.
//

import Foundation
// declare a protocol of provider type - in future if we need other currency provider then we can it by implementing this.
protocol CurrencyDataProvider {
    func getCurrencyDataList(completionBlock: @escaping (LiveCurrencylayerResponse?,Bool,String)->Void)
}

// API client
struct LiveCurrencyAPI {
    static let scheme = "http"
    static let host = "api.currencylayer.com"
    static let path = "/live"
    static let key = "ca424b58e4bb8913f46b444f39957990"
}

class CurrencyProvider :CurrencyDataProvider {
    
    private func makeLiveCurrencyComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = LiveCurrencyAPI.scheme
        components.host = LiveCurrencyAPI.host
        components.path = LiveCurrencyAPI.path
        components.queryItems = [
            URLQueryItem(name: "access_key", value: LiveCurrencyAPI.key)
        ]
        return components
    }
    
    func getCurrencyDataList(completionBlock: @escaping (LiveCurrencylayerResponse?,Bool,String)->Void) {
        let urlComponent = self.makeLiveCurrencyComponents()
        guard let url = urlComponent.url else {
            completionBlock(nil,false,NetworkError.invalidURL.localizedDescription)
            return
        }
        let urlRequest = URLRequest(url: url)
        HttpClient.get(urlRequest: urlRequest) { (response, status, error,statusCode) -> (Void) in
            // Handle statuscode related errors
            switch HTTPStatusCode(rawValue: statusCode)?.responseType {
            case .success :
                if let responseData = response {
                    do{
                        let analyticRes = try JSONDecoder().decode(LiveCurrencylayerResponse.self, from: responseData)
                        completionBlock(analyticRes,true,"") // if all good pass blank error with response data
                    }
                    catch let error {
                        completionBlock(nil,false,error.localizedDescription)
                    }
                }
            case .informational :
                completionBlock(nil,false,NetworkError.informational.localizedDescription)
                break
            case .clientError:
                completionBlock(nil,false,NetworkError.clientError.localizedDescription)
                break
            case .redirection:
                completionBlock(nil,false,NetworkError.redirection.localizedDescription)
                break
            case .serverError:
                completionBlock(nil,false,NetworkError.serverError.localizedDescription)
                break
            case .undefined:
                completionBlock(nil,false,NetworkError.unknown.localizedDescription)
                break
            case .none:
                completionBlock(nil,false,NetworkError.unknown.localizedDescription)
                break
            }
        }
        
    }
    
}
