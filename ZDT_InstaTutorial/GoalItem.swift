//
//  GoalItem.swift
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
//case Mating
//case BBT

class GoalItem {
    
    var testItemCid:String? = "1"
    var typeName:String? =  nil
    var value:[Float] = [-1.0]

    static func mkRandomFemaleGoalItem() -> GoalItem {
        
        let goalItem = GoalItem()
        goalItem.testItemCid = "0000"
        
        let diceRoll = Int(arc4random_uniform(5) + 1)
        
        switch diceRoll {
        case 1:
            goalItem.typeName = "LH"
        case 2:
            goalItem.typeName = "HCG"
        case 3:
            goalItem.typeName = "FSH"
        case 4:
            goalItem.typeName = "BBT"
        case 5:
            goalItem.typeName = "Mating"
        default:
            goalItem.typeName = "BBT"
        }
        
        let random = arc4random_uniform(11) + 5;
        if random == 5
            ||  random == 6
            ||  random == 7
            ||  random == 8
            ||  random == 9
            ||  random == 10
            ||  random == 11{
            
            goalItem.value = [0.5]
        }
        
    
        return goalItem
    }

}
