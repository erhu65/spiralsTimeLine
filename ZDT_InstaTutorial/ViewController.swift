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
    var type:TestItemType = TestItemType.random()
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
    }
    
    func addTestItem(testItem:TestItem) {
        testItems.append(testItem)
    }
    
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
UITextFieldDelegate{

    @IBOutlet weak var popV: UIView!
    @IBOutlet weak var popLb: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!

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
        let numberOfColumns: CGFloat = 8
        
        var itemWidth = (self.collectionView!.frame.width - (numberOfColumns)) / numberOfColumns
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
            cell.brItem = nil
            cell.serialLb.text = "\(indexPath.row)"
            return cell
        }
   
        //let imageName = (indexPath.row % 2 == 0) ? "image1" : "image2"
     
        
//        guard let testItemIndex = testCellIndexItemIndexMapping[rowIndex]
//            else {
//                
//            cell.contentView.isHidden = true
//            return cell
//        }
//        cell.contentView.isHidden = false
//        
//        cell.serialLb.text = "\(indexPath.row):\(testItemIndex)"
//
//        
//        if indexPath.row % 2 == 0 {
//            cell.contentView.backgroundColor = UIColor.blue
//        } else {
//            cell.contentView.backgroundColor = UIColor.darkGray
//        }
//        
//        
//        if rowIndex == 68 {
//            
//            return cellCurrent
//        }
//        
//        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let rowIndex = indexPath.row
        let barItem = self.allBrItemsForCell[rowIndex]
        
        guard let _ = barItem?.date else {
        
            return;
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
            switch testItem.type {
                
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
        
        testValStrs.append("serial: \(String(describing: barItem?.serial))")
        
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
        chunkCounter = 0
        var circle8_tmpBrItems:[BRItem?] = []
        var futureBrItems:[BRItem?] = []
        
        var tailFutureBrItems:[BRItem?] = []
        
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
                let calendar = Calendar.current
                let year = calendar.component(.year, from: dateChk)
                let month = calendar.component(.month, from: dateChk)
                let day = calendar.component(.day, from: dateChk)
                let weekDay = calendar.component(.weekday, from: dateChk)
                
                let fallsBetween = (self.startOfWeek()...self.endOfWeek()).contains(dateChk)
                
                if lastDateOfThisWeek == nil
                    && !fallsBetween {
                    futureBrItems.append(brItem)
                    continue
                    //print("future: \(year)-\(month)-\(day)(\(weekDay))")
                }
                
                if(fallsBetween
                    && first7DateOfThisWeekCount < 7){
                    
                    first7DateOfThisWeekCount += 1
                    if first7DateOfThisWeekCount == 1 {
                        lastDateOfThisWeek = brItem?.date
                        brItem?.cellGuildLine = .bottomLeft
                    } else if first7DateOfThisWeekCount == 7 {
                        firstDateOfThisWeek = brItem?.date
                        brItem?.cellGuildLine  = .topRight
                    } else {
                        brItem?.cellGuildLine  = .horizontal
                    }
                    
                    //print("first rows date:\(dateChk)")
                    self.allBrItemsForCell.append(brItem)
                    continue
                }
                
                if(firstDateOfThisWeek != nil
                    && firstDateOfThisWeek! > (brItem?.date)!){
                    
                    print("before: \(year)-\(month)-\(day)(\(weekDay))")
                    
                    switch currentCellPattern {
                    case .before_pattern_7e_1c:
                        currentCellPatternCount = 7
                        for _ in stride(from: 1, through: 7, by: 1) {
                            let brItem = BRItem()
                            brItem.cellGuildLine = .none
                            self.allBrItemsForCell.append(brItem);
                            chunkCounter  += 1
                            
                        }
                        if(currentCellPatternCount == chunkCounter) {
                            //tmpBrItems.append(brItem)
                            brItem?.cellGuildLine = .vertical
                            self.allBrItemsForCell.append(brItem);
                            chunkCounter = 0
                            currentCellPattern = .before_pattern_8c
                        }
                    case .before_pattern_8c:
                        
                        currentCellPatternCount = 8
                        circle8_tmpBrItems.append(brItem)
                        chunkCounter  += 1
                        
                        if(currentCellPatternCount == chunkCounter) {
                            let tmpBrItemsReverse = circle8_tmpBrItems.reversed()
                            for obj in tmpBrItemsReverse.enumerated() {
                                if obj.offset == 0 {
                                    if allBrItemsLoopCount == 0 {
                                        obj.element?.cellGuildLine = .horizontal
                                    } else {
                                        obj.element?.cellGuildLine = .topLeft
                                    }
                                    
                                } else if obj.offset == 7  {
                                    obj.element?.cellGuildLine  = .bottomRight
                                } else {
                                    obj.element?.cellGuildLine  = .horizontal
                                }
                                self.allBrItemsForCell.append(obj.element)
                            }
                            
                            chunkCounter = 0
                            currentCellPattern = .before_pattern_1c_L
                            circle8_tmpBrItems = []
                        }
                        
                    case .before_pattern_1c_L:
                        
                        currentCellPatternCount = 1
                        brItem?.cellGuildLine = .vertical
                        self.allBrItemsForCell.append(brItem);
                        chunkCounter  += 1
                        if(currentCellPatternCount == chunkCounter) {
                            chunkCounter = 0
                            currentCellPattern = .before_pattern_empty7_2
                        }
                    case .before_pattern_empty7_2:
                        
                        currentCellPatternCount = 7
                        for _ in stride(from: 1, through: 7, by: 1) {
                            let brItem = BRItem()
                            brItem.cellGuildLine = .horizontal
                            self.allBrItemsForCell.append(brItem);
                            chunkCounter  += 1
                            
                        }
                        if(currentCellPatternCount == chunkCounter) {
                            chunkCounter = 0
                            currentCellPattern = .before_pattern_circle8_2
                            
                            if allBrItemsLoopCount == 0 {
                                brItem?.cellGuildLine = .vertical
                            } else {
                                brItem?.cellGuildLine = .bottomLeft
                            }
                            
                            self.allBrItemsForCell.append(brItem)
                            chunkCounter  += 1
                        }
                    case .before_pattern_circle8_2:
                        currentCellPatternCount = 8
                        chunkCounter  += 1
                        self.allBrItemsForCell.append(brItem)
                        if chunkCounter == 8 {
                            if allBrItemsLoopCount == 0 {
                                brItem?.cellGuildLine = .horizontal
                            } else {
                                brItem?.cellGuildLine = .topRight
                            }
                        } else {
                            brItem?.cellGuildLine = .horizontal
                        }
                        if(currentCellPatternCount == chunkCounter) {
                            chunkCounter = 0
                            currentCellPattern = .before_pattern_7e_1c
                            
                        }
                    default:
                        continue
                        
                    }
                    
                }
                
                
            }
            
        }
        
        //process circle8 not enough
        if circle8_tmpBrItems.count > 0 {
            let paddLeft = 8 - circle8_tmpBrItems.count
            
            for _ in stride(from: 1, through: paddLeft, by: 1) {
                let brItem = BRItem()
                brItem.cellGuildLine = .none
                self.allBrItemsForCell.append(brItem);
            }
            
            let tmpBrItemsReverse = circle8_tmpBrItems.reversed()
            for obj in tmpBrItemsReverse.enumerated() {
                
                if tmpBrItemsReverse.count == 1 {
                    obj.element?.cellGuildLine = .vertical
                } else  {
                    
                    if obj.offset == (tmpBrItemsReverse.count - 1) {
                        obj.element?.cellGuildLine  = .bottomRight
                    } else {
                        obj.element?.cellGuildLine  = .horizontal
                    }
                }
                
                self.allBrItemsForCell.append(obj.element)
            }
            circle8_tmpBrItems = []
        }
        
        print("all dates end")
        
        let futureBrItemsReverse:[BRItem?] = futureBrItems.reversed()
        for (_ , brItem) in futureBrItemsReverse.enumerated() {
            
            if let date = brItem?.date {
                let calendar = Calendar.current
                let year = calendar.component(.year, from: date)
                let month = calendar.component(.month, from: date)
                let day = calendar.component(.day, from: date)
                let weekDay = calendar.component(.weekday, from: date)
                print("future: \(year)-\(month)-\(day)(\(weekDay))")
            }
            //self.allBrItemsForCell.insert(brItem, at: 0);
            //self.inserCellByBRItemAtFirst(brItem: brItem!)
        }
        
        var future_pattern_currentCellPattern:CellRegularPattern = .future_pattern_7e_1c
        var future_pattern_chunkCounter = 0;
        var future_pattern_8c_reverse_tmpBrItems:[BRItem?] = [];
        var future_pattern_8c_not_enough_tmpBrItems:[BRItem?] = [];
        
        if futureBrItemsReverse.count > 0 {
            let futureBrItemsReverseCount = futureBrItemsReverse.count
            var futureBrItemsReverseCountLeft = futureBrItemsReverseCount
            
            for (_, barItemFutrue) in futureBrItemsReverse.enumerated() {
                
                switch future_pattern_currentCellPattern  {
                case .future_pattern_7e_1c:
                    for _ in stride(from: 1, through: 7, by: 1) {
                        let brItem = BRItem()
                        brItem.cellGuildLine = .none
                        future_pattern_chunkCounter += 1
                        self.allBrItemsForCell.insert(brItem, at: 0)
                    }
                    
                    future_pattern_chunkCounter += 1
                    futureBrItemsReverseCountLeft -= 1
                    barItemFutrue?.cellGuildLine = .vertical
                    self.allBrItemsForCell.insert(barItemFutrue!, at: 0)
                    if future_pattern_chunkCounter == 8 {
                        
                        future_pattern_chunkCounter = 0
                        future_pattern_8c_reverse_tmpBrItems = []
                        
                        future_pattern_currentCellPattern = .future_pattern_8c_reverse
                    }
                case .future_pattern_8c_reverse:
                    future_pattern_chunkCounter += 1
                    future_pattern_8c_reverse_tmpBrItems.append(barItemFutrue)
                    
                    if future_pattern_chunkCounter == 8 {
                        
                        let reverse_tmpBrItems_reverse:[BRItem?] = future_pattern_8c_reverse_tmpBrItems.reversed()
                        for (idx, brItme) in reverse_tmpBrItems_reverse.enumerated() {
                            futureBrItemsReverseCountLeft -= 1
                            if idx == 0 {
                                brItme?.cellGuildLine = .bottomRight
                                
                            } else if idx == (reverse_tmpBrItems_reverse.count - 1){
                                brItme?.cellGuildLine = .topLeft
                            } else {
                                brItme?.cellGuildLine = .horizontal
                            }
                            
                            self.allBrItemsForCell.insert(brItme, at: 0)
                        }
                        future_pattern_chunkCounter = 0
                        future_pattern_currentCellPattern = .future_pattern_1c_7e
                        future_pattern_8c_reverse_tmpBrItems = []
                        
                    }
                    
                case .future_pattern_1c_7e:
                    future_pattern_chunkCounter += 1
                    futureBrItemsReverseCountLeft -= 1
                    barItemFutrue?.cellGuildLine = .vertical
                    self.allBrItemsForCell.insert(barItemFutrue!, at: 0)
                    
                    for _ in stride(from: 1, through: 7, by: 1) {
                        let brItem = BRItem()
                        brItem.cellGuildLine = .horizontal
                        future_pattern_chunkCounter += 1
                        self.allBrItemsForCell.insert(brItem, at: 0)
                    }
                    
                    if future_pattern_chunkCounter == 8 {
                        if(futureBrItemsReverseCountLeft > 0
                            && futureBrItemsReverseCountLeft < 8){
                            
                            future_pattern_currentCellPattern = .future_pattern_8c_not_enough
                            future_pattern_8c_not_enough_tmpBrItems = []
                        } else {
                            future_pattern_chunkCounter = 0
                            future_pattern_currentCellPattern = .future_pattern_8c
                        }
                    }
                case .future_pattern_8c_not_enough:
                    future_pattern_8c_not_enough_tmpBrItems.append(barItemFutrue)
                case .future_pattern_8c:
                    future_pattern_chunkCounter += 1
                    futureBrItemsReverseCountLeft -= 1
                    
                    if future_pattern_chunkCounter == 1 {
                        barItemFutrue?.cellGuildLine = .topRight
                    } else {
                        
                        if future_pattern_chunkCounter == 8 {
                            barItemFutrue?.cellGuildLine = .bottomLeft
                        } else {
                            barItemFutrue?.cellGuildLine = .horizontal
                        }
                        
                    }
                    
                    self.allBrItemsForCell.insert(barItemFutrue!, at: 0)
                    
                    if future_pattern_chunkCounter == 8 {
                        
                        future_pattern_chunkCounter = 0
                        if futureBrItemsReverseCountLeft > 24 {
                            future_pattern_currentCellPattern = .future_pattern_7e_1c
                            
                        } else {
                            for _ in stride(from: 1, through: 64, by: 1) {
                                let brItem = BRItem()
                                brItem.cellGuildLine = .horizontal
                                future_pattern_chunkCounter += 1
                                self.allBrItemsForCell.insert(brItem, at: 0)
                            }
                            future_pattern_currentCellPattern = .future_pattern_end
                            //reverse_currentCellPattern = .tail_7e_1c
                        }
                    }
                case .future_pattern_end:
                    tailFutureBrItems.append(barItemFutrue)
                default:
                    continue
                }
            }
            
        }
        
        //process exceptionn ->  14 ~ 20
        if future_pattern_8c_not_enough_tmpBrItems.count > 0 {
            
            for obj in future_pattern_8c_not_enough_tmpBrItems.enumerated() {
                
                if obj.offset == 0 {
                    if future_pattern_8c_not_enough_tmpBrItems.count > 1 {
                        obj.element?.cellGuildLine = .topRight
                    } else {
                        obj.element?.cellGuildLine = .vertical
                    }
                    
                } else {
                    obj.element?.cellGuildLine  = .horizontal
                }
                self.allBrItemsForCell.insert(obj.element, at: 0);
            }
            
            let paddLeft = 8 - future_pattern_8c_not_enough_tmpBrItems.count
            
            for _ in stride(from: 1, through: paddLeft, by: 1) {
                let brItem = BRItem()
                brItem.cellGuildLine = .none
                self.allBrItemsForCell.insert(brItem, at: 0);
            }
            
            future_pattern_8c_not_enough_tmpBrItems = []
            
        }
        
        if future_pattern_8c_reverse_tmpBrItems.count > 0 {
            let paddLeft = 8 - future_pattern_8c_reverse_tmpBrItems.count
            
            for _ in stride(from: 1, through: paddLeft, by: 1) {
                let brItem = BRItem()
                brItem.cellGuildLine = .none
                self.allBrItemsForCell.insert(brItem, at: 0);
            }
            let future_pattern_8c_reverse_tmpBrItems_reverse:[BRItem?] = future_pattern_8c_reverse_tmpBrItems.reversed()
            for obj in future_pattern_8c_reverse_tmpBrItems_reverse.enumerated() {
                
                if obj.offset == (future_pattern_8c_reverse_tmpBrItems_reverse.count - 1) {
                    obj.element?.cellGuildLine = .topLeft
                } else {
                    obj.element?.cellGuildLine  = .horizontal
                }
                self.allBrItemsForCell.insert(obj.element, at: 0);
            }
            future_pattern_8c_reverse_tmpBrItems = []
            
        }
        
        var tailFutureBrItemsCount = tailFutureBrItems.count
        
        for (idx , brItem) in tailFutureBrItems.enumerated() {
            
            tailFutureBrItemsCount -= 1
            
            switch idx {
            case 0:
                let barItemPrevious = self.allBrItemsForCell[64]
                barItemPrevious?.cellGuildLine = .bottomLeft
                brItem?.cellGuildLine = .vertical
                self.allBrItemsForCell[56] = brItem
            case 1:
                if tailFutureBrItemsCount == 0 {
                    brItem?.cellGuildLine = .vertical
                } else {
                    brItem?.cellGuildLine = .topLeft
                }
                self.allBrItemsForCell[48] = brItem
            case 2:
                brItem?.cellGuildLine = .horizontal
                self.allBrItemsForCell[49] = brItem
            case 3:
                brItem?.cellGuildLine = .horizontal
                self.allBrItemsForCell[50] = brItem
            case 4:
                brItem?.cellGuildLine = .horizontal
                self.allBrItemsForCell[51] = brItem
            case 5:
                brItem?.cellGuildLine = .horizontal
                self.allBrItemsForCell[52] = brItem
            case 6:
                brItem?.cellGuildLine = .horizontal
                self.allBrItemsForCell[53] = brItem
            case 7:
                if tailFutureBrItemsCount == 0 {
                    brItem?.cellGuildLine = .horizontal
                } else {
                    brItem?.cellGuildLine = .bottomRight
                }
                
                self.allBrItemsForCell[54] = brItem
            case 8:
                brItem?.cellGuildLine = .vertical
                self.allBrItemsForCell[46] = brItem
            case 9:
                if tailFutureBrItemsCount == 0 {
                    brItem?.cellGuildLine = .vertical
                } else {
                    brItem?.cellGuildLine = .topRight
                }
                self.allBrItemsForCell[38] = brItem
            case 10:
                brItem?.cellGuildLine = .horizontal
                self.allBrItemsForCell[37] = brItem
            case 11:
                brItem?.cellGuildLine = .horizontal
                self.allBrItemsForCell[36] = brItem
            case 12:
                brItem?.cellGuildLine = .horizontal
                self.allBrItemsForCell[35] = brItem
            case 13:
                brItem?.cellGuildLine = .horizontal
                self.allBrItemsForCell[34] = brItem
            case 14:
                if tailFutureBrItemsCount == 0 {
                    brItem?.cellGuildLine = .horizontal
                } else {
                    brItem?.cellGuildLine = .bottomLeft
                }
                self.allBrItemsForCell[33] = brItem
            case 15:
                brItem?.cellGuildLine = .vertical
                self.allBrItemsForCell[25] = brItem
            case 16:
                if tailFutureBrItemsCount == 0 {
                    brItem?.cellGuildLine = .vertical
                } else {
                    brItem?.cellGuildLine = .topLeft
                }
                self.allBrItemsForCell[17] = brItem
            case 17:
                brItem?.cellGuildLine = .horizontal
                self.allBrItemsForCell[18] = brItem
            case 18:
                brItem?.cellGuildLine = .horizontal
                self.allBrItemsForCell[19] = brItem
            case 19:
                brItem?.cellGuildLine = .horizontal
                self.allBrItemsForCell[20] = brItem
            case 20:
                if tailFutureBrItemsCount == 0 {
                    brItem?.cellGuildLine = .horizontal
                } else {
                    brItem?.cellGuildLine = .bottomRight
                }
                self.allBrItemsForCell[21] = brItem
            case 21:
                brItem?.cellGuildLine = .vertical
                self.allBrItemsForCell[13] = brItem
            case 22:
                if tailFutureBrItemsCount == 0 {
                    brItem?.cellGuildLine = .vertical
                } else {
                    brItem?.cellGuildLine = .topRight
                }
                self.allBrItemsForCell[5] = brItem
            case 23:
                brItem?.cellGuildLine = .horizontal
                self.allBrItemsForCell[4] = brItem
            default:
                continue
            }
            
        }
        
        //補上一列空白的，修正原本最右下角cell，位置偏差
        for _ in stride(from: 1, through: 8, by: 1) {
            let brItem = BRItem()
            brItem.cellGuildLine = .none
            self.allBrItemsForCell.append(brItem)
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
                
            } else if (testItem.type == .Mating) {
                testItem.value = 1
            } else {
                testItem.value = 0.8
            }
        }

        
        return testItem
    }
    

    
}
