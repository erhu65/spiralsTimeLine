//
//  SpiralUiView.swift
//  TestSpirals
//
//  Created by Peter2 on 13/03/2017.
//  Copyright © 2017 Peter2. All rights reserved.
//

import UIKit

typealias ScrollCallback = (_ xOffset:CGFloat, _ yOffset:CGFloat) -> (Void)

class SineView: UIView{
    let graphWidth: CGFloat = 1.0  // Graph is 80% of the width of the view
    let amplitude: CGFloat = 0.40   // Amplitude of sine wave is 30% of view height
    let circleRadius:CGFloat = 5
    var refPointsArr: [CGPoint] = []
    var circles: [TimeLineCircleView] = []
    var startPoinsIndexOfrefPointsArr: [Int] = []
    let rotateDegree:CGFloat = -90
    var lastIndicatorVCenter:CGPoint = CGPoint(x: 0, y: 0)
    var initCenter:CGPoint = CGPoint(x: 0, y: 0)
    var firstPointParentV:CGPoint = CGPoint(x: 0, y: 0)
    var testItems: [TestItem] = []
    var indicatorV: UIView?
    let ajdustInitYVal:CGFloat = 280//adjust by phone screen size
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        drawSineVertical(width, height)
        let totalPointscount = refPointsArr.count
        
        print("refPointsArr.count: \(refPointsArr.count)")
        print("self.startPoinsIndexOfrefPointsArr:\(self.startPoinsIndexOfrefPointsArr)")
        
        for (index, point) in refPointsArr.enumerated() {
            
            let circle = TimeLineCircleView(frame: CGRect(x: point.x , y: point.y, width: 13.0, height: 13.0))
            //circle.center = containerView.center
            circle.layer.cornerRadius = 6.0
            circle.center = point
            self.circles.append(circle)
            let tapRecognizer = UITapGestureRecognizer(target:self, action: #selector(self.detectTapCircle(_:)))
            circle.gestureRecognizers = [tapRecognizer]
            
            self.addSubview(circle)
//            
//            if index == 0 {
//                drawRingFittingInsideView(point.x, point.y, UIColor.green.cgColor)
//            } else if index == (totalPointscount - 1) {
//                drawRingFittingInsideView(point.x, point.y, UIColor.blue.cgColor)
//            } else {
//                drawRingFittingInsideView(point.x, point.y, UIColor.red.cgColor)
//            }
            
            drawText("\(index)", point)
        }
      
        // Initialization code
        let panRecognizer = UIPanGestureRecognizer(target:self, action: #selector(self.detectPan(_:)))
        self.gestureRecognizers = [panRecognizer]
        self.initCenter = self.center
 
    }
    
    
    
    func detectTapCircle(_ recognizer:UITapGestureRecognizer) {
        let timeLineCircleView = recognizer.view as! TimeLineCircleView
        if timeLineCircleView.itemIndex != -1 {
            let item = self.testItems[timeLineCircleView.itemIndex]
            print("time tapped index: \(item.index)")

            
        } else {
            print("not circleView")
        }
    }
    
    func detectPan(_ recognizer:UIPanGestureRecognizer) {
        
        let translation  = recognizer.translation(in: self.superview!)
        if recognizer.state == .began
        {
             print("ranslationY began:")
            self.lastIndicatorVCenter = (self.indicatorV?.center)!  // for drag timeline
        } else if recognizer.state == .ended {
            //self.adjustFirstPoinToContainerBottom()
            
            let translationY = self.lastIndicatorVCenter.y + translation.y
            let offsetY =  translationY - self.lastIndicatorVCenter.y
            print("translationY offsetY ended: \(offsetY)")
            
            //self.renderTImeLineRecursive(Int(offsetY), self.testItems)
            
            //self.indicatorV?.center = self.lastIndicatorVCenter
            
            let step = (offsetY > 0) ? -1 : 1
            //let concurrentQueue = DispatchQueue(label: "queuename", attributes: .concurrent)
            
            let serialQueue = DispatchQueue(label: "queuename")
            
            for reverseIndex in stride(from: Int(offsetY), through: 0, by: step) {
                
                
                serialQueue.sync {
                    //print("reverseIndex: \(reverseIndex)")
                    self.renderTImeLine(reverseIndex, self.testItems)
                }

            }
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { [weak self]  in
                
                self?.indicatorV?.center = (self?.lastIndicatorVCenter)!
                
            }, completion: { [weak self] finished in
                
                
                
            })
            
            
        
        } else if recognizer.state == .changed {
            
            let lastCenter:CGPoint = self.center
            let translationY = self.lastIndicatorVCenter.y + translation.y
            self.indicatorV?.center = CGPoint(x: lastCenter.x, y: translationY) // for drag timeline
            let offsetY =  translationY - self.lastIndicatorVCenter.y
            
            self.renderTImeLine(Int(offsetY), self.testItems)
            
            print("translationY offsetY dragging: \(offsetY)")
            //print("translationY dragging: \(translationY)")
        }
       
    }

    func drawText(_ txt:String, _ p: CGPoint) {
    
        let atts = [NSFontAttributeName: UIFont.init(name: "Georgia", size: 14)]
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
    
    
    func drawSineVertical(_ width:CGFloat, _ height: CGFloat){
        
        //let rotatePoint = CGPoint(x: width / 2, y: height / 2)
        //起始點
        //let origin = CGPoint(x: width * (1 - graphWidth) / 2, y: height * 0.50)
        let origin = CGPoint(x: width * 0.50, y: (height - 20))
        //print("origin: \(origin)")
        //let originRotate = rotate(original: origin, around: rotatePoint, with:rotateDegree)
        //drawRingFittingInsideView(origin.x, origin.y, UIColor.green.cgColor)
        
        
        let path = UIBezierPath()
        path.move(to: origin)
        let endRadius = 6000.0
        let step = 6.0
        for angle in stride(from: 0.0, through: endRadius, by: step) {
            //print("algle: \(angle)")
          
            //let x = origin.x + CGFloat(angle/endRadius) * width * graphWidth
            //let y = origin.y - CGFloat(sin(angle/180.0 * Double.pi)) * height * amplitude
            
            let x = origin.x - CGFloat(sin(angle/180.0 * Double.pi)) * width * amplitude
            let y = origin.y - CGFloat(angle/endRadius) * height * graphWidth
         
            let currentRefPoint = CGPoint(x:x, y:y)
            if currentRefPoint.y <= 40 {
                break
            }
          
            
            //currentRefPoint = rotate(original: currentRefPoint, around: rotatePoint, with: rotateDegree);
                        
            
            //let distanceBetweenTwoPoints = distance(a: currentRefPoint, b: perviousRefPoint)
            //            print("currentRefPoint: \(currentRefPoint)")
            //            print("perviousRefPoint: \(perviousRefPoint)")
            
            
            path.addLine(to: CGPoint(x: currentRefPoint.x, y: currentRefPoint.y))
            if angle == endRadius {
                //print("algle last : \(angle)")
                //drawRingFittingInsideView(currentRefPoint.x, currentRefPoint.y , UIColor.blue.cgColor)
            } else if angle != 0 {
                
                //drawRingFittingInsideView(currentRefPoint.x, currentRefPoint.y, UIColor.red.cgColor)
            }
            
            refPointsArr.append(currentRefPoint)
            let rem = angle.truncatingRemainder(dividingBy: 360.0)
            if rem == 0 {
                //print("find x center :angle: \(angle) refPointsArr.index:\(refPointsArr.count - 1)")
                self.startPoinsIndexOfrefPointsArr.append((refPointsArr.count - 1))
                //drawRingFittingInsideView(currentRefPoint.x, currentRefPoint.y, UIColor.red.cgColor)
            }
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
    
    func getRefPointsArr() -> [CGPoint] {
        return self.refPointsArr
    }
    
    func getCircleByIndex(_ index:Int) -> UIView {
        return self.circles[index] 
    }
    
    func clearAllCircleStatus() -> Void {
        
        for (_, circle) in self.circles.enumerated() {
                circle.backgroundColor = UIColor.clear
                circle.itemIndex = -1
            
        }
    }
    
    func renderTImeLine(_ startIndex:Int, _ items:[TestItem]){
        self.clearAllCircleStatus()
        let halfIndexOfStartPoinsIndexOfrefPointsArr = startPoinsIndexOfrefPointsArr.count / 2
        let indexOfStartPoin = startPoinsIndexOfrefPointsArr[halfIndexOfStartPoinsIndexOfrefPointsArr]
        let newIndexOfStartPoin = indexOfStartPoin - startIndex

        let oldRange = items.count
        let newRange = 215//adjust by phone screen size
        let circleIndexOfItemTest = newIndexOfStartPoin + (0 * newRange/oldRange)
        if circleIndexOfItemTest < 0 {
            return
        }
        let totalItemsCount =  self.circles.count
        
        for (index, item) in items.enumerated() {
            let circleIndexOfItem = newIndexOfStartPoin + (index * newRange/oldRange)
            //print("circleIndexOfItem: \(circleIndexOfItem)")
            if circleIndexOfItem < 0
                || circleIndexOfItem > (totalItemsCount - 1) {
                return
            }
            let circle:TimeLineCircleView = self.circles[circleIndexOfItem] 
            
            if index == 0 && self.firstPointParentV.x == 0 {
                self.firstPointParentV = self.convert(circle.center, to: self.superview)
                let originalCenter = self.center
                self.initCenter = originalCenter
                self.adjustFirstPoinToContainerBottom()
            }
            circle.itemIndex = item.index
            //print("circle.serial: \(circle.itemIndex)")
            switch item.result {
            case .NotDo:
                circle.backgroundColor = UIColor.clear
                circle.itemIndex = -1
            case .Pass:
                circle.backgroundColor = UIColor.green
            case .Failed:
                circle.backgroundColor = UIColor.red
         
            }
        }
        
    }
    
    func renderTImeLineRecursive (_ startIndex:Int, _ items:[TestItem]) {
        let op = (startIndex > 0) ? -1 : 1
        let newStartIndex = startIndex + op
        print("renderTImeLineRecursive: \(newStartIndex)")
        if newStartIndex == 0 {
            return
        }
        renderTImeLineRecursive(newStartIndex, items)
        
    }
    
    func adjustFirstPoinToContainerBottom() -> Void{
        self.center = CGPoint(x: self.initCenter.x, y: (self.initCenter.y + self.ajdustInitYVal))
        print("adjustFirstPoinToContainerBottom: \(self.center.y)")
    }
    
    
}
