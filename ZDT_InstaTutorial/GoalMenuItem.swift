//
//  GoalMenuItem.swift
//  ZDT_InstaTutorial
//
//  Created by peter huang on 01/06/2017.
//  Copyright © 2017 Zappdesigntemplates. All rights reserved.
//

import Foundation

enum GoalMenuItemType: UInt32 {
    case Date = 0
    case BBT = 1
    case LH = 2
    case FSH = 3
    case HCG = 4
    case Sperm = 10
    case SEX = 11
    case ManuallyBLeeding = 5
    case ManuallyEndBLeeding = 6
    case ManuallySEXProtected = 7
    case ManuallySEXUnProtected = 8
    case ManuallyUnfolded = 9
}

class GoalMenuItem {

    var type:GoalMenuItemType?
    var testItemCid:String?
    var menuItemStr:String?
    var isHollow:Bool = true
    
}
