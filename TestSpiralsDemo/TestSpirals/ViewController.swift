//
//  ViewController.swift
//  TestSpirals
//
//  Created by Peter2 on 13/03/2017.
//  Copyright © 2017 Peter2. All rights reserved.
//

import UIKit

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
    var serial:Int = 0
    var result:TestItemResult = .NotDo
    
}

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var sineV: SineView!
    let rotateDegree:CGFloat = -90
    var sineVOriginY:CGFloat  = 0
    
    // Data model: These strings will be the data for the table view cells
    var testItems: [TestItem] = []
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sineV.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        
        for serail in stride(from: 300, through: 0, by: -1) {
            let testItem = TestItem()
            testItem.serial = Int(serail)
            
            switch TestItemResult.random() {
            case .Pass:
                testItem.result = .Pass
            case .Failed:
                testItem.result = .Failed
            case .NotDo:
                testItem.result = .NotDo
            }
            testItems.append(testItem)
        }
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.reloadData()
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let refPointsArr = sineV.getRefPointsArr()
        print("refPointsArr in VC \(refPointsArr)")
        let width = self.view.frame.width
        let height = self.view.frame.height
        let rotatePoint = CGPoint(x: width / 2, y: height / 2)
        
        let halfIndexFloat:Float = Float(self.testItems.count) / 2
        let halfIndexInt = Int(halfIndexFloat)
        let halfIndexPath = IndexPath(row: halfIndexInt, section: 0)
        self.tableView.scrollToRow(at: halfIndexPath, at: .middle, animated: false)
        self.sineV.renderTImeLine(halfIndexInt, self.testItems)
        
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.testItems.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        cell.contentView.alpha = 0
        // set the text from the data model
        let testItem = self.testItems[indexPath.row] as TestItem
        let serialStr = String(testItem.serial)
        
        switch testItem.result {
        case .Pass:
            cell.textLabel?.text = "\(serialStr): Pass"
        case .Failed:
            cell.textLabel?.text = "\(serialStr): Failed"
        case .NotDo:
            cell.textLabel?.text = "\(serialStr): NotDo"
        }
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
     
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //let date = Date()
        //print("scrollViewDidScroll:\(date)")
        var firstVisibleIndexPath: IndexPath? = self.tableView.indexPathsForVisibleRows?[0]
        print("first visible cell's section: \(firstVisibleIndexPath?.section), row: \(firstVisibleIndexPath?.row)")
        let newStartIndex:Int = firstVisibleIndexPath!.row
        self.sineV.renderTImeLine(newStartIndex, self.testItems)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 


}

