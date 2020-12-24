//
//  CurrencyExchangePresenter.swift
//  CurrencyConvertor
//
//  Created by Sushobhit.Jain on 23/12/20.
//

import Foundation
import UIKit

/* This class is responsible to communicate with
 view - this class provide all the required data to view,
 router - this class also communicate with router to go to next screen,
 intractor - this class communicate with intractor to get data from other source like web service and database
*/

class CurrencyExchangePresenter {
    let interator: CurrencyExchangeInteractor
    unowned var view:CurrencyExchangeViewController?
    init(interator:CurrencyExchangeInteractor) {
        self.interator = interator
    }
    
    // MARK:- Presenter to Interactor
    func getCurrencyList() {
        self.interator.getAllLiveCurrencyList()
    }
    
    
    // MARK:- Interactor to Presenter
    // get excuted by interactor to get data back to presenter.
    func listFetchSuccess(list:[CurrencyModel]) {
        // here we can modify models or perform any computation on model before pass
        self.view?.showData(list:list)
    }
    
    // call if interactor get error
    func listFetchFailed(error:String) {
        
    }
}
