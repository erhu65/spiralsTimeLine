//: Playground - noun: a place where people can play

import UIKit

import UIKit
import XCPlayground



class SineView: UIView{
    let graphWidth: CGFloat = 0.95  // Graph is 80% of the width of the view
    let amplitude: CGFloat = 0.18   // Amplitude of sine wave is 30% of view height
    let circleRadius:CGFloat = 5
    var perviousRefPoint:CGPoint = CGPoint(x:0, y:0)
    var refPointsArr: [CGPoint] = [];
    
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height

        drawSineHorizontal(width, height)
        print("refPointsArr: \(refPointsArr.count)")
//        
//        for refPoint in refPointsArr {
//            //drawRingFittingInsideView(refPoint.x, refPoint.y, UIColor.red.cgColor)
//           
//        }
        
        //drawRingFittingInsideView(252.083333333333, 474.443190290523)
        //drawRingFittingInsideView(254.166666666667, 447.563717799111)
        //x:252.083333333333, y:474.443190290523
        //x:254.166666666667, y:447.563717799111
        
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
        let origin = CGPoint(x: 10, y: height * 0.50)
        //print("origin: \(origin)")
        
        drawRingFittingInsideView(origin.x, origin.y, UIColor.green.cgColor)

        
        let path = UIBezierPath()
        path.move(to: origin)
        let endRadius = 1200.0
        let step = 5.0
        for angle in stride(from: 0.0, through: endRadius, by: step) {
            //print("algle: \(angle)")
            
            let x = origin.x + CGFloat(angle/endRadius) * width * graphWidth
            let y = origin.y - CGFloat(sin(angle/180.0 * Double.pi)) * height * amplitude
            
            var currentRefPoint = CGPoint(x:x, y:y)
            currentRefPoint = rotate(original: currentRefPoint, around: rotatePoint, with: -90);

            //currentRefPoint = currentRefPoint.applying(CGAffineTransform(rotationAngle: 90));

            
            let distanceBetweenTwoPoints = distance(a: currentRefPoint, b: perviousRefPoint)
//            print("currentRefPoint: \(currentRefPoint)")
//            print("perviousRefPoint: \(perviousRefPoint)")
        
            
            if(currentRefPoint.x != 0 
                && currentRefPoint.y != 0 
                && distanceBetweenTwoPoints == 10){
                
                
                //print("distanceBetweenTwoPoints: \(distanceBetweenTwoPoints)")
            }
            perviousRefPoint = currentRefPoint
            
            path.addLine(to: CGPoint(x: currentRefPoint.x, y: currentRefPoint.y))
            if angle == endRadius {
                //print("algle last : \(angle)")
                drawRingFittingInsideView(currentRefPoint.x, currentRefPoint.y , UIColor.blue.cgColor)
            } else if angle != 0 {

                drawRingFittingInsideView(currentRefPoint.x, currentRefPoint.y, UIColor.red.cgColor)
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


let sineView = SineView(frame: CGRect(x: 0, y: 0, width: 375.0, height: 667.0))
sineView.backgroundColor = .yellow


let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))

//XCPShowView(identifier: "Container View", view: containerView)
XCPlaygroundPage.currentPage.liveView = containerView

let signview = SineView(frame: CGRect(x: 40.0, y: 40.0, width: 20.0, height: 20.0))

let circle = UIView(frame: CGRect(x: 40.0, y: 40.0, width: 20.0, height: 20.0))
//circle.center = containerView.center
circle.layer.cornerRadius = 10.0

let startingColor = UIColor(red: (253.0/255.0), green: (159.0/255.0), blue: (47.0/255.0), alpha: 1.0)
circle.backgroundColor = startingColor


let rectangle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
rectangle.center = containerView.center
rectangle.layer.cornerRadius = 5.0

rectangle.backgroundColor = UIColor.white



//containerView.addSubview(rectangle)
//
//containerView.addSubview(circle);
containerView.addSubview(sineView);


