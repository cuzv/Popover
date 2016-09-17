//
//  ArrowView.swift
//  PopoverSwift
//
//  Created by Moch Xiao on 3/19/16.
//  Copyright © 2016 mochxiao.com. All rights reserved.
//

import UIKit


extension Double {
    var radian: CGFloat {
        return CGFloat(self / 180.0 * M_PI)
    }
}

let ArrawWidthHalf: CGFloat = 5
let ArrawHeight: CGFloat = 10
let ArrawCenterX: CGFloat = 50
let CornerRadius: CGFloat = 5

class ArrowView : UIView {
    
    override func drawRect(rect: CGRect) {
        
        layer.masksToBounds = true
        clipsToBounds = true
        
        let path = UIBezierPath()
        
        
        debugPrint(CGRectGetWidth(bounds))
        debugPrint(rect)
        
        path.moveToPoint(CGPointMake(ArrawCenterX, 0))
        path.addLineToPoint(CGPointMake(ArrawCenterX - ArrawWidthHalf, ArrawHeight))
        path.addLineToPoint(CGPointMake(CornerRadius + ArrawHeight, ArrawHeight))

        path.addArcWithCenter(CGPointMake(CornerRadius, CornerRadius + ArrawHeight), radius: CornerRadius, startAngle: 270.radian, endAngle: 180.radian, clockwise: false)
        
        path.addLineToPoint(CGPointMake(0, CGRectGetHeight(bounds) - CornerRadius))

        path.addArcWithCenter(CGPointMake(CornerRadius, CGRectGetHeight(bounds) - CornerRadius), radius: CornerRadius, startAngle: 180.radian, endAngle: 90.radian, clockwise: false)
        
        path.addLineToPoint(CGPointMake(CGRectGetWidth(bounds) - CornerRadius, CGRectGetHeight(bounds)))
        
        path.addArcWithCenter(CGPointMake(CGRectGetWidth(bounds) - CornerRadius, CGRectGetHeight(bounds) - CornerRadius), radius: CornerRadius, startAngle: 90.radian, endAngle: 0.radian, clockwise: false)
        
        path.addLineToPoint(CGPointMake(CGRectGetWidth(bounds), CornerRadius + ArrawHeight))

        path.addArcWithCenter(CGPointMake(CGRectGetWidth(bounds) - CornerRadius, CornerRadius + ArrawHeight), radius: CornerRadius, startAngle: 0.radian, endAngle: -90.radian, clockwise: false)
        
        path.addLineToPoint(CGPointMake(ArrawCenterX + ArrawWidthHalf, ArrawHeight))

        
        path.closePath()
        
        
        UIColor.blueColor().setFill()
        path.fill()
        
        UIColor.redColor().setStroke()
        path.stroke()

    }    
}




internal func drawArrawImageIn(
    rect: CGRect,
    strokeColor: UIColor,
    fillColor: UIColor = UIColor.clearColor(),
    lineWidth: CGFloat = 1,
    arrawCenterX: CGFloat,
    arrawWidth: CGFloat = 5,
    arrawHeight: CGFloat = 10,
    cornerRadius: CGFloat = 6,
    handstand: Bool = false
    ) -> UIImage
{
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    
    if handstand {
        CGContextSetTextMatrix(context!, CGAffineTransformIdentity)
        CGContextTranslateCTM(context!, 0, CGRectGetHeight(rect))
        CGContextScaleCTM(context!, 1.0, -1.0)
    }
    
    // Perform the drawing
    CGContextSetLineWidth(context!, lineWidth)
    CGContextSetStrokeColorWithColor(context!, strokeColor.CGColor)
    CGContextSetFillColorWithColor(context!, fillColor.CGColor)
    
    let path = CGPathCreateMutable()
    let lineHalfWidth = lineWidth / 2.0
    let arrawHalfWidth = arrawWidth / 2.0
    CGPathMoveToPoint(path, nil, arrawCenterX, lineWidth)
    CGPathAddLineToPoint(path, nil, arrawCenterX - arrawHalfWidth, arrawHeight + lineWidth)
    CGPathAddLineToPoint(path, nil, cornerRadius + arrawHeight, arrawHeight + lineWidth)
    
    CGPathAddArc(path, nil, cornerRadius + lineHalfWidth, cornerRadius + arrawHeight + lineWidth, cornerRadius, 270.radian, 180.radian, true)
    CGPathAddLineToPoint(path, nil, lineHalfWidth, CGRectGetHeight(rect) - cornerRadius - lineHalfWidth)
    CGPathAddArc(path, nil, cornerRadius + lineHalfWidth, CGRectGetHeight(rect) - cornerRadius - lineHalfWidth, cornerRadius, 180.radian, 90.radian, true)
    CGPathAddLineToPoint(path, nil, CGRectGetWidth(rect) - cornerRadius - lineHalfWidth, CGRectGetHeight(rect) - lineHalfWidth)
    
    
    CGPathAddArc(path, nil, CGRectGetWidth(rect) - cornerRadius - lineHalfWidth, CGRectGetHeight(rect) - cornerRadius - lineHalfWidth, cornerRadius, 90.radian, 0.radian, true)
    
    CGPathAddLineToPoint(path, nil, CGRectGetWidth(rect) - lineHalfWidth, arrawHeight + cornerRadius + lineWidth / 2)
    
    CGPathAddArc(path, nil, CGRectGetWidth(rect) - cornerRadius - lineHalfWidth, cornerRadius + arrawHeight + lineWidth, cornerRadius, 0.radian, -90.radian, true)

    CGPathAddLineToPoint(path, nil, arrawCenterX + arrawHalfWidth, arrawHeight + lineWidth)
    CGPathCloseSubpath(path)
    
    CGContextAddPath(context!, path)
    CGContextDrawPath(context!, .FillStroke)
    
    let output = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return output!
}












