//
//  TimeLiineIndicatorView.swift
//  TestSpirals
//
//  Created by peter huang on 19/03/2017.
//  Copyright © 2017 Peter2. All rights reserved.
//

import UIKit

class TimeLiineIndicatorView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override var center: CGPoint
    {
        didSet {
          print("center: did set; \(center.y)")
            
        }
        
    }
    

}
