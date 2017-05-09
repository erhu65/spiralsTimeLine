//
//  ImageCollectionViewCell.swift
//  ZDT_InstaTutorial
//
//  Created by Sztanyi Szabolcs on 22/12/15.
//  Copyright © 2015 Zappdesigntemplates. All rights reserved.
//

import UIKit

class TestResultCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var iconImv: UIImageView!
    @IBOutlet weak var serialLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var guidImv: UIImageView!
    
    @IBOutlet weak var circleV: UIView!
    
    @IBOutlet weak var subCirclesContainer: UIView!
    

    @IBOutlet weak var sub1CircleCenterX: NSLayoutConstraint!
    @IBOutlet weak var sub2CircleCenterX: NSLayoutConstraint!
    @IBOutlet weak var sub1Width: NSLayoutConstraint!
    @IBOutlet weak var sub2Width: NSLayoutConstraint!
    @IBOutlet weak var sub3Width: NSLayoutConstraint!
    
    @IBOutlet weak var sub1Circle: UIView!
    @IBOutlet weak var sub2Circle: UIView!
    @IBOutlet weak var sub3Circle: UIView!
    
    var account:String? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        
    }
    
    func hideAllSubCircle() {
//        self.sub1CircleCenterX.constant = 0;
//        self.sub2CircleCenterX.constant = 0;
        self.subCirclesContainer.isHidden = true
    }
    
    func show1SubCircle() {
//        self.sub1CircleCenterX.constant = 0;
//        self.sub2CircleCenterX.constant = 0;
        self.subCirclesContainer.isHidden = false
//        self.sub1Width.constant = 0
//        self.sub2Width.constant = 0
//        self.sub3Width.constant = 0
        self.sub1Circle.isHidden = false
        self.sub2Circle.isHidden = true
        self.sub3Circle.isHidden = true
    }
    
    func show2SubCircle() {
//        self.sub1CircleCenterX.constant = 0
//        self.sub2CircleCenterX.constant = 0
        self.subCirclesContainer.isHidden = false
//        self.sub1Width.constant = 0
//        self.sub2Width.constant = 25
//        self.sub3Width.constant = 0
        self.sub1Circle.isHidden = false
        self.sub2Circle.isHidden = false
        self.sub3Circle.isHidden = true
    }
    
    func show3SubCircle() {
//        self.sub1CircleCenterX.constant = 0
//        self.sub2CircleCenterX.constant = 0
        self.subCirclesContainer.isHidden = false
//        self.sub1Width.constant = 16.67
//        self.sub2Width.constant = 16.67
//        self.sub3Width.constant = 16.67
        self.sub1Circle.isHidden = false
        self.sub2Circle.isHidden = false
        self.sub3Circle.isHidden = false
    }
    
    var brItem:BRItem? {
        
        didSet{
        
            let size:CGFloat = 25.0
            self.circleV?.layer.cornerRadius = size / 2
            self.circleV?.layer.borderWidth = 2.0
            self.circleV?.layer.backgroundColor = UIColor.clear.cgColor
            self.circleV?.layer.borderColor = UIColor.green.cgColor
            self.circleV?.clipsToBounds = true
            
            
            let subCirclesize:CGFloat = 8.0
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

         
            
            if let date =  brItem?.date {
                
                self.circleV?.isHidden = false
                let calendar = Calendar.current
                //let year = calendar.component(.year, from: date!)
                //let month = calendar.component(.month, from: date)
                let day = calendar.component(.day, from: date)
                //let weekDay = calendar.component(.weekday, from: date)
                //"\(month)/\(day)(\(weekDay))"
                self.dateLb.text = "\(day)"

                var isAllDone = true
                for (_, testItem) in (brItem?.testItems.enumerated())! {
                    
                    let isDone = testItem.isDone()
                    if !isDone {
                        isAllDone = false
                        break
                    }
                }

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
                default:
                    self.hideAllSubCircle()
                }
                
                if  testItemsCount! > 0 {
                    
                    let firstTestItem:TestItem? = brItem?.testItems[0]
                    
                    let color_sperm = UIColor.init(red: 247/255.0, green: 176/255.0, blue: 41/255.0, alpha: 1)
                    let color_FSH = UIColor.init(red: 234/255.0, green: 97/255.0, blue: 120/255.0, alpha: 1)
                    let color_LH = UIColor.init(red: 0/255.0, green: 179/255.0, blue: 200/255.0, alpha: 1)
                    let color_HCG = UIColor.init(red: 196/255.0, green: 214/255.0, blue: 0/255.0, alpha: 1)
                    let color_mating = UIColor.purple
                    let color_temperature = UIColor.white
                    
                    var color_current = UIColor.clear
                    
                    if firstTestItem?.type == .Sperm {
                        color_current = color_sperm
                    } else if firstTestItem?.type == .FSH {
                        color_current = color_FSH
                    } else if firstTestItem?.type == .LH {
                        color_current = color_LH
                    } else if firstTestItem?.type == .HCG {
                        color_current = color_HCG
                    }  else if firstTestItem?.type == .Mating {
                        color_current = color_mating
                    }  else if firstTestItem?.type == .Temperature {
                        color_current = color_temperature
                    }
                    
                    self.circleV?.layer.borderColor = color_current.cgColor
                    self.circleV?.layer.backgroundColor = color_current.cgColor
                    
                    if !isAllDone {
                        self.dateLb.textColor = color_current
                        self.circleV?.layer.backgroundColor = UIColor.black.cgColor
                    } else {
                        self.dateLb.textColor =  UIColor.black
                    }
                
                } else {
                    //self.circleV?.isHidden = true
                    self.dateLb.text = "X"
                    self.hideAllSubCircle()
                }
                
            } else {
                //self.circleV?.isHidden = true
                self.dateLb.text = "X"
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
