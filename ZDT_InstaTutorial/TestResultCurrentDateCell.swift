//
//  TestResultCurrentDateCell.swift
//  ZDT_InstaTutorial
//
//  Created by peter huang on 07/04/2017.
//  Copyright © 2017 Zappdesigntemplates. All rights reserved.
//

import UIKit

class TestResultCurrentDateCell: UICollectionViewCell {
    
    @IBOutlet weak var serialLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    
    var account:String? = nil
    
    @IBOutlet weak var circleV: UIView!
    var brItem:BRItem? {
        
        didSet{
            self.circleV?.layer.cornerRadius = 12
            self.circleV?.layer.borderWidth = 2.0
            self.circleV?.layer.backgroundColor = UIColor.clear.cgColor
            self.circleV?.layer.borderColor = UIColor.green.cgColor
            self.circleV?.clipsToBounds = true
            
            
            self.circleV?.isHidden = true
            self.serialLb.isHidden = true
            
            if let date =  brItem?.date {
                self.circleV?.isHidden = false
                //let calendar = Calendar.current
                //let year = calendar.component(.year, from: date!)
//                let month = calendar.component(.month, from: date)
//                let day = calendar.component(.day, from: date)
//                let weekDay = calendar.component(.weekday, from: date)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd"
                self.dateLb.text = dateFormatter.string(from: date)
                
                
                var isAllDone = true
                for (_, testItem) in (brItem?.testItems.enumerated())! {
                    
                    let isDone =
                        testItem.isDone()
                    if !isDone {
                        isAllDone = false
                        break
                    }
                }
                
                if (brItem?.testItems.count)! > 0 {
                    
                    let firstTestItem:TestItem? = brItem?.testItems[0]
                    
                    let color_sperm = UIColor.init(red: 247/255.0, green: 176/255.0, blue: 41/255.0, alpha: 1)
                    let color_FSH = UIColor.init(red: 234/255.0, green: 97/255.0, blue: 120/255.0, alpha: 1)
                    let color_LH = UIColor.init(red: 0/255.0, green: 179/255.0, blue: 200/255.0, alpha: 1)
                    let color_HCG = UIColor.init(red: 196/255.0, green: 214/255.0, blue: 0/255.0, alpha: 1)
                    let color_mating = UIColor.purple
                    let color_temperature = UIColor.white
                    
                    var color_current = UIColor.clear
                    
                    if firstTestItem?.type == .Sperm {
                        color_current = color_sperm
                    } else if firstTestItem?.type == .FSH {
                        color_current = color_FSH
                    } else if firstTestItem?.type == .LH {
                        color_current = color_LH
                    } else if firstTestItem?.type == .HCG {
                        color_current = color_HCG
                    } else if firstTestItem?.type == .Mating {
                        color_current = color_mating
                    } else if firstTestItem?.type == .Temperature {
                        color_current = color_temperature
                    }
                    
                    self.circleV?.layer.borderColor = color_current.cgColor
                    self.circleV?.layer.backgroundColor = color_current.cgColor
                    
                    if !isAllDone {
                        self.dateLb.textColor = color_current
                        self.circleV?.layer.backgroundColor = UIColor.black.cgColor
                    } else {
                        self.dateLb.textColor =  UIColor.black
                    }
              
                } else {
                    self.circleV?.isHidden = false
                    self.circleV?.layer.backgroundColor = UIColor.clear.cgColor
                    self.circleV?.layer.borderColor = UIColor.gray.cgColor
                    self.dateLb.textColor = UIColor.gray
                }
            
                
            } else {
                self.circleV?.isHidden = false
                self.circleV?.layer.backgroundColor = UIColor.clear.cgColor
                self.circleV?.layer.borderColor = UIColor.gray.cgColor
                self.dateLb.textColor = UIColor.gray
            }
        }
        
        willSet(newValue){
            
            
        }
        
    }
    
}


