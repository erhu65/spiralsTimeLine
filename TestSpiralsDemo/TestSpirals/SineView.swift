//
//  SpiralUiView.swift
//  TestSpirals
//
//  Created by Peter2 on 13/03/2017.
//  Copyright © 2017 Peter2. All rights reserved.
//

import UIKit

class SineView: UIView{
    let graphWidth: CGFloat = 0.95  // Graph is 80% of the width of the view
    let amplitude: CGFloat = 0.22   // Amplitude of sine wave is 30% of view height
    let circleRadius:CGFloat = 5
    var perviousRefPoint:CGPoint = CGPoint(x:0, y:0)
    var refPointsArr: [CGPoint] = []
    let rotateDegree:CGFloat = -90

    var lastLocation:CGPoint = CGPoint(x:0, y:0)

    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        drawSineHorizontal(width, height)
        let totalPointscount = refPointsArr.count
        
        print("refPointsArr: \(refPointsArr.count)")
        
        for (index, point) in refPointsArr.enumerated() {
            if index == 0 {
                drawRingFittingInsideView(point.x, point.y, UIColor.green.cgColor)
            } else if index == (totalPointscount - 1) {
                drawRingFittingInsideView(point.x, point.y, UIColor.blue.cgColor)
            } else {
                drawRingFittingInsideView(point.x, point.y, UIColor.red.cgColor)
            }
            
            //drawText("\(index)", point)
        }
        
        // Initialization code
        let panRecognizer = UIPanGestureRecognizer(target:self, action: #selector(self.detectPan(_:)))
        self.gestureRecognizers = [panRecognizer]
        
 
    
    }
    
    func detectPan(_ recognizer:UIPanGestureRecognizer) {
        
        let translation  = recognizer.translation(in: self.superview!)
        let lastCenter:CGPoint = self.center
        
        self.center = CGPoint(x: lastCenter.x, y: (lastLocation.y + translation.y))
           
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Promote the touched view
        //self.superview?.bringSubview(toFront: self)
        
        // Remember original location
        lastLocation = self.center
    }
    
    func drawText(_ txt:String, _ p: CGPoint) {
    
        let atts = [NSFontAttributeName: UIFont.init(name: "Georgia", size: 8)]
        (txt as NSString).draw(
            at: CGPoint(x:p.x, y:p.y), 
            withAttributes: atts)
    
    }
    
    
    func distance(a: CGPoint, b: CGPoint) -> Int {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return Int(CGFloat(sqrt((xDist * xDist) + (yDist * yDist))))
    }
    
    func rotate(original oldPoint: CGPoint, around center: CGPoint, with degrees: CGFloat) -> CGPoint {
        let dx = oldPoint.x - center.x
        let dy = oldPoint.y - center.y
        let radius = sqrt(dx * dx + dy * dy)
        let azimuth = atan2(dy, dx) // in radians
        let newAzimuth = azimuth + degrees * CGFloat(M_PI / 180.0) // convert it to radians
        let x = center.x + radius * cos(newAzimuth)
        let y = center.y + radius * sin(newAzimuth)
        return CGPoint(x: x, y: y)
    }
    
    
    func drawSineHorizontal(_ width:CGFloat, _ height: CGFloat){
        
        let rotatePoint = CGPoint(x: width / 2, y: height / 2)
        //起始點
        //let origin = CGPoint(x: width * (1 - graphWidth) / 2, y: height * 0.50)
        let origin = CGPoint(x: 100, y: height * 0.50)
        //print("origin: \(origin)")
        //let originRotate = rotate(original: origin, around: rotatePoint, with:rotateDegree)
        //drawRingFittingInsideView(origin.x, origin.y, UIColor.green.cgColor)
        
        
        let path = UIBezierPath()
        path.move(to: origin)
        let endRadius = 6000.0
        let step = 5.0
        for angle in stride(from: 0.0, through: endRadius, by: step) {
            //print("algle: \(angle)")
            
            let x = origin.x + CGFloat(angle/endRadius) * width * graphWidth
            let y = origin.y - CGFloat(sin(angle/180.0 * Double.pi)) * height * amplitude
            
            var currentRefPoint = CGPoint(x:x, y:y)
            //currentRefPoint = rotate(original: currentRefPoint, around: rotatePoint, with: rotateDegree);
                        
            
            let distanceBetweenTwoPoints = distance(a: currentRefPoint, b: perviousRefPoint)
            //            print("currentRefPoint: \(currentRefPoint)")
            //            print("perviousRefPoint: \(perviousRefPoint)")
            
            
            perviousRefPoint = currentRefPoint            
            path.addLine(to: CGPoint(x: currentRefPoint.x, y: currentRefPoint.y))
            if angle == endRadius {
                //print("algle last : \(angle)")
                //drawRingFittingInsideView(currentRefPoint.x, currentRefPoint.y , UIColor.blue.cgColor)
            } else if angle != 0 {
                
                //drawRingFittingInsideView(currentRefPoint.x, currentRefPoint.y, UIColor.red.cgColor)
            }
            refPointsArr.append(currentRefPoint)
            
            
        }
        
        //UIColor.green.setFill()
        path.stroke()
    }
    
    func drawRingFittingInsideView(_ x:CGFloat, _ y: CGFloat, _ color: CGColor)->()
    {
        //let halfSize:CGFloat = min( bounds.size.width/2, bounds.size.height/2)
        
        let desiredLineWidth:CGFloat = 1    // your desired value
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x:x,y:y),
            radius: CGFloat( circleRadius - (desiredLineWidth/2) ),
            startAngle: CGFloat(0),
            endAngle:CGFloat(M_PI * 2 ),
            clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = desiredLineWidth
        
        layer.addSublayer(shapeLayer)
    }
    
    
}
