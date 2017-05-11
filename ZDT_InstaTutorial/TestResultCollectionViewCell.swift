//
//  ImageCollectionViewCell.swift
//  ZDT_InstaTutorial
//
//  Created by Sztanyi Szabolcs on 22/12/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

import UIKit

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
    
    @IBOutlet weak var sub1CircleCenterX: NSLayoutConstraint!
    @IBOutlet weak var sub2CircleCenterX: NSLayoutConstraint!
    @IBOutlet weak var sub3CircleCenterX: NSLayoutConstraint!
    
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
    }
    
    func show2SubCircle() {

        self.subCirclesContainer.isHidden = false
        self.sub1CircleCenterX.constant = -5
        self.sub2CircleCenterX.constant = 5

        self.sub1Circle.isHidden = false
        self.sub2Circle.isHidden = false
        self.sub3Circle.isHidden = true
    }
    
    func show3SubCircle() {

        self.subCirclesContainer.isHidden = false
        self.sub1CircleCenterX.constant = -10
        self.sub2CircleCenterX.constant = 0
        self.sub3CircleCenterX.constant = 10
        self.sub1Circle.isHidden = false
        self.sub2Circle.isHidden = false
        self.sub3Circle.isHidden = false
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
            
        
            self.circleV?.isHidden = true
            self.serialLb.isHidden = true
            self.monthLb.isHidden = true
            
            let color_sperm = UIColor.init(red: 247/255.0, green: 176/255.0, blue: 41/255.0, alpha: 1)
            let color_FSH = UIColor.init(red: 234/255.0, green: 97/255.0, blue: 120/255.0, alpha: 1)
            let color_LH = UIColor.init(red: 0/255.0, green: 179/255.0, blue: 200/255.0, alpha: 1)
            let color_HCG = UIColor.init(red: 196/255.0, green: 214/255.0, blue: 0/255.0, alpha: 1)
            let color_mating = UIColor.purple
            let color_BBT = UIColor.white
            let color_gray = UIColor.gray
            
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
                case 5,6,7,8,9,10:
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
                        default:
                            print("")
                        }
                        
                        switch testItem.type! {
                        case .Sperm:
                            color_current = color_sperm
                        case .FSH:
                            color_current = color_FSH
                        case .LH:
                            color_current = color_LH
                        case .HCG:
                            color_current = color_HCG
                        case .Mating:
                            color_current = color_mating
                         case .BBT:
                            color_current = color_BBT

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
                    self.circleV?.layer.borderColor = color_gray.cgColor
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
