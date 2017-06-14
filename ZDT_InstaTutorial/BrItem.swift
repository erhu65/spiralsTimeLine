//
//  BrItem.swift
//  ZDT_InstaTutorial
//
//  Created by peter huang on 10/05/2017.
//  Copyright © 2017 Zappdesigntemplates. All rights reserved.
//

import Foundation


class BRItem {
    
    var index:Int = -1
    var serial:Int = -1
    var maleGoal:GoalMO? = nil
    var maleGoalCid:String = ""
    var maleTestItems:[TestItem] = []
    var femaleGoalCid:String = ""
    var femaleGoal:GoalMO? = nil
    var femaleTestItems:[TestItem] = []
    
    var testItems:[TestItem] = []
    var date:Date? = nil
    var cellGuildLine:CellGuildLine?
    var isEmptyRow:Bool = false
   
    
    init() {
        testItems = []
        
//        let random1 = arc4random_uniform(11) + 5;
//        if random1 == 5
//            ||  random1 == 6
//            ||  random1 == 7
//            ||  random1 == 8
//            ||  random1 == 9
//            ||  random1 == 10
//            ||  random1 == 11
//            ||  random1 == 12{
//            
//            let testItem = ViewController.mkRandomTestItem()
//            testItems.append(testItem)
//        }
//        
//        let random = arc4random_uniform(21) + 10;
//        if random == 10
//            ||  random == 20
//            ||  random == 30 {
//            let testItem = ViewController.mkRandomTestItem()
//            testItems.append(testItem)
//        }
//        
//        let random2 = arc4random_uniform(5);
//        if random2 == 0
//            ||  random2 == 1
//            ||  random2 == 2 {
//            
//            let testItem = ViewController.mkRandomTestItem()
//            testItems.append(testItem)
//        }
//        
//        let random３ = arc4random_uniform(5);
//        if random３ == 0
//            ||  random３ == 1 {
//            let testItem = ViewController.mkRandomTestItem()
//            testItems.append(testItem)
//        }
//        
//        let random4 = arc4random_uniform(5);
//        if random4 == 0
//            ||  random4 == 1
//        {
//            testItems = []
//        }
        
        
        
    }

    
    func addTestItem(testItem:TestItem) {
        testItems.append(testItem)
    }
    
    func reOrderTestItems(currentLoginGender:GenderType) {
        
        if date == nil {
            return;
        }
        if(self.testItems.count == 0){
            return
        }
        
        var idnexMostImportant:Int = -1;
        var idnexOfBleedingFound:Int = -1;
        
        for (idx, testItem) in (self.testItems.enumerated()) {
            
            
            if testItem.gender! == currentLoginGender
                && testItem.priority == 3
                && testItem.isDone() == false
            {
                idnexMostImportant = idx;
                break;
            }
        }
        
        if idnexMostImportant == -1 {
            
            for (idx, testItem) in (self.testItems.enumerated()) {
                
                
                if testItem.gender! != currentLoginGender
                    && testItem.priority == 3
                    && testItem.isDone() == false
                {
                    idnexMostImportant = idx;
                    break;
                }
            }
            
        }
        
        if idnexMostImportant == -1 {
            
            for (idx, testItem) in (self.testItems.enumerated()) {
                
                
                if testItem.gender! == currentLoginGender
                    && testItem.priority == 2
                    && testItem.isDone() == false
                {
                    idnexMostImportant = idx;
                    break;
                }
            }
            
        }
        
        if idnexMostImportant == -1 {
            for (idx, testItem) in (self.testItems.enumerated()) {
                
                
                if testItem.gender! != currentLoginGender
                    && testItem.priority == 2
                    && testItem.isDone() == false
                {
                    idnexMostImportant = idx;
                    break;
                }
            }
            
        }
        
        
        if idnexMostImportant == -1 {
            
            for (idx, testItem) in (self.testItems.enumerated()) {
                
                if testItem.gender! == currentLoginGender
                    && (testItem.priority == 3
                        || testItem.priority == 2
                        || testItem.priority == 1
                    )
                    && testItem.isDone() == false
                {
                    idnexMostImportant = idx;
                    break;
                }
            }
            
        }
        
        if idnexMostImportant == -1 {
            
            for (idx, testItem) in (self.testItems.enumerated()) {
                
                if testItem.gender! != currentLoginGender
                    && (testItem.priority == 3
                        || testItem.priority == 2
                        || testItem.priority == 1
                    )
                    && testItem.isDone() == false
                {
                    idnexMostImportant = idx;
                    break;
                }
            }
            
        }
        
        if idnexMostImportant == -1 {
            
            for (idx, testItem) in (self.testItems.enumerated()) {
                
                if testItem.gender! == currentLoginGender
                    && (testItem.priority == 3
                        || testItem.priority == 2
                        || testItem.priority == 1
                    )
                    && testItem.isDone() == true
                {
                    idnexMostImportant = idx;
                    break;
                }
            }
            
        }
        
        if idnexMostImportant != -1 {
            
            let mostImportantTestItem = self.testItems.remove(at: idnexMostImportant);
            self.testItems.insert(mostImportantTestItem, at: 0)
        }
        
        
        for (idx, testItem) in (self.testItems.enumerated()) {
            
            if testItem.type! == .Bleeding
            {
                idnexOfBleedingFound = idx;
                break;
            }
        }
        
        if(idnexOfBleedingFound != -1) {
            let lastIndex = (self.testItems.count - 1)
            let bleedingTestItem = self.testItems.remove(at: idnexOfBleedingFound);
            self.testItems.insert(bleedingTestItem, at: lastIndex)
        }
        
    }
    
    func isAllDone()->Bool {
        var isAllDone = true
        
        for testItem in testItems {
        
            if testItem.isDone() == false {
                isAllDone = false
                break
            }
            
        }
        return isAllDone
    }
    
    func countExcludeBleeding() -> Int {
        
        var count = 0
        for testItem in self.testItems {
            if testItem.type == .Bleeding {
                continue
            }
            count += 1
        }
        
        return count
    }
}
