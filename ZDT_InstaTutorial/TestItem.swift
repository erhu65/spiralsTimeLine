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
    case Mating
    case BBT
    
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
            case .Mating :
                self.priority = 2
            case .BBT :
                self.priority = 1
                
            }
            
        }
    }
    var date:Date? = nil
    
    var value:Float = -1.0
    
    var sperm_motility:Float = -1.0
    var sperm_morpphology:Float = -1.0
    var sperm_concentration:Float = -1.0
    
    
    func isDone()->Bool {
        
        if self.type == .Sperm
        {
            if self.sperm_motility == -1.0
                && self.sperm_morpphology == -1.0
                && self.sperm_concentration == -1.0 {
                
                return false
            } else {
                return true
                
            }
        }
        
        if self.value == -1.0 {
            return false
        }
        
        return true
    }
    
}
