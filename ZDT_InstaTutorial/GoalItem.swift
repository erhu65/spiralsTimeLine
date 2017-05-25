//
//  GoalItemlMO.swift
//  ZDT_InstaTutorial
//
//  Created by peter huang on 10/05/2017.
//  Copyright © 2017 Zappdesigntemplates. All rights reserved.
//

import Foundation

//case Sperm
//case LH
//case HCG
//case FSH
//case SEX
//case BBT

class GoalItemlMO {
    
    var testItemCid:String? = "1"
    var typeName:String? =  nil
    var value:[[String: Any]]? = nil
    
    static func mkRandomSpermValue() -> [[String: Any]]? {
    
        let diceRoll = Int(arc4random_uniform(5) + 1)
        if diceRoll == 1 || diceRoll == 2  {
            return nil;
        } else {
            return [["type": "concentration", "typeValue": 0.1],
            ["type": "motility", "typeValue": 0.2],
            ["type": "morphology", "typeValue": 0.3]];
        }
    }
    
    static func mkRandomSEXValue() -> [[String: Any]]? {
        var vlaue:[[String: Any]]? = nil;
        let diceRoll = Int(arc4random_uniform(3) + 1)
        switch diceRoll {
        case 1:
            vlaue = nil//SEX Not yet done
        case 2:
            vlaue = [["type": "SEX", "typeValue": 1]]//sex protected
        case 3:
            vlaue = [["type": "SEX", "typeValue": 2]]//sex unprotected
        default:
            vlaue = nil//SEX Not yet done
        }
        return vlaue
    }
    static func mkRandomBleedingValue() -> [[String: Any]]? {
        var vlaue:[[String: Any]]? = nil;
        let diceRoll = Int(arc4random_uniform(2) + 1)
        switch diceRoll {
        case 1:
            vlaue = [["type": "Bleeding", "typeValue": 1]]//當天經期中（goal畫面顯示紅色小點）
        case 2:
            vlaue = [["type": "Bleeding", "typeValue": 0]]//當天經期中，且當天算結束（goal畫面顯示紅色小點）
        default:
            vlaue = [["type": "Bleeding", "typeValue": 0]]//當天經期中，且當天算結束（goal畫面顯示紅色小點）
        }
        return vlaue
    }
    
    static func mkRandomFemaleGoalItem() -> GoalItemlMO {
        
        let goalItem = GoalItemlMO()
        goalItem.testItemCid = "0000"
        
        let diceRoll = Int(arc4random_uniform(6) + 1)
        
        switch diceRoll {
        case 1:
            goalItem.typeName = "LH"
            goalItem.value = [["type": "LH", "typeValue": 0.1]]
        case 2:
            goalItem.typeName = "HCG"
            goalItem.value = [["type": "HCG", "typeValue": 0.1]]
        case 3:
            goalItem.typeName = "FSH"
            goalItem.value = [["type": "FSH", "typeValue": 0.1]]
        case 4:
            goalItem.typeName = "BBT"
            goalItem.value = [["type": "BBT", "typeValue": 0.1]]
        case 5:
            goalItem.typeName = "Bleeding"
            goalItem.value = GoalItemlMO.mkRandomBleedingValue()
        case 6:
            goalItem.typeName = "SEX"
            goalItem.value = GoalItemlMO.mkRandomSEXValue()
        default:
            goalItem.typeName = "BBT"
            goalItem.value = [["type": "BBT", "typeValue": 0.1]]
        }
        
        let diceRoll2 = Int(arc4random_uniform(3) + 1)
        if diceRoll2 == 1 {
            goalItem.value = nil
        }
    
        return goalItem
    }

}
