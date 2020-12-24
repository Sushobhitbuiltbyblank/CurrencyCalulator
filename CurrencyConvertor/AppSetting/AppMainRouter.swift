//
//  AppMainRouter.swift
//  CurrencyConvertor
//
//  Created by Sushobhit.Jain on 23/12/20.
//

import Foundation
import UIKit

class AppMainRouter {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        if #available(iOS 13.0, *) {
            navigationController.overrideUserInterfaceStyle = .light
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        // Intial Module router call to get view on current window according to business logic
        let router = CurrencyExchangeRouter(navigationController: navigationController)
        router.start()
    }
}
