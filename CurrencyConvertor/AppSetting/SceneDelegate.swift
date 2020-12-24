//
//  SceneDelegate.swift
//  CurrencyConvertor
//
//  Created by Sushobhit.Jain on 23/12/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var router:AppMainRouter?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // App Router call to navigate intial view
        router = AppMainRouter(window: window ?? UIWindow())
        router?.start()
    }
}

