//
//  ViewController.swift
//  ZDT_InstaTutorial
//
//  Created by Sztanyi Szabolcs on 22/12/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

import UIKit

enum CellGuildLine: UInt32 {
    case none
    case topLeft
    case bottomLeft
    case topRight
    case bottomRight
    case horizontal
    case vertical
}

enum CellRegularPattern: UInt32 {
    case before_pattern_7e_1c
    case before_pattern_8c
    case before_pattern_1c_L
    case before_pattern_empty7_2
    case before_pattern_circle8_2
    case future_pattern_7e_1c
    case future_pattern_8c_reverse
    case future_pattern_1c_7e
    case future_pattern_8c
    case future_pattern_8c_not_enough
    case future_pattern_end
}



enum TestItemType: UInt32 {
    case Sperm
    case LH
    case HCG
    case FSH
    case Mating
    case Temperature
    
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

class TestItem {
    var account:String? = nil
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
            case .Temperature :
                self.priority = 1
        
            }
        
        }
    }
    var date:Date? = nil
    
    var value:Float = 0.0
    
    var sperm_motility:Float = 0.0
    var sperm_morpphology:Float = 0.0
    var sperm_concentration:Float = 0.0

    
    func isDone()->Bool {
        
        if self.type == .Sperm
        {
            if self.sperm_motility == 0.0
                && self.sperm_morpphology == 0.0
                && self.sperm_concentration == 0.0 {
                
                return false
            } else {
                return true

            }
        }

        if self.value == 0.0 {
            return false
        }
        
        return true
    }
    
}


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
      
            
            if testItem.account == currentLoginAccount
                && testItem.priority == 3
                && testItem.isDone() == false
            {
                idnexMostImportant = idx;
                break;
            }
        }
        
        if idnexMostImportant == -1 {
    
            for (idx, testItem) in (self.testItems.enumerated()) {
         
                
                if testItem.account == currentLoginAccount
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
          
                
                if testItem.account == currentLoginAccount
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
        
                
                if testItem.account != currentLoginAccount
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
         
                    if testItem.account == currentLoginAccount
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
           
                    if testItem.account != currentLoginAccount
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
            
                    if testItem.account == currentLoginAccount
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
           
                    if testItem.account != currentLoginAccount
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
                
             
                
                if testItem.account == currentLoginAccount
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
            
//            print("testItem.account:\(String(describing: mostImportantTestItem.account))")
//            print("testItem.typ:\(String(describing: mostImportantTestItem.type))")
//            print("testItem.priority:\(mostImportantTestItem.priority)")
//            print("testItem.isDone:\(mostImportantTestItem.isDone())")
//            print("idnexMostImportant:\(idnexMostImportant)")
         
        }

    }
    
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
UITextFieldDelegate{

    @IBOutlet weak var popV: UIView!
    @IBOutlet weak var popLb: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!

    let numberOfColumns:CGFloat = 10
    var allBrItemsForCell:[BRItem?] = []

    var collectionViewLayout: CustomImageFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewLayout = CustomImageFlowLayout()
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.view.layoutIfNeeded()
        self.popV.isHidden = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    
        let rowIndex = indexPath.row
        
        var itemWidth = (self.collectionView!.frame.width - (self.numberOfColumns)) / self.numberOfColumns
        var itemHeight:CGFloat = 0.0
        
        let barItem = self.allBrItemsForCell[rowIndex]
        barItem?.serial = rowIndex
        
        let dateCurrent = Date()
        let calendar = Calendar.current
        let componentsCurrent = calendar.dateComponents([.year, .month, .day], from: dateCurrent)
        let yearCurrent =  componentsCurrent.year
        let monthCurrent = componentsCurrent.month
        let dayCurrent = componentsCurrent.day
        
        
        if let  brdate = barItem?.date {
            let componentsTestItem = calendar.dateComponents([.year, .month, .day], from: brdate )
            let yearTestItem  =  componentsTestItem.year
            let monthTestItem  = componentsTestItem.month
            let dayTestItem  = componentsTestItem.day
            
            itemHeight = itemWidth;
            if yearCurrent == yearTestItem
                && monthCurrent == monthTestItem
                && dayCurrent == dayTestItem{
                itemWidth *= 2
            } else {
                
            }
        } else {
            itemHeight = itemWidth;
        }
        
        
        return CGSize(width: (itemWidth + 1), height: itemHeight)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allBrItemsForCell.count
        //return  (self.maxCellIndex + 1)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let rowIndex = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TestResultCollectionViewCell

        let cellCurrent = collectionView.dequeueReusableCell(withReuseIdentifier: "TestResultCurrentDateCell", for: indexPath) as! TestResultCurrentDateCell
        
        let barItem = self.allBrItemsForCell[rowIndex]
        barItem?.serial = rowIndex
        
        let dateCurrent = Date()
        let calendar = Calendar.current
        let componentsCurrent = calendar.dateComponents([.year, .month, .day], from: dateCurrent)
        let yearCurrent =  componentsCurrent.year
        let monthCurrent = componentsCurrent.month
        let dayCurrent = componentsCurrent.day
        
        cell.backgroundColor = UIColor.clear
        cellCurrent.backgroundColor = UIColor.clear
        
        if let barItemDate = barItem?.date {
            let componentsTestItem = calendar.dateComponents([.year, .month, .day], from: barItemDate )
            let yearTestItem  =  componentsTestItem.year
            let monthTestItem  = componentsTestItem.month
            let dayTestItem  = componentsTestItem.day
            
            if yearCurrent == yearTestItem
                && monthCurrent == monthTestItem
                && dayCurrent == dayTestItem{
              
                cellCurrent.brItem = barItem
                cellCurrent.serialLb.text = "\(indexPath.row)"
                
                return cellCurrent
            } else {
                cell.brItem = barItem
                //cell.date = barItemDate
                cell.serialLb.text = "\(indexPath.row)"
                return cell
            }
            
        } else {
            cell.brItem = barItem
            cell.serialLb.text = "\(indexPath.row)"
            return cell
        }
   
        //let imageName = (indexPath.row % 2 == 0) ? "image1" : "image2"
     
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let rowIndex = indexPath.row
        let barItem = self.allBrItemsForCell[rowIndex]
    
        guard let cellGuidLine = barItem?.cellGuildLine else {
            return
        }
        
        print("cellGuildLine: \(cellGuidLine)")
        
        guard let _ = barItem?.date else {
          
            return
        }
        
        let testIitemsCount = barItem?.testItems.count
        if testIitemsCount == 0 {
            return
        }
        
        let  attributes = collectionView.layoutAttributesForItem(at: indexPath)
        
        let cellRect = attributes?.frame;
        
        let cellFrameInSuperview = collectionView.convert(cellRect!, to: collectionView.superview)
        
        self.popV.isHidden = false
        self.popV.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        let cellFrameInSuperviewSizeWidth = cellFrameInSuperview.size.width
        
        let anchorXY = CGPoint(x: (cellFrameInSuperview.origin.x + cellFrameInSuperviewSizeWidth / 2), y: cellFrameInSuperview.origin.y)
        self.popV.center = anchorXY
        //let count = barItem?.testItems.count
        var testValStrs:[String] = []
        

        
        for (idx, testItem) in (barItem?.testItems.enumerated())! {
            var valStr = ""
            switch testItem.type! {
                
            case .Sperm:
                 valStr = "Sperm:\(testItem.sperm_motility), \(testItem.sperm_morpphology), \(testItem.sperm_concentration)"
            case .LH:
                valStr = "LH:\(testItem.value)"
            case .HCG:
                valStr = "HCG:\(testItem.value)"
            case .FSH:
                valStr = "FSH:\(testItem.value)"
            case .Mating:
                valStr = "Mating:\(testItem.value)"
            case .Temperature:
                valStr = "Temperature:\(testItem.value)"
            }
            
            valStr = "\(idx+1). \(valStr)"
            testValStrs.append(valStr)
        }
        if let date = barItem?.date {
        
            let calendar = Calendar.current
            //let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            let weekDay = calendar.component(.weekday, from: date)
            let dateStr = "\(month)/\(day)(\(weekDay))"
            testValStrs.append(dateStr)
        }
        
        //testValStrs.append("serial: \(String(describing: barItem?.serial))")
        
        let testValStr = testValStrs.joined(separator: "\n")
        
        //x:\(cellFrameInSuperview.origin.x),y:\(cellFrameInSuperview.origin.y
    
        self.popLb.text = testValStr

    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        let rowIndex = indexPath.row
        let barItem = self.allBrItemsForCell[rowIndex]
        self.popV.isHidden = true
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.popV.isHidden = true

    }

//    func inserCellByDate(dateStr:String) {
//   
//        let brDate = BRItem()
//        brDate.date = self.datefromString(dateStr: dateStr)
//        
//        self.brItems.append(brDate)
//        let indexPath = IndexPath(row: (self.brItems.count - 1 ), section: 0)
//        self.collectionView.insertItems(at: [indexPath])
//    }
//    
//    func inserCellByBRItem(brItem:BRItem) {
//        
//        self.brItems.append(brItem)
//        let indexPath = IndexPath(row: (self.brItems.count - 1 ), section: 0)
//        self.collectionView.insertItems(at: [indexPath])
//    }
//
//    func inserCellByBRItemAtFirst(brItem:BRItem) {
//        
//        self.brItems.insert(brItem, at: 0)
//        let indexPath = IndexPath(row:0, section: 0)
//        self.collectionView.insertItems(at: [indexPath])
//    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func startOfWeek() -> Date{
        
        let currentDate = Date()
       // print("currentDate:\(currentDate)")
        
        let date = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
        let dslTimeOffset = NSTimeZone.local.daylightSavingTimeOffset(for: date) + 24
        let startDateOfweek = date.addingTimeInterval(dslTimeOffset)


        return startDateOfweek
        
    }
    
    func endOfWeek() -> Date {
        
        return Calendar.current.date(byAdding: .second, value: 60*60*24*7, to: self.startOfWeek())!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func reload(_ sender: UIButton) {
        self.tf1.resignFirstResponder()
        self.tf2.resignFirstResponder()
        
        let num1Str = self.tf1.text!
        
        let tf1Num:Int32 = Int32(num1Str)!

        let tf2Num:Int32 = Int32(self.tf2.text!)!
        
        self.renderTimerLine(num1: tf1Num, num2: tf2Num)
    }
    
    func renderTimerLine(num1:Int32, num2:Int32) {
        
        self.allBrItemsForCell.removeAll()
        //var brItems:[BRItem?] = []
        var allBrItems:[BRItem?] = []
        var currentCellPatternCount = 0;
        var chunkCounter = 0;
        var currentCellPattern:CellRegularPattern = .before_pattern_7e_1c
        
        print("all dates start")
        //exceptionn -> 14 ~ 20, 5~11
        
        var futureCount = 0
        //future
        for intervalDay in stride(from: abs(num1), through: 1, by: -1) {
            
            let date = Date(timeIntervalSinceNow: TimeInterval(60*60*24*intervalDay))
            let brItem = BRItem()
            brItem.date = date
            allBrItems.append(brItem)
            
            futureCount += 1
            //The last date should have at least one testItem
            if futureCount == 1 {
                let testItem = ViewController.mkRandomTestItem()
                brItem.testItems = []
                brItem.addTestItem(testItem: testItem)
            }
        }
        
        var beforeCount:Int32 = 0
        //before
        //exceptionn -> -5 ~ -11, -23 ~ -29
        for intervalDay in stride(from: 0, through: -abs(num2), by: -1) {
            
            let date = Date(timeIntervalSinceNow: TimeInterval(60*60*24*intervalDay))
            let brItem = BRItem()
            brItem.date = date
            allBrItems.append(brItem)
            
            //Thre first date should have at least one testItem
            if beforeCount == num2 {
                let testItem = ViewController.mkRandomTestItem()
                brItem.testItems = []
                brItem.addTestItem(testItem: testItem)
            }
            beforeCount += 1
        }
        
        print("startOfWeek:\(self.startOfWeek())")
        print("endOfWeek:\(self.endOfWeek())")
        
        var first7DateOfThisWeekCount = 0
        var firstDateOfThisWeek:Date? = nil
        var lastDateOfThisWeek:Date? = nil
       
        var futureBrItems:[BRItem?] = []
        var beforeBrItems:[BRItem?] = []
   
        
        var allBrItemsReduceEmpty:[BRItem?] = []
        
        var isEmptyHappen = false
        for (_, brItem ) in allBrItems.enumerated() {
            
            let dateChk = brItem?.date
            let fallsBetween = (self.startOfWeek()...self.endOfWeek()).contains(dateChk!)
            if fallsBetween {
                allBrItemsReduceEmpty.append(brItem)
                continue
            }
            
            let testItemsCount = brItem?.testItems.count
            if testItemsCount! > 0 {
                
                isEmptyHappen = false
                allBrItemsReduceEmpty.append(brItem)
            } else {
                if isEmptyHappen {
                    continue
                }
                isEmptyHappen = true
                allBrItemsReduceEmpty.append(brItem)
            }
        }
        
        var allBrItemsLoopCount = allBrItemsReduceEmpty.count
        for (_, brItem ) in allBrItemsReduceEmpty.enumerated() {
            
            allBrItemsLoopCount -= 1
            
            if let dateChk = brItem?.date
            {

                let fallsBetween = (self.startOfWeek()...self.endOfWeek()).contains(dateChk)
                
                if lastDateOfThisWeek == nil
                    && !fallsBetween {
                    //after this week
                    futureBrItems.append(brItem)
                    continue
                    //print("future: \(year)-\(month)-\(day)(\(weekDay))")
                }
                
                if(fallsBetween
                    && first7DateOfThisWeekCount < 7){
                    first7DateOfThisWeekCount += 1
                    if first7DateOfThisWeekCount == 1 {
                        
                        let brItemVerticleLeft  = self.mkNoDateBrItem(.bottomLeft)
                        self.allBrItemsForCell.insert(brItemVerticleLeft, at: 0)
                
                        lastDateOfThisWeek = brItem?.date
                        brItem?.cellGuildLine = .horizontal
                    } else if first7DateOfThisWeekCount == 7 {
                        firstDateOfThisWeek = brItem?.date
                        brItem?.cellGuildLine  = .horizontal
                    } else {
                        brItem?.cellGuildLine  = .horizontal
                    }
                    //print("first rows date:\(dateChk)")
                    ///process current week first
              
                    self.allBrItemsForCell.append(brItem)
                    
                    if first7DateOfThisWeekCount == 7 {
                        let brItemVerticleRight  = self.mkNoDateBrItem(.topRight)
                        self.allBrItemsForCell.append(brItemVerticleRight)
                    }
                   
              
                    continue
                }
                
                if(firstDateOfThisWeek != nil
                    && firstDateOfThisWeek! > (brItem?.date)!){
                    //before this week
                    beforeBrItems.append(brItem);
                }

            
            }
            
        }

        print("all dates end")
        for (_, brItem ) in futureBrItems.enumerated() {
            guard let date = brItem?.date else {
                continue;
            }
            let dateStr = self.formatLocalDate("after current week date: ", date)
            let testItemCount = brItem?.testItems.count
            print("\(dateStr) count:\(testItemCount!)")
        }
 
//        for (_, brItem ) in self.allBrItemsForCell.enumerated() {
//            
//            guard let date = brItem?.date else {
//                continue;
//            }
//            let dateStr = self.formatLocalDate("current week date: ", date)
//            let testItemCount = brItem?.testItems.count
//            print("\(dateStr) count:\(testItemCount!)")
//        }
        
     
//        for (_, brItem ) in beforeBrItems.enumerated() {
//            guard let date = brItem?.date else {
//                continue;
//            }
//            
//            let dateStr = self.formatLocalDate("before current week date: ", date)
//            let testItemCount = brItem?.testItems.count
//            print("\(dateStr) count:\(testItemCount!)")
//        }
        
        
        var beforeBrItemsPerChunkG = beforeBrItems.chunk(8).makeIterator()
        let modBeforeBrItems = beforeBrItems.count / 8
        
        var groupIndex = 0
        while let beforeBrItemsPerChunk = beforeBrItemsPerChunkG.next() {
            
            var emptyRowIsR:Bool = true
            var beforeBrItemsPerChunkReOrder:[BRItem?] = []
            let beforeBrItemsPerChunkCount = beforeBrItemsPerChunk.count
            let notEnough = 8 - beforeBrItemsPerChunkCount
       
            //reverse
            if groupIndex % 2 == 0 {
                emptyRowIsR = true
                beforeBrItemsPerChunkReOrder = beforeBrItemsPerChunk.reversed()
                
                //insert before array for the 8 date cell in row
                if(notEnough > 0){
                    
                    for _ in stride(from: 1, through: notEnough, by: 1) {
                        let brItem = self.mkNoDateBrItem(.none)
                      beforeBrItemsPerChunkReOrder.insert(brItem, at: 0)
                    }
                }
            //normal
            } else {
                emptyRowIsR = false
                beforeBrItemsPerChunkReOrder = beforeBrItemsPerChunk
                
                //insert after array for the 8 date cell in row
                if(notEnough > 0){
                    for _ in stride(from: 1, through: notEnough, by: 1) {
                        let brItem = self.mkNoDateBrItem(.none)
                        beforeBrItemsPerChunkReOrder.append(brItem)
                    }
                }
            }
            let emptyRowR = self.mkEmptyRowBrItems(isRightVertical: emptyRowIsR)
            self.allBrItemsForCell += emptyRowR
            let beforeBrItemsPerChunkReOrderCount = beforeBrItemsPerChunkReOrder.count
            var notEmptyRow:[BRItem?] = []
            for (idx, brItem ) in beforeBrItemsPerChunkReOrder.enumerated() {
                
                if(brItem?.cellGuildLine == nil) {
                    brItem?.cellGuildLine = .horizontal
                }
                notEmptyRow.append(brItem)
                
                //reverse
                if groupIndex % 2 == 0 {
                    if idx == 0 {
                        let brItem = self.mkNoDateBrItem(.topLeft)
                        //the last row
                        if(groupIndex == modBeforeBrItems) {
                            brItem.cellGuildLine = .none
                        }
                        notEmptyRow.insert(brItem, at: 0)
                    }
                    
                    if idx == (beforeBrItemsPerChunkReOrderCount - 1) {
                        let brItem = self.mkNoDateBrItem(.bottomRight)
                        notEmptyRow.append(brItem)
                    }
                    
                    //not reverse
                } else {
                    if idx == 0 {
                        let brItem = self.mkNoDateBrItem(.bottomLeft)
                    
                        notEmptyRow.insert(brItem, at: 0)
                    }
                    
                    if idx == (beforeBrItemsPerChunkReOrderCount - 1) {
                        let brItem = self.mkNoDateBrItem(.topRight)
                        //the last row
                        if(groupIndex == modBeforeBrItems) {
                            brItem.cellGuildLine = .none
                        }
                        notEmptyRow.append(brItem)
                    }
                    
                }
            
//                if brItem?.date != nil {
//                    
//                    let celStr = self.formatLocalDate("before current week date groupIndex:\(groupIndex): ", (brItem?.date!)!)
//                    let testItemCount = brItem?.testItems.count
//                    print("\(celStr) count:\(testItemCount!)")
//                
//                } else {
//                    print("before current week date groupIndex:\(groupIndex):  empty guid:\(brItem?.cellGuildLine)" )
//                }
                
            }
            self.allBrItemsForCell += notEmptyRow
            
            groupIndex += 1
        }

        let futureBrItemsReverse = futureBrItems.reversed()
        var futureBrItemsReversePerChunkG = futureBrItemsReverse.chunk(8).makeIterator()
        let modfutureBrItemsReverse = futureBrItemsReverse.count / 8
        
        var groupIndexFuture = 0
        
        while let futureBrItemsReversePerChunk = futureBrItemsReversePerChunkG.next() {
            var emptyRowIsR:Bool = true
            var futureBrItemsPerChunkReOrder:[BRItem?] = []
            let futureBrItemsPerChunkCount = futureBrItemsReversePerChunk.count
            let notEnough = 8 - futureBrItemsPerChunkCount
            
            
             //normal
            if groupIndexFuture % 2 == 0 {
                emptyRowIsR = false
                futureBrItemsPerChunkReOrder = futureBrItemsReversePerChunk
                
                //insert after array for the 8 date cell in row
                if(notEnough > 0){
                    for _ in stride(from: 1, through: notEnough, by: 1) {
                        let brItem = self.mkNoDateBrItem(.none)
                        futureBrItemsPerChunkReOrder.append(brItem)
                    }
                }
            //reverse
            } else {
                emptyRowIsR = true
                futureBrItemsPerChunkReOrder = futureBrItemsReversePerChunk.reversed()
                
                //insert before array for the 8 date cell in row
                if(notEnough > 0){
                    for _ in stride(from: 1, through: notEnough, by: 1) {
                        let brItem = self.mkNoDateBrItem(.none)
                        futureBrItemsPerChunkReOrder.insert(brItem, at: 0)
                    }
                }
            
            }
            let emptyRowR = self.mkEmptyRowBrItems(isRightVertical: emptyRowIsR)
            self.allBrItemsForCell.insert(contentsOf: emptyRowR, at: 0)
            
            let futureBrItemsPerChunkReOrderCount = futureBrItemsPerChunkReOrder.count
            var notEmptyRow:[BRItem?] = []
            for (idx, brItem ) in futureBrItemsPerChunkReOrder.enumerated() {
                
                if(brItem?.cellGuildLine == nil) {
                    brItem?.cellGuildLine = .horizontal
                }
                notEmptyRow.append(brItem)
                
                //normal
                if groupIndexFuture % 2 == 0 {
                    if idx == 0 {
                        let brItem = self.mkNoDateBrItem(.topLeft)

                        notEmptyRow.insert(brItem, at: 0)
                    }
                    
                    if idx == (futureBrItemsPerChunkReOrderCount - 1) {
                        let brItem = self.mkNoDateBrItem(.bottomRight)
                        //the last row
                        if(groupIndexFuture == modfutureBrItemsReverse) {
                            brItem.cellGuildLine = .none
                        }
                        notEmptyRow.append(brItem)
                    }
                    
                //reverse
                } else {
                    if idx == 0 {
                        let brItem = self.mkNoDateBrItem(.bottomLeft)
                        //the last row
                        if(groupIndexFuture == modfutureBrItemsReverse) {
                            brItem.cellGuildLine = .none
                        }
                        notEmptyRow.insert(brItem, at: 0)
                    }
                    
                    if idx == (futureBrItemsPerChunkReOrderCount - 1) {
                        let brItem = self.mkNoDateBrItem(.topRight)
                        //the last row
                        if(groupIndex == modfutureBrItemsReverse) {
                            brItem.cellGuildLine = .none
                        }
                        notEmptyRow.append(brItem)
                    }
                    
                }
                
//                if brItem?.date != nil {
//
//                    let celStr = self.formatLocalDate("before current week date groupIndex:\(groupIndex): ", (brItem?.date!)!)
//                    let testItemCount = brItem?.testItems.count
//                    print("\(celStr) count:\(testItemCount!)")
//
//                } else {
//                    print("before current week date groupIndex:\(groupIndex):  empty guid:\(brItem?.cellGuildLine)" )
//                }
                
            }
            self.allBrItemsForCell.insert(contentsOf: notEmptyRow, at: 0)
            groupIndexFuture += 1
            
        }
        
        //最後補上一列空白的，修正原本最右下角cell，位置偏差
        for _ in stride(from: 1, through: self.numberOfColumns, by: 1) {
            let brItem = BRItem()
            brItem.cellGuildLine = .none
            self.allBrItemsForCell.append(brItem)
        }
        
        for (_ , brItem) in self.allBrItemsForCell.enumerated() {
           brItem?.reOrderTestItems(currentLoginAccount: "peter@bonraybio.com");
        }
        self.collectionView.reloadData()
        //(self.allBrItemsForCell.count - 1)
        
    }

    @IBAction func scrollToTop(_ sender: Any) {
        
        
        let indexPath = IndexPath(row: 0, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
    }
    
    @IBAction func scrollTobottom(_ sender: Any) {
        
        let indexPath = IndexPath(row: (self.allBrItemsForCell.count - 1), section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    
    static func mkRandomTestItem() -> TestItem {
    
        let testItem = TestItem()
        testItem.account = "peter@bonraybio.com"
        testItem.type = TestItemType.random()
        
        let random = arc4random_uniform(11) + 5;
        if random == 5
            ||  random == 6
            ||  random == 7
            ||  random == 8
            ||  random == 9
            ||  random == 10
            ||  random == 11{
            
            if testItem.type == .Sperm {
                
                testItem.sperm_motility = 0.1
                testItem.sperm_morpphology = 0.2
                testItem.sperm_concentration = 0.3
                
            } else if (testItem.type == .Mating
                || testItem.type == .Temperature
                ) {
                
                if(testItem.type == .Temperature){
                    testItem.account = "mary@bonraybio.com"
                }
              
                let randomNum = arc4random_uniform(3)
                if(randomNum == 0){
                    testItem.value = 1
                } else {
                    testItem.value = 0
                }
            } else {
                testItem.account = "mary@bonraybio.com"
                testItem.value = 0.8
            }
        }
        
        
        
        return testItem
    }
    

    func formatLocalDate(_ prepend:String,  _ date: Date) -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let weekDay = calendar.component(.weekday, from: date)
        let formatDateStr = "\(prepend): \(year)-\(month)-\(day)(\(weekDay))"
        return formatDateStr
    
    }
    

    
    func mkNoDateBrItem(_ cellGuildLine: CellGuildLine) -> BRItem {
        
        let brItem  = BRItem()
        brItem.cellGuildLine = cellGuildLine
        return brItem
    }
    
    func mkEmptyRowBrItems( isRightVertical:Bool) -> [BRItem?] {
        
        var brItems:[BRItem?] = []
        var count:CGFloat = 0
        for _ in stride(from: 1, through: self.numberOfColumns, by: 1) {
            count += 1
            
            let brItem = BRItem()
            var verticalIndex:CGFloat = 0
            if isRightVertical {
                verticalIndex = self.numberOfColumns
            } else {
                verticalIndex = 1
            }
            
            if(count == verticalIndex){
                brItem.cellGuildLine = .vertical
            } else {
                brItem.cellGuildLine = .none
            }
            brItems.append(brItem)
        }
        return brItems
    }

}


public struct ChunkIterator<I: IteratorProtocol> : IteratorProtocol {
    
    fileprivate var i: I
    fileprivate let n: Int
    
    public mutating func next() -> [I.Element]? {
        guard let head = i.next() else { return nil }
        var build = [head]
        build.reserveCapacity(n)
        for _ in (1..<n) {
            guard let x = i.next() else { break }
            build.append(x)
        }
        return build
    }
    
}

public struct ChunkSeq<S: Sequence> : Sequence {
    
    fileprivate let seq: S
    fileprivate let n: Int
    
    public func makeIterator() -> ChunkIterator<S.Iterator> {
        return ChunkIterator(i: seq.makeIterator(), n: n)
    }
}

public extension Sequence {
    func chunk(_ n: Int) -> ChunkSeq<Self> {
        return ChunkSeq(seq: self, n: n)
    }
}
