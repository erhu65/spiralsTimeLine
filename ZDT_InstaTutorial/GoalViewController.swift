//
//  GoalViewController.swift
//  V1
//
//  Created by Eric on 2017/3/28.
//  Copyright © 2017年 Eric. All rights reserved.
//

import UIKit
import CoreData

enum GoalError: Error {
    case TypeNameInvalid(String)
}

enum TopVDateAlignType: UInt32 {
    case Right = 0
    case Left = 1
}

enum TopVDailyType: UInt32 {
    case None = 0
    case Collapsed = 1
    case Unfolded = 2
}

enum TopVDailyBleedingType: UInt32 {
    case None = 0
    case Bleeding = 1
    case EndBleeding = 2
}

enum TopVDailySEXType: UInt32 {
    case None = 0
    case Show = 1
}

enum GoalFilterType: UInt32 {
    case Male = 0
    case Female = 1
    case Both = 2
}



enum GenderType: UInt32 {
    case male = 1
    case female = 0
}

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

class GoalViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var topV: UIView!
    @IBOutlet weak var popV: UIView!
    @IBOutlet weak var bottomV: UIView!
    
    
    @IBOutlet weak var rightV: UIView!
    //@IBOutlet weak var popLb: UILabel!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!

    @IBOutlet weak var collectionView: UICollectionView!
    

    @IBOutlet weak var popVLeading: NSLayoutConstraint!

    @IBOutlet weak var popVTop: NSLayoutConstraint!
    
    @IBOutlet weak var popMenu1Height: NSLayoutConstraint!
    @IBOutlet weak var popMenu1LeftPadding: NSLayoutConstraint!
    @IBOutlet weak var popMenu1RightPadding: NSLayoutConstraint!
    @IBOutlet weak var popMenu2Height: NSLayoutConstraint!
    @IBOutlet weak var popMenu2LeftPadding: NSLayoutConstraint!
    @IBOutlet weak var popMenu2RightPadding: NSLayoutConstraint!
    @IBOutlet weak var popMenu2Top: NSLayoutConstraint!
    @IBOutlet weak var popMenu3Height: NSLayoutConstraint!
    @IBOutlet weak var popMenu3LeftPadding: NSLayoutConstraint!
    @IBOutlet weak var popMenu3RightPadding: NSLayoutConstraint!
    @IBOutlet weak var popMenu3Top: NSLayoutConstraint!
    @IBOutlet weak var popMenu4Height: NSLayoutConstraint!
    @IBOutlet weak var popMenu4LeftPadding: NSLayoutConstraint!
    @IBOutlet weak var popMenu4RightPadding: NSLayoutConstraint!
    @IBOutlet weak var popMenu4Top: NSLayoutConstraint!
    @IBOutlet weak var popMenu5Height: NSLayoutConstraint!
    @IBOutlet weak var popMenu5LeftPadding: NSLayoutConstraint!
    @IBOutlet weak var popMenu5RightPadding: NSLayoutConstraint!
    @IBOutlet weak var popMenu5Top: NSLayoutConstraint!
    @IBOutlet weak var popMenu6Height: NSLayoutConstraint!
    @IBOutlet weak var popMenu6LeftPadding: NSLayoutConstraint!
    @IBOutlet weak var popMenu6RightPadding: NSLayoutConstraint!
    @IBOutlet weak var popMenu6Top: NSLayoutConstraint!
    @IBOutlet weak var popMenu7Height: NSLayoutConstraint!
    @IBOutlet weak var popMenu7LeftPadding: NSLayoutConstraint!
    @IBOutlet weak var popMenu7RightPadding: NSLayoutConstraint!
    @IBOutlet weak var popMenu7Top: NSLayoutConstraint!
    
    let popMenuItemHeight:CGFloat = 35
    let popMenuItemTop:CGFloat = 4
    
    @IBOutlet weak var testWidthLb: UILabel!
    @IBOutlet weak var popVWidth: NSLayoutConstraint!
    
    var currentIndex:Int = -1
    var maxDateHasTestItems:Date? = nil
    let numberOfColumns:CGFloat = 10
    var allBrItemsForCell:[BRItem?] = []
    var collectionViewLayout: CustomImageFlowLayout!
    
    var currentLoginGender:GenderType = .female
    var currentAnchorXY:CGPoint?
    var currentBrItem:BRItem?
    var goalMenuItems:[GoalMenuItem] = []
    
    var maleGoals = [GoalMO]()
    var femaleGoals = [GoalMO]()
    
    var topVDateAlignType: TopVDateAlignType = .Left
    var topVDailyType: TopVDailyType = .None
    var topVDailyBleedingType: TopVDailyBleedingType = .None
    var topVDailySEXType: TopVDailySEXType = .None
    var goalFilterType: GoalFilterType = .Both
    
    @IBOutlet weak var menu1: UIView!
    @IBOutlet weak var menuLb1: UILabel!
    @IBOutlet weak var menu2: UIView!
    @IBOutlet weak var menuLb2: UILabel!
    @IBOutlet weak var menu3: UIView!
    @IBOutlet weak var menuLb3: UILabel!
    @IBOutlet weak var menu4: UIView!
    @IBOutlet weak var menuLb4: UILabel!
    @IBOutlet weak var menu5: UIView!
    @IBOutlet weak var menuLb5: UILabel!
    @IBOutlet weak var menu6: UIView!
    @IBOutlet weak var menuLb6: UILabel!
    @IBOutlet weak var menu7: UIView!
    @IBOutlet weak var menuLb7: UILabel!
    
    var popMenuArr = [[String:Any]]()
    @IBOutlet weak var fadeV: UIView!
   
    @IBOutlet weak var startTf: UITextField!
    
    @IBOutlet weak var endTf: UITextField!
    
    @IBOutlet weak var adjustSwitcher: UISwitch!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let menu1:[String : Any] = ["menu": self.menu1, "leftPadding": self.popMenu1LeftPadding, "rightPadding": self.popMenu1RightPadding, "lb": self.menuLb1]
        let menu2:[String : Any] = ["menu": self.menu2, "leftPadding": self.popMenu2LeftPadding, "rightPadding": self.popMenu2RightPadding, "lb": self.menuLb2]
        let menu3:[String : Any] = ["menu": self.menu3, "leftPadding": self.popMenu3LeftPadding, "rightPadding": self.popMenu3RightPadding, "lb": self.menuLb3]
        let menu4:[String : Any] = ["menu": self.menu4, "leftPadding": self.popMenu4LeftPadding, "rightPadding": self.popMenu4RightPadding, "lb": self.menuLb4]
        let menu5:[String : Any] = ["menu": self.menu5, "leftPadding": self.popMenu5LeftPadding, "rightPadding": self.popMenu5RightPadding, "lb": self.menuLb5]
        let menu6:[String : Any] = ["menu": self.menu6, "leftPadding": self.popMenu6LeftPadding, "rightPadding": self.popMenu6RightPadding, "lb": self.menuLb6]
        let menu7:[String : Any] = ["menu": self.menu7, "leftPadding": self.popMenu7LeftPadding, "rightPadding": self.popMenu7RightPadding, "lb": self.menuLb7]
        
        self.popMenuArr.append(menu1)
        self.popMenuArr.append(menu2)
        self.popMenuArr.append(menu3)
        self.popMenuArr.append(menu4)
        self.popMenuArr.append(menu5)
        self.popMenuArr.append(menu6)
        self.popMenuArr.append(menu7)
    
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "eeee, MMMM d"
        let dateString = formatter.string(from: date)
        dateLabel.text = dateString
        
        collectionViewLayout = CustomImageFlowLayout()
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action:#selector(hidePopMenu))
        self.fadeV.addGestureRecognizer(tap)
        
//        V1Model.sharedInstance.coreDataManager.fetchGoal { [unowned self] (goals) in
//            guard goals != nil else {
//                return
//            }
//            
//            for goal in goals! {
//                print("goal date : \(goal.date)")
//                
//                let aGoal = goal as GoalMO
//                let goalItems = aGoal.goalItem
//                
//                for goalItem in goalItems! {
//                    let aGoalItem = goalItem as! GoalItemMO
//                    print("aGoalItem typeName : \(aGoalItem.typeName!)")
//                    print("aGoalItem value : \(aGoalItem.value)")
//                    print("aGoalItem reminderDate : \(aGoalItem.reminderDate!)")
//                }
//            }
//            
//            DispatchQueue.main.async { [unowned self] in
//                self.maleGoals = goals!
//                self.render(maleGoals: self.maleGoals, femaleGoals: self.femaleGoals, loginGender: .male)
//            }
//        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
//        self.view.layoutIfNeeded()
        self.hidePopMenu()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        if parent == nil {
            
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func filterAction(_ sender: UIButton) {
        self.hidePopMenu()
        sender.isSelected = !sender.isSelected;
        
        var maleGoals:[GoalMO] = []
        var femaleGoals:[GoalMO] = []
        
        let dateNow = Date()
        //make fake Core Data GoalMO and GoalItemMO Object
        let startIndex = Int(self.startTf.text!)
        let endIndex = Int(self.endTf.text!)
        for idx in stride(from: startIndex!, through: endIndex!, by: -1) {
            
            let date = Date(timeIntervalSinceNow: TimeInterval(60*60*24*idx))
            
            let random1 = arc4random_uniform(11) + 5;
            if random1 == 5
                ||  random1 == 6
                ||  random1 == 7
                ||  random1 == 8
                ||  random1 == 9
                ||  random1 == 10
                ||  random1 == 11
                ||  random1 == 12 {
                //craete male goal
                let goal = GoalMO()
                goal.date = date
                
                let goalItem = GoalItemMO()
                goalItem.typeName = "Sperm"
                goalItem.testItemCid = "\(random1)"
                goalItem.value = GoalItemMO.mkRandomSpermValue()
                if date > dateNow {
                    goalItem.value = nil
                }
                goal.goalItems.append(goalItem)
                
                if random1 == 6
                    ||  random1 == 7
                    ||  random1 == 8
                    ||  random1 == 9 {
                    let goalItem = GoalItemMO()
                    goalItem.typeName = "SEX"
                    goalItem.testItemCid = "\(random1)"
                    goalItem.value = GoalItemMO.mkRandomSEXValue()
                    goal.goalItems.append(goalItem)
                }
                
                maleGoals.append(goal)
            }
            
            //craete female goal
            let goal = GoalMO()
            goal.date = date
            
            
            //add BBT everyday forcefully
            let goalItem = GoalItemMO()
            goalItem.typeName = "BBT"
            goalItem.value = [["type": "BBT", "typeValue": 0.1]]
            let diceRoll2 = Int(arc4random_uniform(3) + 1)
            if diceRoll2 == 1 {
                goalItem.value = nil
            }
            if date > dateNow {
                goalItem.value = nil
            }
            goal.goalItems.append(goalItem)
            
            let random2 = arc4random_uniform(11) + 5;
            if random2 == 5
                ||  random2 == 6
                ||  random2 == 7
                ||  random2 == 8{
                
                let random6 = arc4random_uniform(5);
                if random6 == 0
                    ||  random6 == 1
                    ||  random6 == 2 {
                    
                    let goalItem = GoalItemMO.mkRandomFemaleGoalItem(originalGoalItems: goal.goalItems)
                    if date > dateNow {
                        goalItem.value = nil
                    }
                    goal.goalItems.append(goalItem)
                }
                
                let random7 = arc4random_uniform(5);
                if random7 == 0
                    ||  random7 == 1
                    ||  random7 == 2 {
                    
                    let goalItem = GoalItemMO.mkRandomFemaleGoalItem(originalGoalItems: goal.goalItems)
                    if date > dateNow {
                        goalItem.value = nil
                    }
                    goal.goalItems.append(goalItem)
                }
                
            }

            femaleGoals.append(goal)
        }

//        femaleGoals = []
//        maleGoals = []
//        let strTime = "2017-05-21 19:29:50 +0000"
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
//        let firstDate = formatter.date(from: strTime) // Returns "Jul 27, 2015, 12:29 PM" PST
//        
//        for idx in stride(from: 0, through: 3, by: 1) {
//            let date = firstDate?.addingTimeInterval(TimeInterval(60*60*24*7*idx))
//            let goal = GoalMO()
//            //print("date: \(date)")
//            //let currentDate = Calendar.current.date(byAdding: .day, value: 7 * idx, to: firstDate!)!
//            goal.date = date
//            let goalItem = GoalItemMO()
//            goalItem.typeName = "Sperm"
//            goalItem.testItemCid = "cid1"
//            goalItem.value = GoalItemMO.mkRandomSpermValue()
//            goal.goalItems.append(goalItem)
//            maleGoals.append(goal)
//        }
//        
        self.render(maleGoals: maleGoals, femaleGoals: femaleGoals, loginGender: .male)
        
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let rowIndex = indexPath.row
        
        var itemWidth = (self.collectionView!.frame.width - (self.numberOfColumns)) / self.numberOfColumns
        var itemHeight:CGFloat = 0.0
        
        let barItem = self.allBrItemsForCell[rowIndex]
        barItem?.serial = rowIndex
        
        itemHeight = itemWidth;
        if let  brdate = barItem?.date {
            let calendar = Calendar.current
            let isToday = calendar.isDateInToday(brdate)
            if(isToday){
                itemWidth *= 2
            }
        }
        
        if (barItem?.isEmptyRow)! {
            itemHeight = 5
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

            let isToday = calendar.isDateInToday(barItemDate)
            if isToday {
                
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
        print("rowIndex-------: \(rowIndex)")
        print("cellGuildLine-------: \(cellGuidLine)")
        
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
            let valueArr = testItem.value;
            
            switch testItem.type! {
                
            case .Sperm:
                if let valueArrUnWrap = valueArr {
                    let concentrationDict = valueArrUnWrap[0]
                    let concentration = concentrationDict["typeValue"]
                    let motilityDict = valueArrUnWrap[1];
                    let motility = motilityDict["typeValue"]
                    let morphologyDict = valueArrUnWrap[2];
                    let morphology = morphologyDict["typeValue"]
                    valStr = "Sperm:\(concentration!), \(motility!), \(morphology!)"
                } else {
                    valStr = "Sperm:"
                }
            case .LH:
                if let valueArrUnWrap = valueArr {
                    let valDict = valueArrUnWrap[0]
                    let value = valDict["typeValue"]
                    valStr = "LH:\(value!)"
                } else {
                    valStr = "LH:"
                }
                
            case .HCG:
                if let valueArrUnWrap = valueArr {
                    let valDict = valueArrUnWrap[0]
                    let value = valDict["typeValue"]
                    valStr = "HCG:\(value!)"
                } else {
                    valStr = "HCG:"
                }
            case .FSH:
                if let valueArrUnWrap = valueArr {
                    let valDict = valueArrUnWrap[0]
                    let value = valDict["typeValue"]
                    valStr = "FSH:\(value!)"
                } else {
                    valStr = "FSH:"
                }
            case .SEX:
                if let valueArrUnWrap = valueArr {
                    let valDict = valueArrUnWrap[0]
                    let value = valDict["typeValue"]
                    valStr = "SEX:\(value!)"
                } else {
                    valStr = "SEX:"
                }
            case .BBT:
                if let valueArrUnWrap = valueArr {
                    let valDict = valueArrUnWrap[0]
                    let value = valDict["typeValue"]
                    valStr = "BBT:\(value!)"
                } else {
                    valStr = "BBT:"
                }
            case .Bleeding:
                if let valueArrUnWrap = valueArr {
                    let valDict = valueArrUnWrap[0]
                    let value = valDict["typeValue"]
                    valStr = "Bleeding:\(value!)"
                } else {
                    valStr = "Bleeding:"
                }            }
            
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
        print("testValStrs: \(testValStrs)")
        
        //x:\(cellFrameInSuperview.origin.x),y:\(cellFrameInSuperview.origin.y
        
        
        //self.popV.layer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        let attributes = collectionView.layoutAttributesForItem(at: indexPath)
        let cellRect = attributes?.frame;
        let cellFrameInSuperview = collectionView.convert(cellRect!, to: collectionView.superview)
        let anchorXY = CGPoint(x: cellFrameInSuperview.origin.x , y: (cellFrameInSuperview.origin.y - 10))
        self.currentAnchorXY = anchorXY
        self.currentBrItem = barItem
//        print("anchorXY.x: \(anchorXY.x)")
//        print("anchorXY.y: \(anchorXY.y)")

        self.topVDailyType = .None
        self.topVDailyBleedingType = .None
        self.topVDailySEXType = .None
    
//        print("barItem?.maleGoalCid: \(String(describing: barItem?.maleGoalCid))")
//        print("barItem?.maleTestItems: \(String(describing: barItem?.maleTestItems))")
//        print("barItem?.femaleGoalCid: \(String(describing: barItem?.femaleGoalCid))")
//        print("barItem?.femaleTestItems: \(String(describing: barItem?.femaleTestItems))")

        self.adjustTopVPosition(anchorXY: self.currentAnchorXY!, brItem: self.currentBrItem!, gender: self.currentLoginGender)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        self.hidePopMenu()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.hidePopMenu()
        
    }
    
    // MARK: - 
    
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
    
    func render(maleGoals:[GoalMO], femaleGoals:[GoalMO], loginGender:GenderType) {
        
        let isGetMale = self.maleBtn.isSelected
        let isGetFemale = self.femaleBtn.isSelected
        
        print("isGetMale:\(isGetMale)")
        print("isGetFemale:\(isGetFemale)")
        
        var maxDate:Date? = nil
        var minDate:Date? = nil
        
        if isGetMale && isGetFemale {
            self.goalFilterType = .Both
        } else if !isGetMale && isGetFemale {
            self.goalFilterType = .Female
        } else if isGetMale && !isGetFemale {
            self.goalFilterType = .Male
        }
        
        if isGetMale {
            //let maleGoalsCount = maleGoals.count
            for (idx, goal ) in maleGoals.enumerated() {
                let date = goal.date! as Date
                let goalItems = goal.goalItems
                
                if maxDate == nil {
                    maxDate = date
                } else {
                    if date >  maxDate! {
                        maxDate = date
                    }
                }
                
                if minDate == nil {
                    minDate = date
                } else {
                    if date <  minDate! {
                        minDate = date
                    }
                }
                
                
                if idx == 0 || (idx == maleGoals.count - 1) {
                    let dateStr = self.formatLocalDate("male:\(idx)", date)
                    print(dateStr)
                }
            }
            
        }
        
        if isGetFemale {
            //let femaleGoalsCount = femaleGoals.count
            for (idx, goal ) in femaleGoals.enumerated() {
                let date = goal.date! as Date
                let goalItems = goal.goalItems
                
                if maxDate == nil {
                    maxDate = date
                } else {
                    if date >  maxDate! {
                        maxDate = date
                    }
                }
                
                if minDate == nil {
                    minDate = date
                } else {
                    if date <  minDate! {
                        minDate = date
                    }
                }
                
                if idx == 0 || (idx == femaleGoals.count - 1) {
                    let dateStr = self.formatLocalDate("female:\(idx)", date)
                    print(dateStr)
                }                
            }
        }
        
        if maxDate != nil {
            let dateStr = self.formatLocalDate("maxDate", maxDate!)
            print(dateStr)
        }
        
        if minDate != nil {
            let dateStr = self.formatLocalDate("minDate", minDate!)
            print(dateStr)
            
        }
        
        var allBrItems:[BRItem?] = []
        
        if minDate == nil {
            self.reloadByBrItems(allBrItems: allBrItems.reversed())
            return
        }
        
        var everyDate:Date = minDate!
        var intervalDay = 0
        
        while everyDate <=  maxDate! {
            everyDate = Date(timeInterval: TimeInterval(60*60*24*intervalDay), since: minDate!)
            
            let brItem = BRItem()
            brItem.date = everyDate
            if isGetMale {
                for (_, goal) in maleGoals.enumerated() {
                    let date = goal.date! as Date
                    brItem.maleGoalCid = goal.cid
                    let isSameDate = Calendar.current.isDate(date, inSameDayAs:everyDate)
                    if isSameDate {
                        let goalItems = goal.goalItems
                        for aGoalItem in goalItems {
                            let goalItem = aGoalItem as! GoalItemMO
                            let type = goalItem.typeName
                            let value = goalItem.value
                            let testItemCid = goalItem.testItemCid
                            let reminderDate = goalItem.reminderDate
                            let testItem = TestItem()
                            testItem.gender = .male
                            testItem.reminderDate = reminderDate
                            do {
                                switch type! {
                                case "Sperm":
                                    testItem.type = .Sperm
                                case "SEX":
                                    testItem.type = .SEX
                                default:
                                    throw GoalError.TypeNameInvalid("not valid male typeName")
                                }
                            } catch {
                                print(error)
                            }
                            
                            testItem.value = value as? [[String : Any]]
                            testItem.testItemCid = testItemCid
                            brItem.addTestItem(testItem: testItem)
                            brItem.maleTestItems.append(testItem)
                            
                        }
                    }
                }
                
            }
            
            if isGetFemale {
                for (_, goal) in femaleGoals.enumerated() {
                    let date = goal.date! as Date
                    brItem.femaleGoalCid = goal.cid
                    let isSameDate = Calendar.current.isDate(date, inSameDayAs:everyDate)
                    if isSameDate {
                        let goalItems = goal.goalItems
                        for aGoalItem in goalItems {
                            let goalItem = aGoalItem as! GoalItemMO
                            let type = goalItem.typeName
                            let value = goalItem.value
                            let testItemCid = goalItem.testItemCid
                            let reminderDate = goalItem.reminderDate
                            let testItem = TestItem()
                            testItem.gender = .female
                            testItem.reminderDate = reminderDate
                            do {
                                switch type! {
                                case "LH":
                                    testItem.type = .LH
                                case "HCG":
                                    testItem.type = .HCG
                                case "FSH":
                                    testItem.type = .FSH
                                case "SEX":
                                    testItem.type = .SEX
                                case "BBT":
                                    testItem.type = .BBT
                                case "Bleeding":
                                    testItem.type = .Bleeding
                                default:
                                    throw GoalError.TypeNameInvalid("not valid female typeName")
                                }
                            } catch {
                                print(error)
                            }

                            testItem.value = value as? [[String : Any]]
                            testItem.testItemCid = testItemCid
                            brItem.addTestItem(testItem: testItem)
                            brItem.femaleTestItems.append(testItem)
                        }
                    }
                }
            }
            
            brItem.reOrderTestItems(currentLoginGender: self.currentLoginGender)
            allBrItems.append(brItem)
            
            //            let dateStr = self.formatLocalDate("everyDate", everyDate)
            //            print(dateStr)
            intervalDay += 1
        }
        
        for (_, brItem ) in allBrItems.reversed().enumerated() {
            let dateChk = brItem?.date
            let dateStr = self.formatLocalDate("brItem", dateChk!)
            print(dateStr)
            let testItems = brItem?.testItems
            for (_, testItem) in (testItems?.enumerated())! {
                let type = testItem.type
                let gender = testItem.gender
                let testItemCid = testItem.testItemCid
                let value = testItem.value
                print("....\(type):\(gender):\(testItemCid):\(value)")
            }
        }
        
        self.reloadByBrItems(allBrItems: allBrItems.reversed())
    }

    func reloadByBrItems(allBrItems:[BRItem?])  {
        self.allBrItemsForCell.removeAll()
        
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
        //let the_2th_day_this_week =  Date(timeInterval: 60*60*24*1, since: the_1th_day_this_week!)
        //let the_3th_day_this_week =  Date(timeInterval: 60*60*24*2, since: the_1th_day_this_week!)
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
                    brItemPlaceHolder?.maleGoalCid = (brItem?.maleGoalCid)!
                    brItemPlaceHolder?.maleTestItems = (brItem?.maleTestItems)!
                    brItemPlaceHolder?.femaleGoalCid = (brItem?.femaleGoalCid)!
                    brItemPlaceHolder?.femaleTestItems = (brItem?.femaleTestItems)!
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
//        let isSameDate = Calendar.current.isDate(the_3th_day_this_week, inSameDayAs:Date())
//        
//        print("startDateOfThisWeek:\(self.formatLocalDate("", the_2th_day_this_week))")
//        print("isSameDate:\(isSameDate)")
        
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
        //get the current date rowIndex
        for (idx, brItem ) in self.allBrItemsForCell.enumerated() {
            if let date = brItem?.date {
                let isCurrentDate = Calendar.current.isDate(date, inSameDayAs:Date())
                if(isCurrentDate){
                    self.currentIndex = idx
                }
            }
        }
        print("self.currentIndex before adjust: \(self.currentIndex)")
        
        print("adjustCellArrangement:\(adjustCellArrangement)")
        if self.currentIndex > 28 {
                self.adjustCellArrangement(pattern: adjustCellArrangement)
        } else {
                print("adjustCellArrangement current date")
            
            self.maxDateHasTestItems = nil
            //find the max date that has testItems
            for brItem in self.allBrItemsForCell {
               
                if let date = brItem?.date  {
                    if (brItem?.testItems.count)! > 0 {
                        
                        if self.maxDateHasTestItems == nil {
                            self.maxDateHasTestItems = date
                        } else if date > self.maxDateHasTestItems! {
                            self.maxDateHasTestItems = date
                        }
                    }


                }
            }
            if self.maxDateHasTestItems == nil {
                return
            }
            let maxDateHasTestItemsStr = self.formatLocalDate("maxDateHasTestItems:", self.maxDateHasTestItems!)
            print(maxDateHasTestItemsStr)
            
            if self.currentIndex < 8 {
              //current date happen in 1th non-empty ro2
                for (idx, brItem ) in self.allBrItemsForCell.enumerated() {
                    if idx >= 0 && idx <= 8 {

                        if brItem?.cellGuildLine == .topRight
                            ||  brItem?.cellGuildLine == .topLeft {
                            continue
                        }
                        if let date = brItem?.date {
                            if let maxDate = self.maxDateHasTestItems {
                                if date > maxDate {
                                    brItem?.cellGuildLine = .noneEmpty
                                }
                            } else {
                                let curentnBrItem = self.allBrItemsForCell[self.currentIndex]
                                if  let maxDate = curentnBrItem?.date {
                                    if date > maxDate {
                                        brItem?.cellGuildLine = .noneEmpty
                                    }
                                }
                            }
                          
                        } else {
                            brItem?.cellGuildLine = .noneEmpty
                        }
                        
                    }
                    
                }
            } else {
                //current date happen in 3th non-empty row
                for (idx, brItem ) in self.allBrItemsForCell.enumerated() {
                    if idx >= 0 && idx <= 9 {
                        if brItem?.date != nil {
                            continue
                        }
                        if brItem?.cellGuildLine == .topRight
                            ||  brItem?.cellGuildLine == .topLeft {
                            continue
                        }
                        
                        brItem?.cellGuildLine = .noneEmpty
                    }
               
                }
                
                
                
            }
        
        }

        
        
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
        print("self.currentIndex after adjust: \(self.currentIndex)")
        
        self.collectionView.reloadData()
        
        if self.currentIndex != -1 {
            let indexPath = IndexPath(row: self.currentIndex, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
            
        }
        
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
        //return
        //TODO:future less than 3 rows, another Algorithm
        if adjustSwitcher.isOn == false {
            return
        }
    
        
        do {
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
                //return
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
                print("adjustCellArrangement not work")
            }

        } catch {
            print("adjustCellArrangement exception")
        }
        
        let brItem10 = self.allBrItemsForCell[10]
        let brItem11 = self.allBrItemsForCell[11]
        let brItem12 = self.allBrItemsForCell[12]
        let brItem13 = self.allBrItemsForCell[13]
        let brItem14 = self.allBrItemsForCell[14]
        let brItem15 = self.allBrItemsForCell[15]
        let brItem16 = self.allBrItemsForCell[16]
        let brItem17 = self.allBrItemsForCell[17]
        let brItem18 = self.allBrItemsForCell[18]
        let brItem19 = self.allBrItemsForCell[19]
        brItem10?.isEmptyRow = true
        brItem11?.isEmptyRow = true
        brItem12?.isEmptyRow = true
        brItem13?.isEmptyRow = true
        brItem14?.isEmptyRow = true
        brItem15?.isEmptyRow = true
        brItem16?.isEmptyRow = true
        brItem17?.isEmptyRow = true
        brItem18?.isEmptyRow = true
        brItem19?.isEmptyRow = true
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func adjustPopVHeightByTestItemsCount(showItemsCount:Int) {
        
        self.popMenu1Height.constant = 0
        self.popMenu2Height.constant = 0
        self.popMenu2Top.constant = 0
        self.popMenu3Height.constant = 0
        self.popMenu3Top.constant = 0
        self.popMenu4Height.constant = 0
        self.popMenu4Top.constant = 0
        self.popMenu5Height.constant = 0
        self.popMenu5Top.constant = 0
        self.popMenu6Height.constant = 0
        self.popMenu6Top.constant = 0
        self.popMenu7Height.constant = 0
        self.popMenu7Top.constant = 0
        
        switch showItemsCount {
        case 2:
            self.popMenu1Height.constant = self.popMenuItemHeight
            self.popMenu2Height.constant = self.popMenuItemHeight
            self.popMenu2Top.constant = self.popMenuItemTop
        case 3:
            self.popMenu1Height.constant = self.popMenuItemHeight
            self.popMenu2Height.constant = self.popMenuItemHeight
            self.popMenu2Top.constant = self.popMenuItemTop
            self.popMenu3Height.constant = self.popMenuItemHeight
            self.popMenu3Top.constant = self.popMenuItemTop
        case 4:
            self.popMenu1Height.constant = self.popMenuItemHeight
            self.popMenu2Height.constant = self.popMenuItemHeight
            self.popMenu2Top.constant = self.popMenuItemTop
            self.popMenu3Height.constant = self.popMenuItemHeight
            self.popMenu3Top.constant = self.popMenuItemTop
            self.popMenu4Height.constant = self.popMenuItemHeight
            self.popMenu4Top.constant = self.popMenuItemTop
        case 5:
            self.popMenu1Height.constant = self.popMenuItemHeight
            self.popMenu2Height.constant = self.popMenuItemHeight
            self.popMenu2Top.constant = self.popMenuItemTop
            self.popMenu3Height.constant = self.popMenuItemHeight
            self.popMenu3Top.constant = self.popMenuItemTop
            self.popMenu4Height.constant = self.popMenuItemHeight
            self.popMenu4Top.constant = self.popMenuItemTop
            self.popMenu5Height.constant = self.popMenuItemHeight
            self.popMenu5Top.constant = self.popMenuItemTop
        case 6:
            self.popMenu1Height.constant = self.popMenuItemHeight
            self.popMenu2Height.constant = self.popMenuItemHeight
            self.popMenu2Top.constant = self.popMenuItemTop
            self.popMenu3Height.constant = self.popMenuItemHeight
            self.popMenu3Top.constant = self.popMenuItemTop
            self.popMenu4Height.constant = self.popMenuItemHeight
            self.popMenu4Top.constant = self.popMenuItemTop
            self.popMenu5Height.constant = self.popMenuItemHeight
            self.popMenu5Top.constant = self.popMenuItemTop
            self.popMenu6Height.constant = self.popMenuItemHeight
            self.popMenu6Top.constant = self.popMenuItemTop
        case 7:
            self.popMenu1Height.constant = self.popMenuItemHeight
            self.popMenu2Height.constant = self.popMenuItemHeight
            self.popMenu2Top.constant = self.popMenuItemTop
            self.popMenu3Height.constant = self.popMenuItemHeight
            self.popMenu3Top.constant = self.popMenuItemTop
            self.popMenu4Height.constant = self.popMenuItemHeight
            self.popMenu4Top.constant = self.popMenuItemTop
            self.popMenu5Height.constant = self.popMenuItemHeight
            self.popMenu5Top.constant = self.popMenuItemTop
            self.popMenu6Height.constant = self.popMenuItemHeight
            self.popMenu6Top.constant = self.popMenuItemTop
            self.popMenu7Height.constant = self.popMenuItemHeight
            self.popMenu7Top.constant = self.popMenuItemTop
        default:
            self.popMenu1Height.constant = self.popMenuItemHeight
            self.popMenu2Height.constant = self.popMenuItemHeight
            self.popMenu2Top.constant = self.popMenuItemTop
            self.popMenu3Height.constant = self.popMenuItemHeight
            self.popMenu3Top.constant = self.popMenuItemTop
            self.popMenu4Height.constant = self.popMenuItemHeight
            self.popMenu4Top.constant = self.popMenuItemTop
            self.popMenu5Height.constant = self.popMenuItemHeight
            self.popMenu5Top.constant = self.popMenuItemTop
            self.popMenu6Height.constant = self.popMenuItemHeight
            self.popMenu6Top.constant = self.popMenuItemTop
            self.popMenu7Height.constant = self.popMenuItemHeight
            self.popMenu7Top.constant = self.popMenuItemTop
        }
        
    }
    
    func adjustTopVPosition(anchorXY:CGPoint, brItem:BRItem, gender:GenderType) {
        
        let maleTestItems = brItem.maleTestItems
        let femaleTestItems = brItem.femaleTestItems
        let allTestItems = brItem.testItems
        for testItem in allTestItems {
            print("____ testItem:\(testItem.menuItemStr())")
        }
        
        var isTodayOrBefore = false
        guard let date = brItem.date else {
            return
        }
        let dateNow = Date()
        if date <= dateNow  {
            isTodayOrBefore = true
        }
        
        //is need to show pluse (today and before)
        //is need show SEX protected, SEX unprotected after pluse
        //is need show bleeding (bleeing or End bleeding), only female login
        //include date
        var showItemsCount = brItem.countExcludeBleeding() + 1
        if isTodayOrBefore {
            
            if self.topVDailyType == .None {
                self.topVDailyType = .Collapsed
            }
            
            self.topVDailyBleedingType = .Bleeding
            self.topVDailySEXType = .Show
            
            for testItem in allTestItems {
                if testItem.type == .SEX {
                    self.topVDailySEXType = .None
                    break
                }
            }
            
            if self.goalFilterType == .Male {
                self.topVDailyBleedingType = .None
            } else {
                self.topVDailyBleedingType = .Bleeding
                var  yesterDayBrItem:BRItem? = nil
                if self.currentLoginGender == .female {
                    yesterDayBrItem = self.findPerviousBrItemByDate(date: date)
                    if let date2 = yesterDayBrItem?.date {
                        //print("yesterDayBrItem: \(date2)")
                        print("yesterDayBrItem?.date: \(self.formatLocalDate("", date2))")
                    }
                }
                
                if let femaleTestItems = yesterDayBrItem?.femaleTestItems {
                    
                    for testItm in femaleTestItems {
                    
                        if testItm.type == .Bleeding
                        {
                            if let valueArrUnWrap = testItm.value {
                                let valDict = valueArrUnWrap[0]
                                let value = valDict["typeValue"] as! Int
                                print("yesterDayBrItem female bleeding value: \(value)")

                                if value == 1 {
                                    self.topVDailyBleedingType = .EndBleeding
                                }
                                
                            }
                            
                        }
                        
                    }
                }
            }
            
            if self.goalFilterType == .Male
                && self.topVDailySEXType == .None {
                self.topVDailyType = .None
            }
            
            if self.topVDailyType == .Collapsed {
                showItemsCount += 1
            } else if self.topVDailyType == .Unfolded {
                
                if self.topVDailyBleedingType == .Bleeding
                    || self.topVDailyBleedingType == .EndBleeding {
                    print("Unfolded with Bleeding: \(self.topVDailyBleedingType)")
                    showItemsCount += 1
                }
                
                if self.topVDailySEXType == .Show {
                    print("Unfolded with SEX: \(self.topVDailySEXType)")
                    showItemsCount += 2
                }
                
            } else if self.topVDailyType == .None {
            
            }
        }
        self.view.layoutIfNeeded()
        self.adjustPopVHeightByTestItemsCount(showItemsCount: showItemsCount)
        
         //re adjust the width of popV
        var longestWidth:CGFloat = 0
        var attributeToReSetWidth:[String] = []
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        let dateString = formatter.string(from: date)
        attributeToReSetWidth.append(dateString)
        
        for testItem in allTestItems {
            let menuItemStr = testItem.menuItemStr()
            attributeToReSetWidth.append(menuItemStr)
        }
        for menuItemStr in attributeToReSetWidth {
            
            let fontSizeAttribute = [NSForegroundColorAttributeName:  CellGoalTypeColor.White, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]
            let menuItemStrAttributes = NSMutableAttributedString(string:menuItemStr, attributes: fontSizeAttribute)
            self.testWidthLb.text = menuItemStr
            self.view.layoutIfNeeded()
            let width = self.testWidthLb.frame.size.width
            if (width > longestWidth){
                longestWidth = width
            }
            
            print("menuItemStrAttrinbted: \(menuItemStr) width: \(width)")
    
        }
        
        self.popVWidth.constant = longestWidth
        print("new popVWidth: \(self.popVWidth.constant )")
    
        var isMenuReverse = false
        
        self.popVLeading.constant = anchorXY.x
        self.popVTop.constant = anchorXY.y
        self.view.layoutIfNeeded()//update subview frame immediatelly
        if (self.bottomV.frame.intersects(self.popV.frame)) {
            isMenuReverse = true
            //print("popV hit bottomV")
            let newConstant = anchorXY.y - self.popV.frame.size.height + self.popMenuItemHeight;
            self.popVTop.constant = CGFloat(newConstant)
            self.view.layoutIfNeeded()//update subview frame immediatelly
        }
        let calendar = Calendar.current
        self.topVDateAlignType = .Left
        self.view.layoutIfNeeded()//update subview frame immediatelly
        if (self.rightV.frame.intersects(self.popV.frame)) {
            //print("popV hit rightV")
            var itemWidth = (self.collectionView!.frame.width - (self.numberOfColumns)) / self.numberOfColumns
            
            self.topVDateAlignType = .Right

            let isToday = calendar.isDateInToday(date)
            if isToday {
                itemWidth *= 2
            }
            
            let newConstant = anchorXY.x - self.popVWidth.constant + itemWidth * 0.5
            self.popVLeading.constant = newConstant
            self.view.layoutIfNeeded()//update subview frame immediatelly
            
        }

        
        if (self.bottomV.frame.intersects(self.popV.frame)) {
            //print("popV hit bottomV2")
            let tbBottomY = self.collectionView.frame.origin.y + self.collectionView.frame.size.height
            let popVBottomY = self.popV.frame.origin.y + self.popV.frame.size.height
//            print("popVBottomY: \(popVBottomY)")
//            print("tbBottomY: \(tbBottomY)")
            let diff = popVBottomY - tbBottomY
            //print("diff: \(diff)")
            self.popVTop.constant -= CGFloat(diff)
        }
        
        if (self.topV.frame.intersects(self.popV.frame)) {
            //print("popV hit topV2")
            let tbTopY = self.collectionView.frame.origin.y
            let popVTopY = self.popV.frame.origin.y
            //print("popVTopY: \(popVTopY)")
            //print("tbTopY: \(tbTopY)")
            let diff = tbTopY - popVTopY
            //print("diff: \(diff)")
            self.popVTop.constant += CGFloat(diff)
        }
        let isAllDone = brItem.isAllDone()
        print("goalFilterType: \(self.goalFilterType)")
        print("topVDailyType: \(self.topVDailyType)")
        print("topVDailyBleedingType: \(self.topVDailyBleedingType)")
        print("topVDailySEXType: \(self.topVDailySEXType)")
        print("isMenuReverse: \(isMenuReverse)")
        print("self.topVDateAlignType: \(self.topVDateAlignType)")
        print("showItemsCount: \(showItemsCount)")
        print("brItem.isAllDone: \(isAllDone)")
        
        self.showPopMenu()
        
        self.goalMenuItems = []
        let goalMenuItmOfDate = GoalMenuItem()
        goalMenuItmOfDate.type = .Date
        goalMenuItmOfDate.isHollow = !isAllDone
        
        goalMenuItmOfDate.menuItemStr = dateString
        goalMenuItems.append(goalMenuItmOfDate)
        
        for testItem in allTestItems {
            
            if testItem.type == .Bleeding {
                continue
            }
        
            let goalMenuItem = GoalMenuItem()
            goalMenuItem.menuItemStr = testItem.menuItemStr()
            goalMenuItem.testItemCid = testItem.testItemCid
            
            if  testItem.isDone() {
                goalMenuItem.isHollow = false
            } else {
                goalMenuItem.isHollow = true
            }
           
            switch testItem.type! {
            case .Sperm:
                goalMenuItem.type = .Sperm
            case .SEX:
                goalMenuItem.type = .SEX
            case .HCG:
                goalMenuItem.type = .HCG
            case .LH:
                goalMenuItem.type = .LH
            case .FSH:
                goalMenuItem.type = .FSH
            case .BBT:
                goalMenuItem.type = .BBT
            default:
                continue
            }
            goalMenuItems.append(goalMenuItem)
        }
        
        if self.topVDailyType == .Collapsed {
            
            let goalMenuItemUnforded = GoalMenuItem()
            goalMenuItemUnforded.type = .ManuallyUnfolded
            goalMenuItemUnforded.isHollow = false
            goalMenuItemUnforded.menuItemStr = "unfolded"
            goalMenuItems.append(goalMenuItemUnforded)
            
        } else if self.topVDailyType == .Unfolded {
            
            if self.topVDailyBleedingType == .Bleeding {
          
                let goalMenuItem = GoalMenuItem()
                goalMenuItem.type = .ManuallyBLeeding
                goalMenuItem.isHollow = true
                goalMenuItem.menuItemStr = "ManuallyBLeeding"
                goalMenuItems.append(goalMenuItem)
          
            } else if self.topVDailyBleedingType == .EndBleeding {
                let goalMenuItem = GoalMenuItem()
                goalMenuItem.type = .ManuallyEndBLeeding
                goalMenuItem.isHollow = true
                goalMenuItem.menuItemStr = "ManuallyEndBLeeding"
                goalMenuItems.append(goalMenuItem)
            }
            
            if self.topVDailySEXType == .Show {
                let goalMenuItemSEXProtected = GoalMenuItem()
                goalMenuItemSEXProtected.type = .ManuallySEXProtected
                goalMenuItemSEXProtected.isHollow = true
                goalMenuItemSEXProtected.menuItemStr = "ManuallySEXProtected"
                goalMenuItems.append(goalMenuItemSEXProtected)
                
                let goalMenuItemSEXUnProtected = GoalMenuItem()
                goalMenuItemSEXUnProtected.type = .ManuallySEXUnProtected
                goalMenuItemSEXUnProtected.isHollow = true
                goalMenuItemSEXUnProtected.menuItemStr = "ManuallySEXUnProtected"
                goalMenuItems.append(goalMenuItemSEXUnProtected)
            }
        
        }
        
        if isMenuReverse {
            self.goalMenuItems = self.goalMenuItems.reversed()
         
        }
        
        let size:CGFloat = 30

        do {
        
            for (idx, goalMenuItem) in self.goalMenuItems.enumerated() {
                if idx > 6 {
                    throw GoalError.TypeNameInvalid("goalMenuItem exceeding")
                }
                let popMenuDict = self.popMenuArr[idx]
                let popMenuV = popMenuDict["menu"] as! UIView
                
                let leftPadding =  popMenuDict["leftPadding"] as! NSLayoutConstraint
                let rightPadding = popMenuDict["rightPadding"] as! NSLayoutConstraint
                let menuLb = popMenuDict["lb"] as! UILabel
                menuLb.textColor =  CellGoalTypeColor.White
                menuLb.textAlignment = .left
                leftPadding.constant = 0 //reset all left padding
                rightPadding.constant = 0 //reset all right padding
                
                popMenuV.layer.cornerRadius = size / 2
                popMenuV.layer.borderWidth = 2.0
                popMenuV.layer.backgroundColor = UIColor.gray.cgColor
                popMenuV.layer.borderColor = UIColor.green.cgColor
                popMenuV.clipsToBounds = true
                popMenuV.isUserInteractionEnabled = true
                
                print("menuItem: \(goalMenuItem.type!), isHollow:\(goalMenuItem.isHollow), testItemCid: \(goalMenuItem.testItemCid), menuItemStr: \(goalMenuItem.menuItemStr) \n ")
                
                // create attributed string
//                let fontSizeAttribute = [NSForegroundColorAttributeName:  CellGoalTypeColor.Black, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]
//                let menuItemStrAttributes = NSMutableAttributedString(string:goalMenuItem.menuItemStr!, attributes: fontSizeAttribute)
              
                
                switch goalMenuItem.type! {
                case  .Date:
                    menuLb.textAlignment = .center
                    
                    popMenuV.layer.borderColor = UIColor.white.cgColor
                    if (self.topVDateAlignType == .Right) {
                        leftPadding.constant = self.popVWidth.constant / 2
                    } else {
                        rightPadding.constant = self.popVWidth.constant / 2
                    }
                    if goalMenuItem.isHollow {
                        menuLb.textColor =  CellGoalTypeColor.White
                        popMenuV.layer.backgroundColor =  CellGoalTypeColor.Black.cgColor
                    } else {
                        menuLb.textColor =  CellGoalTypeColor.Black
                        popMenuV.layer.backgroundColor = CellGoalTypeColor.White.cgColor
                    }
                     menuLb.text = goalMenuItem.menuItemStr;

                default:
                    menuLb.text = goalMenuItem.menuItemStr;
                    print("bbbb")
                }
              
                
            }
            
        } catch {
            print(error)
        }

        self.view.layoutIfNeeded()
    }
    
    func findPerviousBrItemByDate(date:Date) -> BRItem? {
        
        var perviousBrItem:BRItem? = nil
        
        let dateOfyesterday = Date(timeInterval: -60*60*24, since: date)
        
        for brItem in self.allBrItemsForCell {
            guard let dateChked = brItem?.date else {
                continue
            }
            let isSameDate = Calendar.current.isDate(dateOfyesterday, inSameDayAs:dateChked)
            if isSameDate {
                perviousBrItem = brItem
                break
            }
            
        }
        return perviousBrItem
    }
    
    @IBAction func dismissMenu(_ sender: UIButton) {
        self.hidePopMenu()
    }
    
    func showPopMenu() {
        self.popV.isHidden = false
        self.fadeV.isHidden = false
    }
    func hidePopMenu() {
        self.popV.isHidden = true
        self.fadeV.isHidden = true
    }
    
    @IBAction func goalMenuItemAction(_ sender: UIButton) {
        
        do {
            if (sender.tag + 1) > self.goalMenuItems.count {
                
                      throw GoalError.TypeNameInvalid("menuItem select index:\(sender.tag) out of range")
            }
            
            let goalMenuItem = self.goalMenuItems[sender.tag]
            
            print("menuItem Selected: \(goalMenuItem.type!), isHollow:\(goalMenuItem.isHollow), testItemCid: \(goalMenuItem.testItemCid), menuItemStr: \(goalMenuItem.menuItemStr) \n ")
            if goalMenuItem.type == .ManuallyUnfolded {
                
                self.topVDailyType = .Unfolded
                self.adjustTopVPosition(anchorXY: self.currentAnchorXY!, brItem: self.currentBrItem!, gender: self.currentLoginGender)
            }
          
        } catch {
            print(error)
        }
        
 
    }
    
    
    @IBOutlet weak var widthTf: UITextField!
    @IBAction func changePopVWidth(_ sender: UIButton) {
     
        let width = Float(self.widthTf.text!)
        self.widthTf.resignFirstResponder()
        self.popVWidth.constant = CGFloat(width!)
        
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

extension NSAttributedString {
    
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
}
