//
//  ImageCollectionViewCell.swift
//  ZDT_InstaTutorial
//
//  Created by Sztanyi Szabolcs on 22/12/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

import UIKit

class TestResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImv: UIImageView!
    @IBOutlet weak var serialLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    
    var date:Date? {
        
        didSet{
            if  date != nil  {
                let calendar = Calendar.current
                let year = calendar.component(.year, from: date!)
                let month = calendar.component(.month, from: date!)
                let day = calendar.component(.day, from: date!)
                let weekDay = calendar.component(.weekday, from: date!)
                self.dateLb.text = "\(month)/\(day)(\(weekDay))"
            } else {
                self.dateLb.text = ""
            }
        }
        willSet(newValue){
            
            
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImv.image = nil
    }
}
