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
    
    var testItemCid:String? = nil
    var gender:GenderType? = nil
    var priority:Int = 0
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
                self.priority = 1
                
            }
            
        }
    }
    var date:Date? = nil
    
    var value:[[String: Any]]? = nil
    
    func isDone()->Bool {
        
        if self.value != nil {
            return true;
        } else {
            return false;
        }
    }
    
}
