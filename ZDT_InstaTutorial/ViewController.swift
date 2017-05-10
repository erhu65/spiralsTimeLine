//
//  ViewController.swift
//  ZDT_InstaTutorial
//
//  Created by Sztanyi Szabolcs on 22/12/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

import UIKit


enum AdjustCellArrangement: UInt32 {
    case reverse_false_empty_7
    case reverse_false_empty_6
    case reverse_false_empty_5
    case reverse_false_empty_4
    case reverse_false_empty_3
    case reverse_false_empty_2
    case reverse_false_empty_1
    case reverse_false_empty_0
    case reverse_true_empty_7
    case reverse_true_empty_6
    case reverse_true_empty_5
    case reverse_true_empty_4
    case reverse_true_empty_3
    case reverse_true_empty_2
    case reverse_true_empty_1
    case reverse_true_empty_0
    case none
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
UITextFieldDelegate{

    
    @IBOutlet weak var topV: UIView!
    @IBOutlet weak var popV: UIView!
    @IBOutlet weak var popLb: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!

    var currentIndex:Int = -1
    
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
        if (barItem?.isEmptyRow)! {
            //itemHeight -= 10
        } else {
            itemHeight += 18
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

        
        guard let date = barItem?.date else {
          
            return
        }
        print("barItem?.date: \(self.formatLocalDate("", date))")
        let testIitemsCount = barItem?.testItems.count
        if testIitemsCount == 0 {
            return
        }
        

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
        self.popLb.sizeToFit()
        self.popV.sizeToFit()
        
        self.popLb.text = testValStr

        self.popV.isHidden = false

        let font = UIFont (name: "HelveticaNeue-Light", size: 12)
        var dynamicHieght = testValStr.height(withConstrainedWidth: 100, font: font!)
        dynamicHieght += 30
        var  popVRect = self.popV.frame;
        var  popLbRect = self.popLb.frame;
        popVRect.size.width = 100;
        popVRect.size.height = dynamicHieght;
        popLbRect.size.width = 100;
        popLbRect.size.height = dynamicHieght;
        
        self.popLb.frame = popLbRect;
        self.popV.frame = popVRect;
    
        let attributes = collectionView.layoutAttributesForItem(at: indexPath)
        
        let cellRect = attributes?.frame;
        
        let cellFrameInSuperview = collectionView.convert(cellRect!, to: collectionView.superview)
        
        let cellFrameInSuperviewSizeWidth = cellFrameInSuperview.size.width
        
        var anchorXY = CGPoint(x: (cellFrameInSuperview.origin.x + cellFrameInSuperviewSizeWidth / 2), y: cellFrameInSuperview.origin.y)
        //anchorXY.y -= 10
        
        self.popV.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        self.popV.center = anchorXY
        //print("testValStr: \(testValStr)")

        if (self.topV.frame.intersects(self.popV.frame)) {
            self.popV.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
            anchorXY.y += 40
            //print("intersect: anchorXY.y: \(anchorXY.y)")
            self.popV.center = anchorXY
        }
        

    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

//        let rowIndex = indexPath.row
//        let barItem = self.allBrItemsForCell[rowIndex]
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
        var allBrItems:[BRItem?] = []
      
        
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
            let testItemCount = brItem.testItems.count
            
            let str = self.formatLocalDate("before testItemCount:\(testItemCount)", date)
            print(str)
            
            
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
        
//        var first7DateOfThisWeekCount = 0
//        var firstDateOfThisWeek:Date? = nil
//        var lastDateOfThisWeek:Date? = nil
       
        var thisWeekBrItems:[BRItem?] = []
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
        
        let the_1th_day_this_week =  Date().startOfWeek
        let the_2th_day_this_week =  Date(timeInterval: 60*60*24*1, since: the_1th_day_this_week!)
        let the_3th_day_this_week =  Date(timeInterval: 60*60*24*2, since: the_1th_day_this_week!)
//        let the_4th_day_this_week =  Date(timeInterval: 60*60*24*3, since: the_1th_day_this_week!)
//        let the_5th_day_this_week =  Date(timeInterval: 60*60*24*4, since: the_1th_day_this_week!)
//        let the_6th_day_this_week =  Date(timeInterval: 60*60*24*5, since: the_1th_day_this_week!)
        let the_7th_day_this_week =  Date(timeInterval: 60*60*24*6, since: the_1th_day_this_week!)
        print("\(self.formatLocalDate("the_7th_day_this_week", the_7th_day_this_week))")
        
        for idx in stride(from: 0, through: 6, by: 1) {
            let brItem = self.mkNoDateBrItem(.horizontal)
            brItem.date = Date(timeInterval: TimeInterval(60*60*24*idx), since: the_1th_day_this_week!)
            brItem.testItems = []
            thisWeekBrItems.append(brItem);
        }
        
        var allBrItemsLoopCount = allBrItemsReduceEmpty.count
        for (_, brItem ) in allBrItemsReduceEmpty.enumerated() {
            
            allBrItemsLoopCount -= 1
            
            if let dateChk = brItem?.date
            {

                let fallsBetween = (self.startOfWeek()...self.endOfWeek()).contains(dateChk)
                
            
                if dateChk > the_7th_day_this_week
                    && !fallsBetween {
                    //after this week
                    print("\(self.formatLocalDate("future date:", dateChk))")
               
                    futureBrItems.append(brItem)
                    continue
                    //print("future: \(year)-\(month)-\(day)(\(weekDay))")
                }
                
                if(fallsBetween){
                    let calendar = Calendar.current
                    let weekDay = calendar.component(.weekday, from: dateChk)
                    let weekDayIndex = weekDay - 1
                    let brItemPlaceHolder = thisWeekBrItems[weekDayIndex]
                    brItemPlaceHolder?.date = dateChk
                    brItemPlaceHolder?.testItems = (brItem?.testItems)!
                    thisWeekBrItems[weekDayIndex] = brItemPlaceHolder
                    continue

                }
                
                if dateChk < the_1th_day_this_week!
                   && !fallsBetween {
                    //before this week
                    beforeBrItems.append(brItem);
                    continue
                }

            
            }
            
        }
        
        //let date = Date(timeIntervalSinceNow: TimeInterval(60*60*24*intervalDay))
        let isSameDate = Calendar.current.isDate(the_3th_day_this_week, inSameDayAs:Date())
        
        print("startDateOfThisWeek:\(self.formatLocalDate("", the_2th_day_this_week))")
        print("isSameDate:\(isSameDate)")
        
        for (idx, brItem ) in thisWeekBrItems.enumerated() {
            guard let date = brItem?.date else {
                    print("thisWeekBrItems idx:\(idx) brItem.date:nil")
                    continue
            }
                 print("thisWeekBrItems idx:\(idx) brItem.date:\(self.formatLocalDate("", date))")
        }
        
        var thisWeekBrItemsRevrese:[BRItem?] = thisWeekBrItems.reversed()
        let brItemVerticleLeft  = self.mkNoDateBrItem(.bottomLeft)
        thisWeekBrItemsRevrese.insert(brItemVerticleLeft, at: 0)
        let brItemVerticleRight  = self.mkNoDateBrItem(.topRight)
        thisWeekBrItemsRevrese.append(brItemVerticleRight)

   
        self.allBrItemsForCell.insert(contentsOf: thisWeekBrItemsRevrese, at: 0)
        
        for (_, brItem ) in futureBrItems.enumerated() {
            guard let date = brItem?.date else {
                continue;
            }
            let dateStr = self.formatLocalDate("after current week date: ", date)
            let testItemCount = brItem?.testItems.count
            print("\(dateStr) count:\(testItemCount!)")
        }
 

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
                
            }
            self.allBrItemsForCell += notEmptyRow
            
            groupIndex += 1
        }

        let futureBrItemsReverse = futureBrItems.reversed()
        var futureBrItemsReversePerChunkG = futureBrItemsReverse.chunk(8).makeIterator()
        let modfutureBrItemsReverse = futureBrItemsReverse.count / 8
        let reminderfutureBrItemsReverse = futureBrItemsReverse.count % 8
        
        var groupIndexFuture = 0
        var adjustCellArrangement:AdjustCellArrangement = .none
        while let futureBrItemsReversePerChunk = futureBrItemsReversePerChunkG.next() {
            var emptyRowIsR:Bool = true
            var futureBrItemsPerChunkReOrder:[BRItem?] = []
            let futureBrItemsPerChunkCount = futureBrItemsReversePerChunk.count
            let notEnough = 8 - futureBrItemsPerChunkCount
            var isLastRow = false
            if(groupIndexFuture == modfutureBrItemsReverse
                || (reminderfutureBrItemsReverse == 0 && ((groupIndexFuture + 1) == modfutureBrItemsReverse))
                ) {
                isLastRow = true
            }
            
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
//                        if(groupIndex == modfutureBrItemsReverse) {
//                            brItem.cellGuildLine = .none
//                        }
                        notEmptyRow.append(brItem)
                    }
                    
                }
                
                if brItem?.date != nil {

                    let celStr = self.formatLocalDate("after current week date groupIndex:\(groupIndexFuture): ", (brItem?.date!)!)
                    let testItemCount = brItem?.testItems.count
                    print("\(celStr) count:\(testItemCount!) revere:\(emptyRowIsR) isLastRow: \(isLastRow)")

                } else {
                    print("after current week date groupIndex:\(groupIndexFuture):  empty guid:\(String(describing: brItem?.cellGuildLine)) revere:\(emptyRowIsR) isLastRow: \(isLastRow)" )
                }
                if isLastRow {
                    if(emptyRowIsR == false) {
                        
                        switch notEnough {
                        case 7:
                            adjustCellArrangement = .reverse_false_empty_7
                        case 6:
                            adjustCellArrangement = .reverse_false_empty_6
                        case 5:
                            adjustCellArrangement = .reverse_false_empty_5
                        case 4:
                            adjustCellArrangement = .reverse_false_empty_4
                        case 3:
                            adjustCellArrangement = .reverse_false_empty_3
                        case 2:
                            adjustCellArrangement = .reverse_false_empty_2
                        case 1:
                            adjustCellArrangement = .reverse_false_empty_1
                        case 0:
                            adjustCellArrangement = .reverse_false_empty_0
                        default:
                            print("")
                        }
                    } else if(emptyRowIsR == true) {
                    
                        switch notEnough {
                        case 7:
                            adjustCellArrangement = .reverse_true_empty_7
                        case 6:
                            adjustCellArrangement = .reverse_true_empty_6
                        case 5:
                            adjustCellArrangement = .reverse_true_empty_5
                        case 4:
                            adjustCellArrangement = .reverse_true_empty_4
                        case 3:
                            adjustCellArrangement = .reverse_true_empty_3
                        case 2:
                            adjustCellArrangement = .reverse_true_empty_2
                        case 1:
                            adjustCellArrangement = .reverse_true_empty_1
                        case 0:
                            adjustCellArrangement = .reverse_true_empty_0
                        default:
                            print("")
                        }
                    }
                    
                }
                
            }
            self.allBrItemsForCell.insert(contentsOf: notEmptyRow, at: 0)
            groupIndexFuture += 1
        }
        
        print("adjustCellArrangement:\(adjustCellArrangement)")
        self.adjustCellArrangement(pattern: adjustCellArrangement)
   
        
        //最後補上一列空白的，修正原本最右下角cell，位置偏差
        for _ in stride(from: 1, through: self.numberOfColumns, by: 1) {
            let brItem = BRItem()
            brItem.cellGuildLine = .none
            self.allBrItemsForCell.append(brItem)
        }
        
        //get the current date rowIndex
        for (idx, brItem ) in self.allBrItemsForCell.enumerated() {
            if let date = brItem?.date {
                let isCurrentDate = Calendar.current.isDate(date, inSameDayAs:Date())
                if(isCurrentDate){
                    self.currentIndex = idx
                }
            }
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
    
    
    @IBAction func moveToCurrentDate(_ sender: Any) {
        
        if self.currentIndex != -1 {
            let indexPath = IndexPath(row: self.currentIndex, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
            
        }
    }
    
    
    static func mkRandomTestItem() -> TestItem {
    
        let testItem = TestItem()
        testItem.gender = "peter@bonraybio.com"
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
                    testItem.gender = "mary@bonraybio.com"
                }
              
                let randomNum = arc4random_uniform(3)
                if(randomNum == 0){
                    testItem.value = 1
                } else {
                    testItem.value = 0
                }
            } else {
                testItem.gender = "mary@bonraybio.com"
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
            brItem.isEmptyRow = true
            brItems.append(brItem)
        }
        return brItems
    }
    
    func adjustCellArrangement(pattern:AdjustCellArrangement) {
        
        //TODO:future less than 3 rows, another Algorithm
        
        switch pattern {
        case .reverse_false_empty_7:
            let brItem0 = self.allBrItemsForCell[0]
            let brItem1 = self.allBrItemsForCell[1]
            let brItem2 = self.allBrItemsForCell[2]
            let brItem3 = self.allBrItemsForCell[3]
            let brItem4 = self.allBrItemsForCell[4]
            let brItem5 = self.allBrItemsForCell[5]
            
            let brItem6 = self.allBrItemsForCell[6]
            let brItem7 = self.allBrItemsForCell[7]
            let brItem8 = self.allBrItemsForCell[8]
            
            let brItem10 = self.allBrItemsForCell[10]
            let brItem12 = self.allBrItemsForCell[12]
            let brItem20 = self.allBrItemsForCell[20]
            let brItem21 = self.allBrItemsForCell[21]
            let brItem22 = self.allBrItemsForCell[22]
            let brItem29 = self.allBrItemsForCell[29]
            
            brItem5?.testItems = (brItem1?.testItems)!
            brItem5?.date = brItem1?.date
            brItem5?.cellGuildLine = .horizontal
            brItem1?.testItems = []
            brItem1?.date = nil
            brItem1?.cellGuildLine = .none
            
            brItem4?.testItems = (brItem21?.testItems)!
            brItem4?.cellGuildLine = .horizontal
            brItem4?.date = brItem21?.date
            brItem21?.testItems = []
            brItem21?.date = nil
            brItem21?.cellGuildLine = .none
            
            brItem3?.testItems = (brItem22?.testItems)!
            brItem3?.cellGuildLine = .horizontal
            brItem3?.date = brItem22?.date
            brItem22?.testItems = []
            brItem22?.date = nil
            brItem22?.cellGuildLine = .bottomLeft
            
            brItem12?.cellGuildLine = .vertical
            brItem10?.cellGuildLine = .none
            
            brItem0?.cellGuildLine = .none
            brItem20?.cellGuildLine = .none
            brItem2?.cellGuildLine = .topLeft
            
            brItem6?.cellGuildLine = .noneEmpty
            brItem7?.cellGuildLine = .noneEmpty
            brItem8?.cellGuildLine = .noneEmpty
            brItem29?.cellGuildLine = .topRight
            
        case .reverse_false_empty_6:
            let brItem0 = self.allBrItemsForCell[0]
            let brItem1 = self.allBrItemsForCell[1]
            let brItem2 = self.allBrItemsForCell[2]
            let brItem3 = self.allBrItemsForCell[3]
            let brItem4 = self.allBrItemsForCell[4]
            let brItem5 = self.allBrItemsForCell[5]
            let brItem6 = self.allBrItemsForCell[6]
            let brItem7 = self.allBrItemsForCell[7]
            let brItem8 = self.allBrItemsForCell[8]
            let brItem10 = self.allBrItemsForCell[10]
            let brItem11 = self.allBrItemsForCell[11]
            let brItem20 = self.allBrItemsForCell[20]
            let brItem21 = self.allBrItemsForCell[21]
            let brItem29 = self.allBrItemsForCell[29]
            
            brItem4?.testItems = (brItem2?.testItems)!
            brItem4?.date = brItem2?.date
            brItem4?.cellGuildLine = .horizontal
            
            brItem3?.testItems = (brItem1?.testItems)!
            brItem3?.date = brItem1?.date
            brItem3?.cellGuildLine = .horizontal
            
            brItem2?.testItems = (brItem21?.testItems)!
            brItem2?.date = brItem21?.date
            brItem3?.cellGuildLine = .horizontal
            
            brItem1?.testItems = []
            brItem1?.date = nil
            brItem1?.cellGuildLine = .topLeft
            
            brItem0?.testItems = []
            brItem0?.date = nil
            brItem0?.cellGuildLine = .none
            
            brItem10?.testItems = []
            brItem10?.date = nil
            brItem10?.cellGuildLine = .none
            
            brItem11?.testItems = []
            brItem11?.date = nil
            brItem11?.cellGuildLine = .vertical
            
            brItem20?.testItems = []
            brItem20?.date = nil
            brItem20?.cellGuildLine = .none
            
            brItem21?.testItems = []
            brItem21?.date = nil
            brItem21?.cellGuildLine = .bottomLeft
            
            brItem5?.cellGuildLine = .noneEmpty
            brItem6?.cellGuildLine = .noneEmpty
            brItem7?.cellGuildLine = .noneEmpty
            brItem8?.cellGuildLine = .noneEmpty
            brItem29?.cellGuildLine = .topRight
        case .reverse_false_empty_5:
            let brItem0 = self.allBrItemsForCell[0]
            let brItem1 = self.allBrItemsForCell[1]
            let brItem2 = self.allBrItemsForCell[2]
            let brItem3 = self.allBrItemsForCell[3]
            let brItem4 = self.allBrItemsForCell[4]
            let brItem5 = self.allBrItemsForCell[5]
            let brItem6 = self.allBrItemsForCell[6]
            let brItem7 = self.allBrItemsForCell[7]
            let brItem8 = self.allBrItemsForCell[8]
            let brItem10 = self.allBrItemsForCell[10]
            let brItem11 = self.allBrItemsForCell[11]
            let brItem20 = self.allBrItemsForCell[20]
            let brItem21 = self.allBrItemsForCell[21]
            let brItem29 = self.allBrItemsForCell[29]
            
            brItem5?.testItems = (brItem3?.testItems)!
            brItem5?.date = brItem3?.date
            brItem5?.cellGuildLine = .horizontal
            
            brItem4?.testItems = (brItem2?.testItems)!
            brItem4?.date = brItem2?.date
            brItem4?.cellGuildLine = .horizontal
            
            brItem3?.testItems = (brItem1?.testItems)!
            brItem3?.date = brItem1?.date
            brItem3?.cellGuildLine = .horizontal
            
            brItem2?.testItems = (brItem21?.testItems)!
            brItem2?.date = brItem21?.date
            brItem2?.cellGuildLine = .horizontal
            
            brItem1?.testItems = []
            brItem1?.date = nil
            brItem1?.cellGuildLine = .topLeft
            
            brItem0?.testItems = []
            brItem0?.date = nil
            brItem0?.cellGuildLine = .none
            
            brItem10?.testItems = []
            brItem10?.date = nil
            brItem10?.cellGuildLine = .none
            
            brItem11?.testItems = []
            brItem11?.date = nil
            brItem11?.cellGuildLine = .vertical
            
            brItem20?.testItems = []
            brItem20?.date = nil
            brItem20?.cellGuildLine = .none
            
            brItem21?.testItems = []
            brItem21?.date = nil
            brItem21?.cellGuildLine = .bottomLeft
            
            brItem6?.cellGuildLine = .noneEmpty
            brItem7?.cellGuildLine = .noneEmpty
            brItem8?.cellGuildLine = .noneEmpty
            brItem29?.cellGuildLine = .topRight
            
        case .reverse_false_empty_4:
            let brItem5 = self.allBrItemsForCell[5]
            let brItem6 = self.allBrItemsForCell[6]
            let brItem7 = self.allBrItemsForCell[7]
            let brItem8 = self.allBrItemsForCell[8]
            let brItem29 = self.allBrItemsForCell[29]
            
            brItem5?.cellGuildLine = .noneEmpty
            brItem6?.cellGuildLine = .noneEmpty
            brItem7?.cellGuildLine = .noneEmpty
            brItem8?.cellGuildLine = .noneEmpty
            brItem29?.cellGuildLine = .topRight
            
            
         case .reverse_false_empty_3:
            let brItem6 = self.allBrItemsForCell[6]
            let brItem7 = self.allBrItemsForCell[7]
            let brItem8 = self.allBrItemsForCell[8]
            brItem6?.cellGuildLine = .noneEmpty
            brItem7?.cellGuildLine = .noneEmpty
            brItem8?.cellGuildLine = .noneEmpty
            
        case .reverse_false_empty_2:
            
            for _ in stride(from: 0, through: 19, by: 1) {
                let brItem = self.mkNoDateBrItem(.none)
                self.allBrItemsForCell.insert(brItem, at: 0)
         
            }
            let brItem1 = self.allBrItemsForCell[1]
            let brItem2 = self.allBrItemsForCell[2]
            let brItem3 = self.allBrItemsForCell[3]
            let brItem4 = self.allBrItemsForCell[4]
            
            let brItem5 = self.allBrItemsForCell[5]
            let brItem6 = self.allBrItemsForCell[6]
            let brItem16 = self.allBrItemsForCell[16]
            let brItem26 = self.allBrItemsForCell[26]
            
            brItem5?.testItems = (brItem26?.testItems)!
            brItem5?.date = brItem26?.date
            brItem5?.cellGuildLine = .horizontal
            
            brItem6?.testItems = []
            brItem6?.date = nil
            brItem6?.cellGuildLine = .topRight
            
            brItem16?.testItems = []
            brItem16?.date = nil
            brItem16?.cellGuildLine = .vertical
            
            brItem26?.testItems = []
            brItem26?.date = nil
            brItem26?.cellGuildLine = .bottomRight
            
            brItem1?.cellGuildLine = .noneEmpty
            brItem2?.cellGuildLine = .noneEmpty
            brItem3?.cellGuildLine = .noneEmpty
            brItem4?.cellGuildLine = .noneEmpty
            
        case .reverse_false_empty_1:
            
            for _ in stride(from: 0, through: 19, by: 1) {
                let brItem = self.mkNoDateBrItem(.none)
                self.allBrItemsForCell.insert(brItem, at: 0)
            }
            let brItem1 = self.allBrItemsForCell[1]
            let brItem2 = self.allBrItemsForCell[2]
            let brItem3 = self.allBrItemsForCell[3]
            let brItem4 = self.allBrItemsForCell[4]
            let brItem5 = self.allBrItemsForCell[5]
            let brItem6 = self.allBrItemsForCell[6]
            let brItem16 = self.allBrItemsForCell[16]
            let brItem26 = self.allBrItemsForCell[26]
            let brItem27 = self.allBrItemsForCell[27]
            
            brItem4?.testItems = (brItem27?.testItems)!
            brItem4?.date = brItem27?.date
            brItem4?.cellGuildLine = .horizontal
            
            brItem5?.testItems = (brItem26?.testItems)!
            brItem5?.date = brItem26?.date
            brItem5?.cellGuildLine = .horizontal
            
            brItem6?.testItems = []
            brItem6?.date = nil
            brItem6?.cellGuildLine = .topRight
            
            brItem16?.testItems = []
            brItem16?.date = nil
            brItem16?.cellGuildLine = .vertical
            
            brItem26?.testItems = []
            brItem26?.date = nil
            brItem26?.cellGuildLine = .bottomRight
            
            brItem27?.testItems = []
            brItem27?.date = nil
            brItem27?.cellGuildLine = .none
            
            brItem1?.cellGuildLine = .noneEmpty
            brItem2?.cellGuildLine = .noneEmpty
            brItem3?.cellGuildLine = .noneEmpty
            
        case .reverse_false_empty_0:
            
            for _ in stride(from: 0, through: 19, by: 1) {
                let brItem = self.mkNoDateBrItem(.none)
                self.allBrItemsForCell.insert(brItem, at: 0)
            }
            let brItem1 = self.allBrItemsForCell[1]
            let brItem2 = self.allBrItemsForCell[2]
            let brItem3 = self.allBrItemsForCell[3]
            let brItem4 = self.allBrItemsForCell[4]
            let brItem5 = self.allBrItemsForCell[5]
            let brItem6 = self.allBrItemsForCell[6]
            let brItem7 = self.allBrItemsForCell[7]
            let brItem17 = self.allBrItemsForCell[17]
            let brItem27 = self.allBrItemsForCell[27]
            let brItem28 = self.allBrItemsForCell[28]
            let brItem29 = self.allBrItemsForCell[29]
            
            brItem5?.testItems = (brItem28?.testItems)!
            brItem5?.date = brItem28?.date
            brItem5?.cellGuildLine = .horizontal
            
            brItem6?.testItems = (brItem27?.testItems)!
            brItem6?.date = brItem27?.date
            brItem6?.cellGuildLine = .horizontal
            
            brItem7?.testItems = []
            brItem7?.date = nil
            brItem7?.cellGuildLine = .topRight
            
            brItem17?.testItems = []
            brItem17?.date = nil
            brItem17?.cellGuildLine = .vertical
            
            brItem27?.testItems = []
            brItem27?.date = nil
            brItem27?.cellGuildLine = .bottomRight
            
            brItem28?.testItems = []
            brItem28?.date = nil
            brItem28?.cellGuildLine = .none
            
            brItem29?.testItems = []
            brItem29?.date = nil
            brItem29?.cellGuildLine = .none
            
            brItem1?.cellGuildLine = .noneEmpty
            brItem2?.cellGuildLine = .noneEmpty
            brItem3?.cellGuildLine = .noneEmpty
            brItem4?.cellGuildLine = .noneEmpty
            
        case .reverse_true_empty_7:
            
            let brItem1 = self.allBrItemsForCell[1]
            let brItem2 = self.allBrItemsForCell[2]
            let brItem3 = self.allBrItemsForCell[3]
            let brItem4 = self.allBrItemsForCell[4]
            let brItem5 = self.allBrItemsForCell[5]
            let brItem6 = self.allBrItemsForCell[6]
            let brItem7 = self.allBrItemsForCell[7]
            let brItem8 = self.allBrItemsForCell[8]
            let brItem9 = self.allBrItemsForCell[9]
            let brItem17 = self.allBrItemsForCell[17]
            let brItem19 = self.allBrItemsForCell[19]
            let brItem27 = self.allBrItemsForCell[27]
            let brItem28 = self.allBrItemsForCell[28]
            let brItem29 = self.allBrItemsForCell[29]
            
            brItem4?.testItems = (brItem8?.testItems)!
            brItem4?.date = brItem8?.date
            brItem4?.cellGuildLine = .horizontal
            
            brItem5?.testItems = (brItem28?.testItems)!
            brItem5?.date = brItem28?.date
            brItem5?.cellGuildLine = .horizontal

            brItem6?.testItems = (brItem27?.testItems)!
            brItem6?.date = brItem27?.date
            brItem6?.cellGuildLine = .horizontal
            
            brItem7?.testItems = []
            brItem7?.date = nil
            brItem7?.cellGuildLine = .topRight
            
            brItem8?.testItems = []
            brItem8?.date = nil
            brItem8?.cellGuildLine = .none
            
            brItem9?.testItems = []
            brItem9?.date = nil
            brItem9?.cellGuildLine = .none
 
            brItem17?.testItems = []
            brItem17?.date = nil
            brItem17?.cellGuildLine = .vertical
            
            brItem19?.testItems = []
            brItem19?.date = nil
            brItem19?.cellGuildLine = .none
            
            brItem27?.testItems = []
            brItem27?.date = nil
            brItem27?.cellGuildLine = .bottomRight
            
            brItem28?.testItems = []
            brItem28?.date = nil
            brItem28?.cellGuildLine = .none
            
            brItem29?.testItems = []
            brItem29?.date = nil
            brItem29?.cellGuildLine = .none
            
            brItem1?.cellGuildLine = .noneEmpty
            brItem2?.cellGuildLine = .noneEmpty
            brItem3?.cellGuildLine = .noneEmpty
            
        case .reverse_true_empty_6:
            
            let brItem1 = self.allBrItemsForCell[1]
            let brItem2 = self.allBrItemsForCell[2]
            let brItem3 = self.allBrItemsForCell[3]
            let brItem4 = self.allBrItemsForCell[4]
            
            let brItem5 = self.allBrItemsForCell[5]
            let brItem6 = self.allBrItemsForCell[6]
            let brItem7 = self.allBrItemsForCell[7]
            let brItem8 = self.allBrItemsForCell[8]
            let brItem9 = self.allBrItemsForCell[9]
            let brItem18 = self.allBrItemsForCell[18]
            let brItem19 = self.allBrItemsForCell[19]
            let brItem28 = self.allBrItemsForCell[28]
            let brItem29 = self.allBrItemsForCell[29]
            
            brItem5?.testItems = (brItem7?.testItems)!
            brItem5?.date = brItem7?.date
            brItem5?.cellGuildLine = .horizontal
            
            brItem6?.testItems = (brItem28?.testItems)!
            brItem6?.date = brItem28?.date
            brItem6?.cellGuildLine = .horizontal
        
            brItem7?.testItems = (brItem28?.testItems)!
            brItem7?.date = brItem28?.date
            brItem7?.cellGuildLine = .horizontal
            
            brItem8?.testItems = []
            brItem8?.date = nil
            brItem8?.cellGuildLine = .topRight
            
            brItem9?.testItems = []
            brItem9?.date = nil
            brItem9?.cellGuildLine = .none
            
            brItem18?.testItems = []
            brItem18?.date = nil
            brItem18?.cellGuildLine = .vertical
            
            brItem19?.testItems = []
            brItem19?.date = nil
            brItem19?.cellGuildLine = .none

            brItem28?.testItems = []
            brItem28?.date = nil
            brItem28?.cellGuildLine = .bottomRight
            
            brItem29?.testItems = []
            brItem29?.date = nil
            brItem29?.cellGuildLine = .none
            
            brItem1?.cellGuildLine = .noneEmpty
            brItem2?.cellGuildLine = .noneEmpty
            brItem3?.cellGuildLine = .noneEmpty
            brItem4?.cellGuildLine = .noneEmpty
            
            
        case .reverse_true_empty_5:
            
            let brItem1 = self.allBrItemsForCell[1]
            let brItem2 = self.allBrItemsForCell[2]
            let brItem3 = self.allBrItemsForCell[3]
            let brItem4 = self.allBrItemsForCell[4]
            let brItem5 = self.allBrItemsForCell[5]
            let brItem6 = self.allBrItemsForCell[6]
            let brItem7 = self.allBrItemsForCell[7]
            let brItem8 = self.allBrItemsForCell[8]
            let brItem9 = self.allBrItemsForCell[9]
            let brItem18 = self.allBrItemsForCell[18]
            let brItem19 = self.allBrItemsForCell[19]
            let brItem28 = self.allBrItemsForCell[28]
            let brItem29 = self.allBrItemsForCell[29]
            
            brItem4?.testItems = (brItem6?.testItems)!
            brItem4?.date = brItem6?.date
            brItem4?.cellGuildLine = .horizontal
            
            brItem5?.testItems = (brItem7?.testItems)!
            brItem5?.date = brItem7?.date
            brItem5?.cellGuildLine = .horizontal
            
            brItem6?.testItems = (brItem8?.testItems)!
            brItem6?.date = brItem8?.date
            brItem6?.cellGuildLine = .horizontal
            
            brItem7?.testItems = (brItem28?.testItems)!
            brItem7?.date = brItem28?.date
            brItem7?.cellGuildLine = .horizontal
            
            brItem8?.testItems = []
            brItem8?.date = nil
            brItem8?.cellGuildLine = .topRight
            
            brItem9?.testItems = []
            brItem9?.date = nil
            brItem9?.cellGuildLine = .none
            
            brItem18?.testItems = []
            brItem18?.date = nil
            brItem18?.cellGuildLine = .vertical
            
            brItem19?.testItems = []
            brItem19?.date = nil
            brItem19?.cellGuildLine = .none
            
            brItem28?.testItems = []
            brItem28?.date = nil
            brItem28?.cellGuildLine = .bottomRight
            
            brItem29?.testItems = []
            brItem29?.date = nil
            brItem29?.cellGuildLine = .none
            
            brItem1?.cellGuildLine = .noneEmpty
            brItem2?.cellGuildLine = .noneEmpty
            brItem3?.cellGuildLine = .noneEmpty
            
        case .reverse_true_empty_4:
            let brItem1 = self.allBrItemsForCell[1]
            let brItem2 = self.allBrItemsForCell[2]
            let brItem3 = self.allBrItemsForCell[3]
            let brItem4 = self.allBrItemsForCell[4]
            
            brItem1?.cellGuildLine = .noneEmpty
            brItem2?.cellGuildLine = .noneEmpty
            brItem3?.cellGuildLine = .noneEmpty
            brItem4?.cellGuildLine = .noneEmpty
            
        case .reverse_true_empty_3:
            let brItem1 = self.allBrItemsForCell[1]
            let brItem2 = self.allBrItemsForCell[2]
            let brItem3 = self.allBrItemsForCell[3]
            
            brItem1?.cellGuildLine = .noneEmpty
            brItem2?.cellGuildLine = .noneEmpty
            brItem3?.cellGuildLine = .noneEmpty
            
        case .reverse_true_empty_2:
            
            for _ in stride(from: 0, through: 19, by: 1) {
                let brItem = self.mkNoDateBrItem(.none)
                self.allBrItemsForCell.insert(brItem, at: 0)
                
            }
            let brItem3 = self.allBrItemsForCell[3]
            let brItem4 = self.allBrItemsForCell[4]
            let brItem5 = self.allBrItemsForCell[5]
            let brItem6 = self.allBrItemsForCell[6]
            let brItem7 = self.allBrItemsForCell[7]
            let brItem8 = self.allBrItemsForCell[8]
            let brItem13 = self.allBrItemsForCell[13]
            let brItem23 = self.allBrItemsForCell[23]
            
            brItem4?.testItems = (brItem23?.testItems)!
            brItem4?.date = brItem23?.date
            brItem4?.cellGuildLine = .horizontal
            
            brItem3?.testItems = []
            brItem3?.date = nil
            brItem3?.cellGuildLine = .topLeft
            
            brItem13?.testItems = []
            brItem13?.date = nil
            brItem13?.cellGuildLine = .vertical
            
            brItem23?.testItems = []
            brItem23?.date = nil
            brItem23?.cellGuildLine = .bottomLeft
            
            brItem5?.cellGuildLine = .noneEmpty
            brItem6?.cellGuildLine = .noneEmpty
            brItem7?.cellGuildLine = .noneEmpty
            brItem8?.cellGuildLine = .noneEmpty
            
        case .reverse_true_empty_1:
            
            for _ in stride(from: 0, through: 19, by: 1) {
                let brItem = self.mkNoDateBrItem(.none)
                self.allBrItemsForCell.insert(brItem, at: 0)
                
            }
            let brItem3 = self.allBrItemsForCell[3]
            let brItem4 = self.allBrItemsForCell[4]
            let brItem5 = self.allBrItemsForCell[5]
            let brItem6 = self.allBrItemsForCell[6]
            let brItem7 = self.allBrItemsForCell[7]
            let brItem8 = self.allBrItemsForCell[8]
            let brItem13 = self.allBrItemsForCell[13]
            let brItem22 = self.allBrItemsForCell[22]
            let brItem23 = self.allBrItemsForCell[23]
            let brItem29 = self.allBrItemsForCell[29]
            
            brItem5?.testItems = (brItem22?.testItems)!
            brItem5?.date = brItem22?.date
            brItem5?.cellGuildLine = .horizontal
            
            brItem4?.testItems = (brItem23?.testItems)!
            brItem4?.date = brItem23?.date
            brItem4?.cellGuildLine = .horizontal
            
            brItem3?.testItems = []
            brItem3?.date = nil
            brItem3?.cellGuildLine = .topLeft
            
            brItem13?.testItems = []
            brItem13?.date = nil
            brItem13?.cellGuildLine = .vertical
            
            brItem22?.testItems = []
            brItem22?.date = nil
            brItem22?.cellGuildLine = .none
            
            brItem23?.testItems = []
            brItem23?.date = nil
            brItem23?.cellGuildLine = .bottomLeft
            
            brItem29?.testItems = []
            brItem29?.date = nil
            brItem29?.cellGuildLine = .topRight
            
            brItem6?.cellGuildLine = .noneEmpty
            brItem7?.cellGuildLine = .noneEmpty
            brItem8?.cellGuildLine = .noneEmpty
            
        case .reverse_true_empty_0:
            
            for _ in stride(from: 0, through: 19, by: 1) {
                let brItem = self.mkNoDateBrItem(.none)
                self.allBrItemsForCell.insert(brItem, at: 0)
                
            }
            let brItem2 = self.allBrItemsForCell[2]
            let brItem3 = self.allBrItemsForCell[3]
            let brItem4 = self.allBrItemsForCell[4]
            let brItem5 = self.allBrItemsForCell[5]
            let brItem6 = self.allBrItemsForCell[6]
            let brItem7 = self.allBrItemsForCell[7]
            let brItem8 = self.allBrItemsForCell[8]
            let brItem12 = self.allBrItemsForCell[12]
            let brItem20 = self.allBrItemsForCell[20]
            let brItem21 = self.allBrItemsForCell[21]
            let brItem22 = self.allBrItemsForCell[22]
            let brItem29 = self.allBrItemsForCell[29]
            
            brItem4?.testItems = (brItem21?.testItems)!
            brItem4?.date = brItem21?.date
            brItem4?.cellGuildLine = .horizontal
            
            brItem3?.testItems = (brItem22?.testItems)!
            brItem3?.date = brItem22?.date
            brItem3?.cellGuildLine = .horizontal
            
            brItem2?.testItems = []
            brItem2?.date = nil
            brItem2?.cellGuildLine = .topLeft
            
            brItem12?.testItems = []
            brItem12?.date = nil
            brItem12?.cellGuildLine = .vertical
            
            brItem20?.testItems = []
            brItem20?.date = nil
            brItem20?.cellGuildLine = .none
            
            brItem21?.testItems = []
            brItem21?.date = nil
            brItem21?.cellGuildLine = .none
            
            brItem22?.testItems = []
            brItem22?.date = nil
            brItem22?.cellGuildLine = .bottomLeft
            
            brItem5?.cellGuildLine = .noneEmpty
            brItem6?.cellGuildLine = .noneEmpty
            brItem7?.cellGuildLine = .noneEmpty
            brItem8?.cellGuildLine = .noneEmpty
            brItem29?.cellGuildLine = .topRight
        default:
            print("XXX")
        }
        
    }
    


}

extension Date {
    struct Gregorian {
        static let calendar = Calendar(identifier: .gregorian)
    }
    var startOfWeek: Date? {
        return Gregorian.calendar.date(from: Gregorian.calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
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


extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
