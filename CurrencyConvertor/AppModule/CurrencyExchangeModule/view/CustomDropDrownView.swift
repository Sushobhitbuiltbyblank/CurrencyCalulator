//
//  CustomDropDrownView.swift
//  CurrencyConvertor
//
//  Created by Sushobhit.Jain on 24/12/20.
//

import Foundation
import UIKit

class CustomDropDrownView: UIView {
    
    private let tableView = UITableView()
    private var dataSource: [CurrencyModel]?
    private var selectedButton:UIButton?
    private var providedFrame:CGRect?
    private unowned var viewController:UIViewController?
    var completion:(_ value:String)-> Void = {_ in }
    override init(frame: CGRect) {
        super.init(frame: frame)
        // set a dropdown to select country from list
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DropDownCell.self, forCellReuseIdentifier: DropDownCell.identifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTransparentView(frame: CGRect, presentOn viewController:UIViewController,with dataSource:[CurrencyModel]?,button:UIButton) {
        self.providedFrame = frame
        self.dataSource = dataSource
        self.selectedButton = button
        self.viewController = viewController
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        self.frame = window?.frame ?? viewController.view.frame
        viewController.view.addSubview(self)
        
        tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.height, width: frame.width, height: 0)
        viewController.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        self.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.alpha = 0.5
            let height = ((dataSource?.count ?? 1) < 5) ? dataSource?.count ?? 1 : 5
            self.tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.height + 5, width: frame.width, height: CGFloat(height * 50))
        }, completion: nil)
    }
    
    func removeTransparentView() {
        let frame = self.providedFrame ?? CGRect.zero
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.alpha = 0
            self.tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.height, width: frame.width, height: 0)
        }, completion: nil)
    }

}

extension CustomDropDrownView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DropDownCell.identifier, for: indexPath)
        cell.textLabel?.text = self.dataSource?[indexPath.row].name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


extension CustomDropDrownView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountryModelName = self.dataSource?[indexPath.row].name ?? ""
        selectedButton?.setTitle(selectedCountryModelName, for: .normal)
        self.completion(selectedCountryModelName)
        self.removeTransparentView()
    }
}

