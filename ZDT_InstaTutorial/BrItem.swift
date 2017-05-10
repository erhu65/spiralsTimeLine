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
    var testItems:[TestItem] = []
    var date:Date? = nil
    var cellGuildLine:CellGuildLine?
    
    
    init() {
        
        let random1 = arc4random_uniform(11) + 5;
        if random1 == 5
            ||  random1 == 6
            ||  random1 == 7
            ||  random1 == 8
            ||  random1 == 9
            ||  random1 == 10
            ||  random1 == 11
            ||  random1 == 12{
            
            let testItem = ViewController.mkRandomTestItem()
            testItems.append(testItem)
        }
        
        let random = arc4random_uniform(21) + 10;
        if random == 10
            ||  random == 20
            ||  random == 30 {
            let testItem = ViewController.mkRandomTestItem()
            testItems.append(testItem)
        }
        
        let random2 = arc4random_uniform(5);
        if random2 == 0
            ||  random2 == 1
            ||  random2 == 1 {
            
            let testItem = ViewController.mkRandomTestItem()
            testItems.append(testItem)
        }
        
        let random３ = arc4random_uniform(5);
        if random３ == 0
            ||  random３ == 1 {
            let testItem = ViewController.mkRandomTestItem()
            testItems.append(testItem)
        }
        
    }
    
    func addTestItem(testItem:TestItem) {
        testItems.append(testItem)
    }
    
    func reOrderTestItems(currentLoginAccount:String) {
        
        if date == nil {
            return;
        }
        if(self.testItems.count == 0){
            return
        }
        
        var idnexMostImportant:Int = -1;
        for (idx, testItem) in (self.testItems.enumerated()) {
            
            
            if testItem.gender == currentLoginAccount
                && testItem.priority == 3
                && testItem.isDone() == false
            {
                idnexMostImportant = idx;
                break;
            }
        }
        
        if idnexMostImportant == -1 {
            
            for (idx, testItem) in (self.testItems.enumerated()) {
                
                
                if testItem.gender == currentLoginAccount
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
                
                
                if testItem.gender == currentLoginAccount
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
                
                
                if testItem.gender != currentLoginAccount
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
                
                if testItem.gender == currentLoginAccount
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
                
                if testItem.gender != currentLoginAccount
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
                
                if testItem.gender == currentLoginAccount
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
                
                if testItem.gender != currentLoginAccount
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
                
                
                
                if testItem.gender == currentLoginAccount
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
        
    }
    
}
