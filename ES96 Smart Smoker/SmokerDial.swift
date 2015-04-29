//
//  TempDial.swift
//  ES96 Smart Smoker
//
//  Created by Jerry Chang on 4/22/15.
//  Copyright (c) 2015 JerryChang. All rights reserved.
//

import UIKit

let MaxSmokerTemp = 450
let π: CGFloat = CGFloat(M_PI)

@IBDesignable class SmokerDial: UIView {
    
    @IBInspectable var smokerTemp: Int = 100 {
        didSet {
            if smokerTemp <= MaxSmokerTemp {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var greenColor: UIColor = UIColor.greenColor()
    @IBInspectable var blueColor: UIColor = UIColor.blueColor()
    @IBInspectable var redColor: UIColor = UIColor.redColor()
    @IBInspectable var dialColor: UIColor = UIColor.darkGrayColor()
    
    
    override func drawRect(rect: CGRect) {
        
        //Set Dial Parameters
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = 76
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = π / 4
        
        //Draw and Color Dial
        var path = UIBezierPath(arcCenter: center,
            radius: radius/2 - arcWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        
        path.lineWidth = arcWidth
        dialColor.setStroke()
        path.stroke()
        
        //Draw and Color Current Temp Indicator
        let angleDifference: CGFloat = 2 * π - startAngle + endAngle
        let arcLengthPerDegree = angleDifference / CGFloat(MaxSmokerTemp)
        
        var arcAngle = min(smokerTemp, MaxSmokerTemp)
        
        let outlineEndAngle = arcLengthPerDegree * CGFloat(arcAngle) + startAngle
        
        var outlinePath = UIBezierPath(arcCenter: center,
            radius: bounds.width/2 - 2.5,
            startAngle: startAngle,
            endAngle: outlineEndAngle,
            clockwise: true)
        
        outlinePath.addArcWithCenter(center,
            radius: bounds.width/2 - arcWidth + 2.5,
            startAngle: outlineEndAngle,
            endAngle: startAngle,
            clockwise: false)
        
        outlinePath.closePath()
        greenColor.setFill()
        
        if (smokerTemp > 245) {
            redColor.setFill()
        }
        else if (smokerTemp < 207) {
            blueColor.setFill()
        }
        outlinePath.lineWidth = 5.0
        outlinePath.fill()
        
    }
}

