//
//  CurrencyExchangeInterator.swift
//  CurrencyConvertor
//
//  Created by Sushobhit.Jain on 23/12/20.
//

import Foundation

/*
    This class communicate with other resource to get data like web service and database
    This class is responsible to communicate with presenter to pass the data coming from external resource
*/

class CurrencyExchangeInteractor {
    unowned var presenter:CurrencyExchangePresenter?
    
    //MARK:- Presenter to Interactor
    func getAllLiveCurrencyList() {
        if self.isUpdateRequired() {
            self.getFromRemoteDataProvider()
        } else {
            self.getFromLocalDataProvider()
        }
    }
    
    func getFromLocalDataProvider() {
        do {
            let localDataManager = CurrencyLocalDataManager()
            let list = try localDataManager.retrieveCurrencyList()
            var currencyModelList = [CurrencyModel]()
            for element in list {
                currencyModelList.append(CurrencyModel(name:element.name!,value:element.exchangeValue as! Double))
            }
            if currencyModelList.isEmpty {
                self.getFromRemoteDataProvider()
            }
            else {
                self.presenter?.listFetchSuccess(list: currencyModelList)
            }
        }
        catch {
            self.presenter?.listFetchFailed(error: CommonError.coreDataWhileGet)

        }
    }
    
    func getFromRemoteDataProvider() {
        let currencyProvider = CurrencyProvider()
        currencyProvider.getCurrencyDataList { (response, isSuccess, error) in
            if error != "" { // check there is any error first
                self.presenter?.listFetchFailed(error: CommonError.listEmply)
                return
            }
            if let currencyList = response?.quotes {
                var currencyModelList = [CurrencyModel]()
                for (key,value) in currencyList {
                    var updateName = key //remove "usd" prefix
                    updateName.removeFirst(3)
                    currencyModelList.append(CurrencyModel(name:updateName,value:value))
                    self.updateLocalData(name: updateName, value: value)
                }
                self.presenter?.listFetchSuccess(list: currencyModelList)
            }
            else {
                self.presenter?.listFetchFailed(error: CommonError.listEmply)
            }
        }
    }
    
    func updateLocalData(name:String,value:Double) {
        let localDataManager = CurrencyLocalDataManager()
        DispatchQueue.main.async {
            do {
                try localDataManager.saveCurrency(name:name,value:value)
            } catch {
                self.presenter?.listFetchFailed(error: CommonError.coreDataWhileSave)
            }
        }
    }
    
    
    // MARK:- Logic for every time interval
    // here we follow every 30 min update and not hit api everytime.
    
    func timeDifferece(pre:Date)-> Int{
        let calendar = Calendar.current
        let timeComponents = calendar.dateComponents([.hour, .minute], from: pre)
        let nowComponents = calendar.dateComponents([.hour, .minute], from: Date())
        let difference = calendar.dateComponents([.minute], from: timeComponents, to: nowComponents).minute!
        return difference
    }
    
    func isUpdateRequired() -> Bool{
        var difference = 0
        // check 30 min is over so we get updated live data else use local data
        if let previousUpdateTime:Date = UserDefaults.standard.value(forKey: "LastRun") as? Date {
            difference = timeDifferece(pre: previousUpdateTime)
        } else {
            UserDefaults.standard.set(Date(), forKey: "LastRun")
        }
        if difference > updateTimeInterval {
            return true
        }
        return false
    }
}

