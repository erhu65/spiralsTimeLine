//
//  SineViewContainer.swift
//  TestSpirals
//
//  Created by peter huang on 17/03/2017.
//  Copyright © 2017 Peter2. All rights reserved.
//

import UIKit

class SineViewContainer: UIView, UIScrollViewDelegate {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        //print("SineViewContainer draw...")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         print("scrollViewDidScroll")

    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
        
    }
 

}
