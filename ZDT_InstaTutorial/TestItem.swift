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
    var value:[[String: Any]]? = nil
    
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
        let valueArr = self.value;
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        
        switch self.type! {

            case .Sperm:
                if let valueArrUnWrap = valueArr {
                    let concentrationDict = valueArrUnWrap[0]
                    let concentration = concentrationDict["typeValue"]
                    let motilityDict = valueArrUnWrap[1];
                    let motility = motilityDict["typeValue"]
                    let morphologyDict = valueArrUnWrap[2];
                    let morphology = morphologyDict["typeValue"]
                    valStr = "Sperm:\(concentration!), \(motility!), \(morphology!)"
                } else {
                    let dateString = formatter.string(from: self.reminderDate!)
                    valStr = "Sperm: scheduled @ \(dateString)"
                }
            case .LH:
                if let valueArrUnWrap = valueArr {
                    let valDict = valueArrUnWrap[0]
                    let value = valDict["typeValue"]
                    valStr = "LH:\(value!)"
                } else {
                    let dateString = formatter.string(from: self.reminderDate!)
                    valStr = "LH: scheduled @ \(dateString)"
                }
                
            case .HCG:
                if let valueArrUnWrap = valueArr {
                    let valDict = valueArrUnWrap[0]
                    let value = valDict["typeValue"]
                    valStr = "HCG:\(value!)"
                } else {
                    let dateString = formatter.string(from: self.reminderDate!)
                    valStr = "HCG: scheduled @ \(dateString)"
                }
            case .FSH:
                if let valueArrUnWrap = valueArr {
                    let valDict = valueArrUnWrap[0]
                    let value = valDict["typeValue"]
                    valStr = "FSH:\(value!)"
                } else {
                    let dateString = formatter.string(from: self.reminderDate!)
                    valStr = "FSH: scheduled @ \(dateString)"
                }
            case .SEX:
                if let valueArrUnWrap = valueArr {
                    let valDict = valueArrUnWrap[0]
                    let value = valDict["typeValue"]
                    valStr = "SEX:\(value!)"
                } else {
                    let dateString = formatter.string(from: self.reminderDate!)
                    valStr = "SEX: scheduled @ \(dateString)"
                }
            case .BBT:
                if let valueArrUnWrap = valueArr {
                    let valDict = valueArrUnWrap[0]
                    let value = valDict["typeValue"]
                    valStr = "BBT:\(value!)"
                } else {
                    let dateString = formatter.string(from: self.reminderDate!)
                    valStr = "BBT: scheduled @ \(dateString)"
                }
        case .Bleeding:
            if let valueArrUnWrap = valueArr {
                let valDict = valueArrUnWrap[0]
                let value = valDict["typeValue"]
                valStr = "Bleeding:\(value!)"
            } else {
                valStr = "Bleeding:"
            }
            default:
                print("")
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
