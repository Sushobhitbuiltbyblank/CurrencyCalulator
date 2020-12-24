//
//  CurrencyExchangeRouter.swift
//  CurrencyConvertor
//
//  Created by Sushobhit.Jain on 23/12/20.
//

import Foundation
import UIKit

class CurrencyExchangeRouter {
    
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private let storyboard: UIStoryboard = UIStoryboard(name:Storyboards.currencyConvertor,bundle: Bundle.main)
    
    func start() {
        let view = self.storyboard.instantiateViewController(withIdentifier: CurrencyExchangeViewController.storyboardIdentifier) as! CurrencyExchangeViewController
        let interator = CurrencyExchangeInteractor()
        let presenter = CurrencyExchangePresenter(interator: interator)
        presenter.view = view
        view.presenter = presenter
        interator.presenter = presenter
        self.navigationController.pushViewController(view, animated: true)
    }
}
