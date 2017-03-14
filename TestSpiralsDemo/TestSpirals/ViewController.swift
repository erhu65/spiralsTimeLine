//
//  ViewController.swift
//  TestSpirals
//
//  Created by Peter2 on 13/03/2017.
//  Copyright © 2017 Peter2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var sineV: SineView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sineV.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))

    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

