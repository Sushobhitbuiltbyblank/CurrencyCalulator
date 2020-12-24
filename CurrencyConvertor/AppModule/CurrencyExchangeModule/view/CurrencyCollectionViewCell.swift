//
//  CurrencyCollectionViewCell.swift
//  CurrencyConvertor
//
//  Created by Sushobhit.Jain on 24/12/20.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CurrencyCollectionViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    func setUP(titleStr:String,subTitleStr:String) {
        
        self.titleLabel.text = titleStr
        self.subTitleLabel.text = subTitleStr
    }
    
}
