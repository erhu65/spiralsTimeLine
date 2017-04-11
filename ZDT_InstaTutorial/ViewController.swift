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
    case reverse_7e_1c
    case reverse_8c_reverse
    case reverse_1c_7e
    case reverse_8c
    case future_regular_end
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
        for intervalDay in stride(from: 86, through: 1, by: -1) {
            
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
        var lastDateOfThisWeek:Date? = nil;
        self.chunkCounter = 0;
        var tmpBrItems:[BRItem?] = [];
        var futureBrItems:[BRItem?] = [];
        
        var tailFutureBrItems:[BRItem?] = [];
    

        for (_, brItem ) in self.allBrItems.enumerated() {
        
            if let dateChk = brItem?.date
            {
            
                let fallsBetween = (self.startOfWeek()...self.endOfWeek()).contains(dateChk)
                
                if lastDateOfThisWeek == nil
                    && !fallsBetween {
                    futureBrItems.append(brItem)
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
                    
                    //print("\(year)-\(month)-\(day)(\(weekDay))")
                    
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
        
        var reverse_currentCellPattern:CellRegularPattern = .reverse_7e_1c
        var reverse_chunkCounter = 0;
        var reverse_tmpBrItems:[BRItem?] = [];
        //var reverse_currentCellPatternCount = 1
        if futureBrItemsReverse.count > 0 {
            let futureBrItemsReverseCount = futureBrItemsReverse.count
            var futureBrItemsReverseCountLeft = futureBrItemsReverseCount
            
            for (_, barItemFutrue) in futureBrItemsReverse.enumerated() {
                
//                if futureBrItemsReverseCountLeft <= circle_tiail_nums
//                && is_reverse_regular_session_end
//                {
//                    is_reverse_regular_session_end = false
//                    print("reverse_currentCellPattern: \(reverse_currentCellPattern)")
//                    print("futureBrItemsReverseCountLeft: \(futureBrItemsReverseCountLeft)")
//                    print("barItemFutrue: \(barItemFutrue?.date)")
//                    reverse_chunkCounter = 0
//                    reverse_tmpBrItems = []
//                    //reverse_currentCellPattern = .tail_1e_7c_reverse
//                }
             

                switch reverse_currentCellPattern  {
                case .reverse_7e_1c:
                    for _ in stride(from: 1, through: 7, by: 1) {
                        let brItem = BRItem()
                        brItem.cellGuildLine = .horizontal
                        reverse_chunkCounter += 1
                        self.allBrItemsForCell.insert(brItem, at: 0)
                    }
                    
                    reverse_chunkCounter += 1
                    futureBrItemsReverseCountLeft -= 1
                    self.allBrItemsForCell.insert(barItemFutrue!, at: 0)
                    if reverse_chunkCounter == 8 {
                        
                        reverse_chunkCounter = 0
                        reverse_tmpBrItems = []
                        
                        reverse_currentCellPattern = .reverse_8c_reverse
                    }
                case .reverse_8c_reverse:
                    reverse_chunkCounter += 1
                    reverse_tmpBrItems.append(barItemFutrue)
                    
                    if reverse_chunkCounter == 8 {
                        let reverse_tmpBrItems_reverse:[BRItem?] = reverse_tmpBrItems.reversed()
                        for (_, brItme) in reverse_tmpBrItems_reverse.enumerated() {
                            futureBrItemsReverseCountLeft -= 1
                            self.allBrItemsForCell.insert(brItme, at: 0)
                        }
                        reverse_chunkCounter = 0
                        reverse_currentCellPattern = .reverse_1c_7e
                        
                    }
                    
                case .reverse_1c_7e:
                    reverse_chunkCounter += 1
                    futureBrItemsReverseCountLeft -= 1
                    self.allBrItemsForCell.insert(barItemFutrue!, at: 0)
                    
                    for _ in stride(from: 1, through: 7, by: 1) {
                        let brItem = BRItem()
                        brItem.cellGuildLine = .horizontal
                        reverse_chunkCounter += 1
                        self.allBrItemsForCell.insert(brItem, at: 0)
                    }
                    
                    if reverse_chunkCounter == 8 {
                        reverse_chunkCounter = 0
                        reverse_currentCellPattern = .reverse_8c
                    }
                case .reverse_8c:
                    reverse_chunkCounter += 1
                    futureBrItemsReverseCountLeft -= 1
                    self.allBrItemsForCell.insert(barItemFutrue!, at: 0)
                    if reverse_chunkCounter == 8 {
                     
                        reverse_chunkCounter = 0
                        if futureBrItemsReverseCountLeft > 24 {
                            reverse_currentCellPattern = .reverse_7e_1c
                            
                        } else {
                            for _ in stride(from: 1, through: 64, by: 1) {
                                let brItem = BRItem()
                                brItem.cellGuildLine = .horizontal
                                reverse_chunkCounter += 1
                                self.allBrItemsForCell.insert(brItem, at: 0)
                            }
                            reverse_currentCellPattern = .future_regular_end
                            //reverse_currentCellPattern = .tail_7e_1c
                        }
                    }
                case .future_regular_end:
                    tailFutureBrItems.append(barItemFutrue)
                default:
                    print("aa")
                }
            }
            
        }

        
        for (idx , brItem) in tailFutureBrItems.enumerated() {
            
            switch idx {
            case 0:
                self.allBrItemsForCell[56] = brItem
            case 1:
                self.allBrItemsForCell[48] = brItem
            case 2:
                self.allBrItemsForCell[49] = brItem
            case 3:
                self.allBrItemsForCell[50] = brItem
            case 4:
                self.allBrItemsForCell[51] = brItem
            case 5:
                self.allBrItemsForCell[52] = brItem
            case 6:
                self.allBrItemsForCell[53] = brItem
            case 7:
                self.allBrItemsForCell[54] = brItem
            case 8:
                self.allBrItemsForCell[46] = brItem
            case 9:
                self.allBrItemsForCell[38] = brItem
            case 10:
                self.allBrItemsForCell[37] = brItem
            case 11:
                self.allBrItemsForCell[36] = brItem
            case 12:
                self.allBrItemsForCell[35] = brItem
            case 13:
                self.allBrItemsForCell[34] = brItem
            case 14:
                self.allBrItemsForCell[33] = brItem
            case 15:
                self.allBrItemsForCell[25] = brItem
            case 16:
                self.allBrItemsForCell[17] = brItem
            case 17:
                self.allBrItemsForCell[18] = brItem
            case 18:
                self.allBrItemsForCell[19] = brItem
            case 19:
                self.allBrItemsForCell[20] = brItem
            case 20:
                self.allBrItemsForCell[21] = brItem
            case 21:
                self.allBrItemsForCell[13] = brItem
            case 22:
                self.allBrItemsForCell[5] = brItem
            case 23:
                self.allBrItemsForCell[4] = brItem
            default:
                continue
            }
//            let date = brItem?.date
//            let calendar = Calendar.current
//            let year = calendar.component(.year, from: date!)
//            let month = calendar.component(.month, from: date!)
//            let day = calendar.component(.day, from: date!)
//            let weekDay = calendar.component(.weekday, from: date!)
//            
//            print("tailFutureBrItems:\(month)/\(day)(\(weekDay)) ")
        }
        
        self.collectionView.reloadData()

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
        
        return CGSize(width: itemWidth, height: itemHeight)
    
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
        let barItem = self.allBrItemsForCell[rowIndex]
        
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
        let barItem = self.allBrItemsForCell[rowIndex]
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

    func inserCellByBRItemAtFirst(brItem:BRItem) {
        
        self.brItems.insert(brItem, at: 0)
        let indexPath = IndexPath(row:0, section: 0)
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
