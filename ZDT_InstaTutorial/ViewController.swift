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
    case empty7right1
    case circle1Right
    case circle8
    case circle1Left
    case empty7_2
    case circle8_2
}

enum TestItemResult: UInt32 {
    case Pass
    case Failed
    case NotDo
    
    private static let _count: TestItemResult.RawValue = {
        // find the maximum enum value
        var maxValue: UInt32 = 0
        while let _ = TestItemResult(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    static func random() -> TestItemResult {
        // pick and return a new value
        let rand = arc4random_uniform(_count)
        return TestItemResult(rawValue: rand)!
    }
}

class TestItem {
    var result:TestItemResult = .NotDo
    var date:Date? = nil
}

class BRItem {
    var index:Int = -1
    var serial:Int = -1
    var testItems:[TestItem] = []
    var date:Date? = nil
    var cellGuildLine:CellGuildLine?
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var brItems:[BRItem?] = []
    var allBrItems:[BRItem?] = []
    var allBrItemsForCell:[BRItem?] = []
    var testCellIndexItemIndexMapping:[Int:Int] = [:]
    var currentCellPatternCount = 0;
    var chunkCounter = 0;
    var currentCellPattern:CellRegularPattern = .empty7right1
    var maxCellIndex = 0;
    
    var collectionViewLayout: CustomImageFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewLayout = CustomImageFlowLayout()
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
//        let topIndexPadding = 108;
//        for serail in stride(from: 0, through: 180, by: 1) {
//            let testItem = TestItem()
//            testItem.serial = Int(serail)
//            testItem.index = Int(serail)
//            switch TestItemResult.random() {
//            case .Pass:
//                testItem.result = .Pass
//            case .Failed:
//                testItem.result = .Failed
//            case .NotDo:
//                testItem.result = .NotDo
//            }
//            
//            if serail == 0 {
//                testItem.result = .Pass
//            }
//            testItems.append(testItem)
//        }
        
        
//        for (index, testItem) in brDates.enumerated() {
//        
//            
//            if index <= 10 {
//            
//                switch index {
//                    case 0:
//                        testCellIndexItemIndexMapping[3] = index
//                    case 1:
//                        testCellIndexItemIndexMapping[10] = index
//                    case 2:
//                        testCellIndexItemIndexMapping[11] = index
//                    case 3:
//                        testCellIndexItemIndexMapping[12] = index
//                    case 4:
//                        testCellIndexItemIndexMapping[19] = index
//                    case 5:
//                        testCellIndexItemIndexMapping[26] = index
//                    case 6:
//                        testCellIndexItemIndexMapping[25] = index
//                    case 7:
//                        testCellIndexItemIndexMapping[24] = index
//                    case 8:
//                        testCellIndexItemIndexMapping[23] = index
//                    case 9:
//                        testCellIndexItemIndexMapping[22] = index
//                    case 10:
//                        testCellIndexItemIndexMapping[21] = index
//
//                    default: print("no mapping")
//                }
//            } else {
//                let divideBy16 = index % 16;
//                var quotient = index / 16 ;
//                var cellIndex = 28;
//                
//                switch divideBy16 {
//                case 11:
//                    cellIndex = 28 +  28 * quotient;
//                    testCellIndexItemIndexMapping[cellIndex] = index
//                case 12:
//                    cellIndex = 35 +  28 * quotient;
//                    testCellIndexItemIndexMapping[cellIndex] = index
//                case 13:
//                    cellIndex = 36 +  28 * quotient;
//                    testCellIndexItemIndexMapping[cellIndex] = index
//                case 14:
//                    cellIndex = 37 +  28 * quotient;
//                    testCellIndexItemIndexMapping[cellIndex] = index
//                case 15:
//                    cellIndex = 38 +  28 * quotient;
//                    testCellIndexItemIndexMapping[cellIndex] = index
//                case 0:
//                    cellIndex = 39 +  28 * (quotient - 1);
//                    testCellIndexItemIndexMapping[cellIndex] = index
//                case 1:
//                    cellIndex = 40 +  28 * (quotient - 1);
//                    testCellIndexItemIndexMapping[cellIndex] = index
//                case 2:
//                    cellIndex = 41 +  28 * (quotient - 1);
//                    testCellIndexItemIndexMapping[cellIndex] = index
//                case 3:
//                    cellIndex = 48 +  28 * (quotient - 1);
//                    testCellIndexItemIndexMapping[cellIndex] = index
//                case 4:
//                    cellIndex = 55 +  28 * (quotient - 1);
//                    testCellIndexItemIndexMapping[cellIndex] = index
//                case 5:
//                    cellIndex = 54 +  28 * (quotient - 1);
//                    testCellIndexItemIndexMapping[cellIndex] = index
//                case 6:
//                    cellIndex = 53 +  28 * (quotient - 1);
//                    testCellIndexItemIndexMapping[cellIndex] = index
//                case 7:
//                    cellIndex = 52 +  28 * (quotient - 1);
//                    testCellIndexItemIndexMapping[cellIndex] = index
//                case 8:
//                    cellIndex = 51 +  28 * (quotient - 1);
//                    testCellIndexItemIndexMapping[cellIndex] = index
//                case 9:
//                    cellIndex = 50 +  28 * (quotient - 1);
//                    testCellIndexItemIndexMapping[cellIndex] = index
//                case 10:
//                    cellIndex = 49 +  28 * (quotient - 1);
//                    testCellIndexItemIndexMapping[cellIndex] = index
//                default: print("no mapping")
//                }
//                print("index: \(index) cellIndex : \(cellIndex ) divideBy16: \(divideBy16) quotient: \(quotient)");
//            }
//            
//        }
//        
        let testCellIndexItemIndexMappingKeys = Array(testCellIndexItemIndexMapping.keys);
        
        for cellINdex in testCellIndexItemIndexMappingKeys {
            
            if(cellINdex > self.maxCellIndex) {
                self.maxCellIndex = cellINdex;
            }
        }
        
        print("self.maxCellIndex : \(self.maxCellIndex )");
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.view.layoutIfNeeded()
        
        //self.collectionView.scrollToItem(at: IndexPath(item: 140, section: 0), at: .bottom, animated: true)
        
        /*
         for serail in stride(from: 0, through: 7, by: 1) {
         let testItem = TestItem()
         testItem.serial = Int(serail)
         testItem.index = Int(serail)
         switch TestItemResult.random() {
         case .Pass:
         testItem.result = .Pass
         case .Failed:
         testItem.result = .Failed
         case .NotDo:
         testItem.result = .NotDo
         }
         
         if serail == 0 {
         testItem.result = .Pass
         }
         testItems.append(testItem)
         }
         */
        
        print("all dates start")
        for intervalDay in stride(from: 30, through: 1, by: -1) {
            
            let date = Date(timeIntervalSinceNow: TimeInterval(60*60*24*intervalDay))
            let brDate = BRItem()
            brDate.date = date
            self.allBrItems.append(brDate)
        
        }
        
        for intervalDay in stride(from: 0, through: -120, by: -1) {
            
            let date = Date(timeIntervalSinceNow: TimeInterval(60*60*24*intervalDay))
            let brItem = BRItem()
            brItem.date = date
            self.allBrItems.append(brItem)
       
        }
        
        print("startOfWeek:\(self.startOfWeek())")
        print("endOfWeek:\(self.endOfWeek())")
        
        var first7DateOfThisWeekCount = 0
        var firstDateOfThisWeek:Date? = nil;
        self.chunkCounter = 0;
        var tmpBrItems:[BRItem?] = [];
        for (_, brItem ) in self.allBrItems.enumerated() {
            let date = brItem?.date;
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date!)
            let month = calendar.component(.month, from: date!)
            let day = calendar.component(.day, from: date!)
            let weekDay = calendar.component(.weekday, from: date!)
            //print("\(year)-\(month)-\(day)(\(weekDay))")
            
            if let dateChk = brItem?.date
            {
            
                let fallsBetween = (self.startOfWeek()...self.endOfWeek()).contains(dateChk)
                if(fallsBetween
                    && first7DateOfThisWeekCount < 7){
                    first7DateOfThisWeekCount += 1
                    if first7DateOfThisWeekCount == 1 {
                        brItem?.cellGuildLine = .bottomLeft
                    } else if first7DateOfThisWeekCount == 7 {
                        brItem?.cellGuildLine  = .topRight
                    } else {
                        brItem?.cellGuildLine  = .horizontal
                    }
                    //print("first rows date:\(dateChk)")
                    self.allBrItemsForCell.append(brItem);
                }
            }
        
            if(first7DateOfThisWeekCount == 7
                && firstDateOfThisWeek == nil) {
                firstDateOfThisWeek = brItem?.date
            }
            
            if(firstDateOfThisWeek != nil
                && firstDateOfThisWeek! > (brItem?.date)!){
                
                print("\(year)-\(month)-\(day)(\(weekDay))")
                
                switch self.currentCellPattern {
                case .empty7right1:
                    self.currentCellPatternCount = 7
                    for _ in stride(from: 1, through: 7, by: 1) {
                        let brItem = BRItem()
                        brItem.cellGuildLine = .none
                        self.allBrItemsForCell.append(brItem);
                        self.chunkCounter  += 1
                        
                    }
                    if(self.currentCellPatternCount == self.chunkCounter) {
                        //tmpBrItems.append(brItem)
                        brItem?.cellGuildLine = .vertical
                        self.allBrItemsForCell.append(brItem);
                        self.chunkCounter = 0
                        self.currentCellPattern = .circle8
                    }
                case .circle8:
                   
                    self.currentCellPatternCount = 8
                    tmpBrItems.append(brItem)
                    self.chunkCounter  += 1
                    if(self.currentCellPatternCount == self.chunkCounter) {
                        let tmpBrItemsReverse = tmpBrItems.reversed()
                        for obj in tmpBrItemsReverse.enumerated() {
                            if obj.offset == 0 {
                                obj.element?.cellGuildLine = .topLeft
                            } else if obj.offset == 7  {
                                obj.element?.cellGuildLine  = .bottomRight
                            } else {
                                obj.element?.cellGuildLine  = .horizontal
                            }
                            self.allBrItemsForCell.append(obj.element)
                        }
                        
                        self.chunkCounter = 0
                        self.currentCellPattern = .circle1Left
                        
                    }
                case .circle1Left:

                    self.currentCellPatternCount = 1
                    brItem?.cellGuildLine = .vertical
                    self.allBrItemsForCell.append(brItem);
                    self.chunkCounter  += 1
                    if(self.currentCellPatternCount == self.chunkCounter) {
                        self.chunkCounter = 0
                        self.currentCellPattern = .empty7_2
                    }
                case .empty7_2:

                    self.currentCellPatternCount = 7
                    for _ in stride(from: 1, through: 7, by: 1) {
                        let brItem = BRItem()
                        brItem.cellGuildLine = .horizontal
                        self.allBrItemsForCell.append(brItem);
                        self.chunkCounter  += 1
                        
                    }
                    if(self.currentCellPatternCount == self.chunkCounter) {
                        self.chunkCounter = 0
                        self.currentCellPattern = .circle8_2
                        tmpBrItems = [];
                        brItem?.cellGuildLine = .bottomLeft
                        self.allBrItemsForCell.append(brItem)
                        self.chunkCounter  += 1
                    }
                case .circle8_2:
                    self.currentCellPatternCount = 8
                    self.chunkCounter  += 1
                    self.allBrItemsForCell.append(brItem)
                    if self.chunkCounter == 8 {
                        brItem?.cellGuildLine = .topRight
                    } else {
                        brItem?.cellGuildLine = .horizontal
                    }
                    if(self.currentCellPatternCount == self.chunkCounter) {
                        self.chunkCounter = 0
                        self.currentCellPattern = .empty7right1
                       
                    }
                default:
                    print("default")
                    
                }
            }
            
        }
        
        print("all dates end")

        for (_ , brItem) in self.allBrItemsForCell.enumerated() {
            
//            if let date = brItem?.date
//            {
//                let calendar = Calendar.current
//                let year = calendar.component(.year, from: date)
//                let month = calendar.component(.month, from: date)
//                let day = calendar.component(.day, from: date)
//                let weekDay = calendar.component(.weekday, from: date)
//                print("allBrItemsForCell: brItem\(idx): \(year)-\(month)-\(day)(\(weekDay))")
//            
//            } else {
//                print("allBrItemsForCell: empty")
//            }
            
            self.inserCellByBRItem(brItem: brItem!)
            
        }
        
//        self.inserCellByDate(dateStr: "2017-04-15 10:44:01");
//        self.inserCellByDate(dateStr: "2017-04-14 10:44:01");
//        self.inserCellByDate(dateStr: "2017-04-13 10:44:01");
//        self.inserCellByDate(dateStr: "2017-04-12 10:44:01");
//        self.inserCellByDate(dateStr: "2017-04-11 10:44:01");
//        self.inserCellByDate(dateStr: "2017-04-10 10:44:01");
//        self.inserCellByDate(dateStr: "2017-04-09 10:44:01");
//        self.inserCellByDate(dateStr: "2017-04-08 10:44:01");
//        self.inserCellByDate(dateStr: "2017-04-07 10:44:01");
//        self.inserCellByDate(dateStr: "2017-04-06 10:44:01");
//        self.inserCellByDate(dateStr: "2017-04-05 10:44:01");
//        self.inserCellByDate(dateStr: "2017-04-04 10:44:01");
//        self.inserCellByDate(dateStr: "2017-04-03 10:44:01");
//        self.inserCellByDate(dateStr: "2017-04-02 10:44:01");
//        self.inserCellByDate(dateStr: "2017-04-01 10:44:01");
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    
        let rowIndex = indexPath.row
        let numberOfColumns: CGFloat = 8
        
        var itemWidth = (self.collectionView!.frame.width - (numberOfColumns)) / numberOfColumns
        var itemHeight:CGFloat = 0.0
        
        let barItem = self.brItems[rowIndex]
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
        
        return CGSize(width: itemWidth, height: itemHeight)
    
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.brItems.count
        //return  (self.maxCellIndex + 1)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let rowIndex = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TestResultCollectionViewCell

        let cellCurrent = collectionView.dequeueReusableCell(withReuseIdentifier: "TestResultCurrentDateCell", for: indexPath) as! TestResultCurrentDateCell
        
        let barItem = self.brItems[rowIndex]
        barItem?.serial = rowIndex
        
        let dateCurrent = Date()
        let calendar = Calendar.current
        let componentsCurrent = calendar.dateComponents([.year, .month, .day], from: dateCurrent)
        let yearCurrent =  componentsCurrent.year
        let monthCurrent = componentsCurrent.month
        let dayCurrent = componentsCurrent.day
        
        cell.backgroundColor = UIColor.blue
        
        if let barItemDate = barItem?.date {
            let componentsTestItem = calendar.dateComponents([.year, .month, .day], from: barItemDate )
            let yearTestItem  =  componentsTestItem.year
            let monthTestItem  = componentsTestItem.month
            let dayTestItem  = componentsTestItem.day
            
            if yearCurrent == yearTestItem
                && monthCurrent == monthTestItem
                && dayCurrent == dayTestItem{
                
                cellCurrent.date = barItemDate
                cellCurrent.serialLb.text = "\(indexPath.row)"
                return cellCurrent
            } else {
                
                cell.date = barItemDate
                cell.serialLb.text = "\(indexPath.row)"
                return cell
            }
            
        } else {
            cell.date = nil
            cell.serialLb.text = "\(indexPath.row)"
            cell.backgroundColor = UIColor.black
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
        let barItem = self.brItems[rowIndex]
        
        guard let _ = barItem?.date else {
        
            return;
        }
        
        let count = barItem?.testItems.count
        let msg = "\(barItem?.cellGuildLine)\n testItems.count:\(String(describing: count))"
        
        let alert = UIAlertController(title: barItem?.serial.description, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        let rowIndex = indexPath.row
        let barItem = self.brItems[rowIndex]
    }
    
    
    func datefromString(dateStr:String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date = dateFormatter.date(from: dateStr)!
        return date
    }
    
    func inserCellByDate(dateStr:String) {
   
        let brDate = BRItem()
        brDate.date = self.datefromString(dateStr: dateStr)
        
        self.brItems.append(brDate)
        let indexPath = IndexPath(row: (self.brItems.count - 1 ), section: 0)
        self.collectionView.insertItems(at: [indexPath])
    }
    
    func inserCellByBRItem(brItem:BRItem) {
        
        self.brItems.append(brItem)
        let indexPath = IndexPath(row: (self.brItems.count - 1 ), section: 0)
        self.collectionView.insertItems(at: [indexPath])
    }


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
    

}
