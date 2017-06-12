//
//  ImageCollectionViewCell.swift
//  ZDT_InstaTutorial
//
//  Created by Sztanyi Szabolcs on 22/12/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

import UIKit

enum CellGoalTypeColor {
    
    static let Black = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
    static let White = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    static let Sperm = UIColor.init(red: 247/255.0, green: 176/255.0, blue: 41/255.0, alpha: 1)
    static let FSH = UIColor.init(red: 234/255.0, green: 97/255.0, blue: 120/255.0, alpha: 1)
    static let LH = UIColor.init(red: 0/255.0, green: 179/255.0, blue: 200/255.0, alpha: 1)
    static let HCG = UIColor.init(red: 196/255.0, green: 214/255.0, blue: 0/255.0, alpha: 1)
    static let SEX = UIColor.purple
    static let BBT = UIColor.init(red: 29/255.0, green: 116/255.0, blue: 111/255.0, alpha: 1)
    static let Bleeding = UIColor.red
    static let Gray = UIColor.gray
}

enum CellGuildLine: UInt32 {
    case none
    case noneEmpty
    case topLeft
    case bottomLeft
    case topRight
    case bottomRight
    case horizontal
    case vertical
}

class TestResultCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var iconImv: UIImageView!
    @IBOutlet weak var serialLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var guidImv: UIImageView!
    
    @IBOutlet weak var circleV: UIView!
    @IBOutlet weak var subCirclesContainer: UIView!
    @IBOutlet weak var sub1Circle: UIView!
    @IBOutlet weak var sub2Circle: UIView!
    @IBOutlet weak var sub3Circle: UIView!
    @IBOutlet weak var sub4Circle: UIView!
    
    @IBOutlet weak var sub1CircleCenterX: NSLayoutConstraint!
    @IBOutlet weak var sub2CircleCenterX: NSLayoutConstraint!
    @IBOutlet weak var sub3CircleCenterX: NSLayoutConstraint!
    @IBOutlet weak var sub4CircleCenterX: NSLayoutConstraint!
    
    
    @IBOutlet weak var monthLb: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        
    }
    
    func hideAllSubCircle() {
        self.subCirclesContainer.isHidden = true
    }
    
    func show1SubCircle() {
        self.subCirclesContainer.isHidden = false
        self.sub1CircleCenterX.constant = 0

        self.sub1Circle.isHidden = false
        self.sub2Circle.isHidden = true
        self.sub3Circle.isHidden = true
        self.sub4Circle.isHidden = true
    }
    
    func show2SubCircle() {

        self.subCirclesContainer.isHidden = false
        self.sub1CircleCenterX.constant = -5
        self.sub2CircleCenterX.constant = 5

        self.sub1Circle.isHidden = false
        self.sub2Circle.isHidden = false
        self.sub3Circle.isHidden = true
        self.sub4Circle.isHidden = true
        
    }
    
    func show3SubCircle() {

        self.subCirclesContainer.isHidden = false
        self.sub1CircleCenterX.constant = -10
        self.sub2CircleCenterX.constant = 0
        self.sub3CircleCenterX.constant = 10
        self.sub1Circle.isHidden = false
        self.sub2Circle.isHidden = false
        self.sub3Circle.isHidden = false
        self.sub4Circle.isHidden = true
    }
    
    func show4SubCircle() {
        
        self.subCirclesContainer.isHidden = false
        self.sub1CircleCenterX.constant = -12
        self.sub2CircleCenterX.constant = -4
        self.sub3CircleCenterX.constant = 4
        self.sub4CircleCenterX.constant = 12
        
        self.sub1Circle.isHidden = false
        self.sub2Circle.isHidden = false
        self.sub3Circle.isHidden = false
        self.sub4Circle.isHidden = false
    }
    
    var brItem:BRItem? {
        
        didSet{

            let size:CGFloat = 30
            self.circleV?.layer.cornerRadius = size / 2
            self.circleV?.layer.borderWidth = 2.0
            self.circleV?.layer.backgroundColor = UIColor.clear.cgColor
            self.circleV?.layer.borderColor = UIColor.green.cgColor
            self.circleV?.clipsToBounds = true
            
            
            let subCirclesize:CGFloat = 6.0
            self.sub1Circle?.layer.cornerRadius = subCirclesize / 2
            self.sub1Circle?.layer.borderWidth = 1.0
            self.sub1Circle?.clipsToBounds = true
            self.sub2Circle?.layer.cornerRadius = subCirclesize / 2
            self.sub2Circle?.layer.borderWidth = 1.0
            self.sub2Circle?.clipsToBounds = true
            self.sub3Circle?.layer.cornerRadius = subCirclesize / 2
            self.sub3Circle?.layer.borderWidth = 1.0
            self.sub3Circle?.clipsToBounds = true
            self.sub4Circle?.layer.cornerRadius = subCirclesize / 2
            self.sub4Circle?.layer.borderWidth = 1.0
            self.sub4Circle?.clipsToBounds = true
            
    
            self.circleV?.isHidden = true
            //self.serialLb.isHidden = true
            self.monthLb.isHidden = true
   
            if let date =  brItem?.date {
                
                self.circleV?.isHidden = false
                let calendar = Calendar.current
                let day = calendar.component(.day, from: date)
                self.dateLb.text = "\(day)"
                

                let testItemsCount =  brItem?.testItems.count
                
                switch testItemsCount! {
                case 1:
                    self.hideAllSubCircle()
                case 2:
                    self.show1SubCircle()
                case 3:
                    self.show2SubCircle()
                case 4:
                     self.show3SubCircle()
                case 5:
                    self.show4SubCircle()
                case 6,7,8,9,10:
                    self.show3SubCircle()
                default:
                    self.hideAllSubCircle()
                }
                
                if  testItemsCount! > 0 {
                  
                    if day == 1 {
                        self.monthLb.isHidden = false
                        let dayTimePeriodFormatter = DateFormatter()
                        dayTimePeriodFormatter.dateFormat = "MMM"
                        let monthStr = dayTimePeriodFormatter.string(from: date)
                        self.monthLb.text = monthStr
                    }
                    
                    for (idx, testItem) in (brItem?.testItems.enumerated())! {
                        var color_current = UIColor.clear
                        var circleV:UIView? = nil
                        switch idx {
                        case 0:
                            circleV = self.circleV
                        case 1:
                            circleV = self.sub1Circle
                        case 2:
                            circleV = self.sub2Circle
                        case 3:
                            circleV = self.sub3Circle
                        case 4:
                            circleV = self.sub4Circle
                        default:
                            print("")
                        }
                        
                        switch testItem.type! {
                        case .Sperm:
                            color_current = CellGoalTypeColor.Sperm
                        case .FSH:
                            color_current = CellGoalTypeColor.FSH
                        case .LH:
                            color_current = CellGoalTypeColor.LH
                        case .HCG:
                            color_current = CellGoalTypeColor.HCG
                        case .SEX:
                            color_current = CellGoalTypeColor.SEX
                         case .BBT:
                            color_current = CellGoalTypeColor.BBT
                        case .Bleeding:
                            color_current = CellGoalTypeColor.Bleeding
                        }
 
                        circleV?.layer.borderColor = color_current.cgColor
                        circleV?.layer.backgroundColor = color_current.cgColor
                        
                        if testItem.isDone() == false {
                            if idx == 0 {
                                self.dateLb.textColor = color_current
                            }
                            
                            circleV?.layer.backgroundColor = UIColor.black.cgColor
                        } else {
                            if idx == 0 {
                                self.dateLb.textColor =  UIColor.black
                            }
                        }

                    }
                    
                } else {
                    self.circleV?.isHidden = true
                    self.dateLb.text = ""
                    self.hideAllSubCircle()
                }
                
            } else {
                self.circleV?.isHidden = true
                self.dateLb.text = ""
                self.hideAllSubCircle()
            }
            
            if let cellGuidLine = brItem?.cellGuildLine {
             
                switch cellGuidLine {
                case .topLeft:
                    self.guidImv.image = UIImage(named:"guidTopLeft")
                case .bottomLeft:
                    self.guidImv.image = UIImage(named:"guidBottomLeft")
                case .topRight:
                    self.guidImv.image = UIImage(named:"guidTopRight")
                case .bottomRight:
                    self.guidImv.image = UIImage(named:"guidBottomRight")
                case .horizontal:
                    self.guidImv.image = UIImage(named:"guidHorizontal")
                case .vertical:
                    self.guidImv.image = UIImage(named:"guidVertical")
                case .noneEmpty:
                    self.circleV?.isHidden = false
                    self.circleV?.layer.backgroundColor = UIColor.black.cgColor
                    self.circleV?.layer.borderColor = CellGoalTypeColor.Gray.cgColor
                    self.guidImv.image = UIImage(named:"guidHorizontal")
                case .none:
                    self.guidImv.image = UIImage(named:"")
                    
                }
            } else {
                self.guidImv.image = UIImage(named:"")
                self.hideAllSubCircle()
            }
        
        }
        
        willSet(newValue){
        
            
    
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImv.image = nil
    }
    

}
