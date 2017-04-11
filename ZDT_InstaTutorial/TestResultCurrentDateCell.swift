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
    
    func getDayOfWeek(today:String)->Int {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: today)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday
        return weekDay!
    }
    

    
}


