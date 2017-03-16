//
//  SineScrollerView.swift
//  TestSpirals
//
//  Created by peter huang on 3/15/17.
//  Copyright © 2017 Peter2. All rights reserved.
//

import UIKit

typealias SineScrollerViewCallback = (_ xOffset:CGFloat, _ yOffset:CGFloat) -> (Void)

class SineScrollerView: UIView {
    
    var lastLocation:CGPoint = CGPoint(x:0, y:0)
    var originCenter:CGPoint = CGPoint(x:0, y:0)
    var scrollcallBack:SineScrollerViewCallback? = nil
    var finalYOffset:CGFloat = 0
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
   
        
        // Initialization code
        let panRecognizer = UIPanGestureRecognizer(target:self, action: #selector(self.detectPan(_:)))
        self.gestureRecognizers = [panRecognizer]
        self.originCenter = self.center
        
    }
    
    func detectPan(_ recognizer:UIPanGestureRecognizer) {
        
        let translation  = recognizer.translation(in: self.superview!)
        let lastCenter:CGPoint = self.center
        
        if (recognizer.state == .began) {
            // do stuff - call method for gesture began
            lastLocation = self.center
            
        }else if (recognizer.state == .ended) {
            // do other stuff - call method for gesture ended
            //self.center = self.originCenter
            self.finalYOffset += translation.y
            
        }else {
            
            print("finalYOffset: \(finalYOffset)")
            self.scrollcallBack?(translation.x, translation.y)
            
            self.center = CGPoint(x: lastCenter.x, y: (lastLocation.y + translation.y))
            
        }
    }
    
    
}
