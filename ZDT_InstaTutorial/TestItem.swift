//
//  TestItem.swift
//  ZDT_InstaTutorial
//
//  Created by peter huang on 10/05/2017.
//  Copyright © 2017 Zappdesigntemplates. All rights reserved.
//

enum TestItemType: UInt32 {
    case Sperm
    case LH
    case HCG
    case FSH
    case SEX
    case BBT
    case Bleeding
    
    private static let _count: TestItemType.RawValue = {
        // find the maximum enum value
        var maxValue: UInt32 = 0
        while let _ = TestItemType(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    static func random() -> TestItemType {
        // pick and return a new value
        let rand = arc4random_uniform(_count)
        return TestItemType(rawValue: rand)!
    }
}

import Foundation

class TestItem {
    var reminderDate:Date?
    var testItemCid:String? = nil
    var gender:GenderType? = nil
    var priority:Int = 0
    var value:[String: Float]? = nil
    var goalItem:GoalItemMO? = nil
    
    var type:TestItemType? {
        
        didSet{
            switch type! {
            case .Sperm :
                self.priority = 3
            case .LH :
                self.priority = 3
            case .HCG :
                self.priority = 3
            case .FSH :
                self.priority = 3
            case .SEX :
                self.priority = 2
            case .BBT :
                self.priority = 1
            case .Bleeding :
                self.priority = 0
                
            }
            
        }
    }
    
    func menuItemStr()->String {
        
        var valStr = ""
        let valueDict = self.value;
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        let dateString = formatter.string(from: self.reminderDate!)
        let dateNow = Date()
        var isMissed = false
        if dateNow > self.reminderDate! {
            isMissed = true
        }
        
        switch self.type! {

            case .Sperm:
                
                if let concentration = valueDict?["concentration"], let motility = valueDict?["motility"] , let morphology = valueDict?["morphology"]{
                    valStr = "Sperm:\(concentration), \(motility), \(morphology)"
                } else {
                    if isMissed {
                       valStr = "SPERM: missed"
                    } else {
                        valStr = "SPERM: scheduled @ \(dateString)"
                    }
                }

            case .LH:
                if let value = valueDict?["LH"] {
                    valStr = "LH:\(value)"
                } else {
                    if isMissed {
                        valStr = "LH: missed"
                    } else {
                        valStr = "LH: scheduled @ \(dateString)"
                    }                }
            case .HCG:
                if let value = valueDict?["HCG"] {
                    valStr = "HCG:\(value)"
                } else {
                    if isMissed {
                        valStr = "HCG: missed"
                    } else {
                        valStr = "HCG: scheduled @ \(dateString)"
                    }
                }
        
            case .FSH:
                if let value = valueDict?["HCG"] {
                    valStr = "FSH:\(value)"
                } else {
                    if isMissed {
                        valStr = "FSH: missed"
                    } else {
                        valStr = "FSH: scheduled @ \(dateString)"
                    }
                }
            case .SEX:
                if let value = valueDict?["SEX"] {
                    valStr = "SEX:\(value)"
                } else {
                    if isMissed {
                        valStr = "SEX: missed"
                    } else {
                        valStr = "SEX: scheduled @ \(dateString)"
                    }
                }
        case .Bleeding:
            if let value = valueDict?["Bleeding"] {
                valStr = "Bleeding:\(value)"
            } else {
                valStr = "Bleeding"
            }
        case .BBT:
            if let value = valueDict?["BBT"] {
                valStr = "BBT:\(value)"
            } else {
                if isMissed {
                    valStr = "BBT: missed"
                } else {
                    valStr = "BBT: scheduled @ \(dateString)"
                }
            }

        }
        
  
        return valStr
        
    }
    
    func isDone()->Bool {
        
        if self.type == .Bleeding {
            return true
        }
        
        if self.value != nil {
            return true
        } else {
            return false
        }
    }
    
    
    
    
    
}
