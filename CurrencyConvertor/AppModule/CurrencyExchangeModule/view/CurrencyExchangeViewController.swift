//
//  CurrencyExchangeViewController.swift
//  CurrencyConvertor
//
//  Created by Sushobhit.Jain on 23/12/20.
//

import UIKit

class CurrencyExchangeViewController: UIViewController {
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var exchangedAmountLabel: UILabel!
    @IBOutlet weak var currenciesCollectionView: UICollectionView!
    @IBOutlet weak var selectEnteredCurrencyButton: UIButton!
    @IBOutlet weak var selectExchangedCurrencyButton: UIButton!
    
    static let storyboardIdentifier = ViewControllerIdentifier.currencyExchangeViewController
    
    let dropDownView = CustomDropDrownView()
    let tableView = UITableView()
    var selectedButton:UIButton?
    var currencyModelList:[CurrencyModel]?
    var selectedCurrencyConverted:[CurrencyModel]?
    var presenter:CurrencyExchangePresenter?
    var selectedCurrency:CurrencyModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    func setUp() {
        self.title = "Currency Converter"
        self.amountTextField.delegate = self
        self.presenter?.getCurrencyList()
        
        //set default value
        self.exchangedAmountLabel.text = "0.00"
        self.selectEnteredCurrencyButton.setTitle("USD", for: .normal)
    }
    
    //MARK:- Presenter -> View
    func showData(list:[CurrencyModel]) {
        self.currencyModelList = list
        // set ist value by default
        self.selectedCurrencyConverted = list
        if self.currencyModelList?.count ?? 0 > 0 {
            if let selected = self.currencyModelList?[0] {
                self.selectedCurrency = selected
            }
        }
        self.updateCollectionView()
        
    }
        
    //MARK:- User Actions
    @IBAction func onClickConvertButton(_ sender: Any) {
        self.removekeyboard()
        guard let amount = self.amountTextField.text == "" ? nil : amountTextField.text else {
            return
        }
        let amountDouble = Double(amount) ?? 0.00
        
        guard let selected = self.selectedCurrency  else {
            return
        }
        self.convertedValue(amount: amountDouble, selectedCurrency: selected)
    }
    
    func convertedValue(amount:Double,selectedCurrency:CurrencyModel) {
        let convertedAmount = amount * selectedCurrency.value
        self.exchangedAmountLabel.text = "\(convertedAmount)"
    }
    
    @IBAction func onClickEnteredCurrencyButton(_ sender: Any) {
        // white code if api give me the value from source currency to other currency exchange rate list
        // I this free version they only give the list of usd to other currency exchange rate list
        
    }
    
    
    @IBAction func onClickExchangeCurrencyButton(_ sender: Any) {
        self.selectedButton = selectExchangedCurrencyButton
        self.dropDownView.addTransparentView(frame: CGRect(x: self.view.center.x - 100, y: self.selectExchangedCurrencyButton.center.y-200, width: 200, height: 200), presentOn: self, with: self.currencyModelList, button: selectExchangedCurrencyButton)
        self.dropDownView.completion = { [unowned self] value in
            if let selected = self.currencyModelList?.filter({ $0.name == value}), selected.count > 0
            {
                self.selectedCurrency = selected.first
                self.updateCollectionView()
            }
        }
    }
    
    //MARK: - Utility Function
    func removekeyboard() {
        self.view.endEditing(true)
    }
    
    func updateCollectionView()
    {
        DispatchQueue.main.async {
            self.currenciesCollectionView.reloadData()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CurrencyExchangeViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.amountTextField.resignFirstResponder()
        return false
    }
}

extension CurrencyExchangeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedCurrencyConverted?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:CurrencyCollectionViewCell.reuseIdentifier , for: indexPath) as! CurrencyCollectionViewCell
        let currencyModel = self.selectedCurrencyConverted?[indexPath.item] ?? CurrencyModel(name: "", value: 0.00)
        cell.setUP(titleStr: currencyModel.name, subTitleStr: "\(currencyModel.value.format(f: ".06"))")
        if currencyModel == selectedCurrency {
            cell.contentView.backgroundColor = .orange
            self.selectExchangedCurrencyButton.setTitle( currencyModel.name, for: .normal)
        }
        else {
            cell.contentView.backgroundColor = .yellow
        }
        return cell
    }
    
}

extension CurrencyExchangeViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currencyModel = self.selectedCurrencyConverted?[indexPath.item] ?? CurrencyModel(name: "", value: 0.00)
        self.selectedCurrency = currencyModel
        if let amount = self.amountTextField.text == "" ? nil : amountTextField.text {
            let amountDouble = Double(amount) ?? 0.00
            self.convertedValue(amount: amountDouble, selectedCurrency: currencyModel)
        }
        self.updateCollectionView()
        
    }
}

extension CurrencyExchangeViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width) / 4) // 15 because of paddings
            return CGSize(width: width, height: 100)
    }
}
