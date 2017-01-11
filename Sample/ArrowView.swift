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
    
    override func draw(_ rect: CGRect) {
        
        layer.masksToBounds = true
        clipsToBounds = true
        
        let path = UIBezierPath()
        
        
        debugPrint(bounds.width)
        debugPrint(rect)
        
        path.move(to: CGPoint(x: ArrawCenterX, y: 0))
        path.addLine(to: CGPoint(x: ArrawCenterX - ArrawWidthHalf, y: ArrawHeight))
        path.addLine(to: CGPoint(x: CornerRadius + ArrawHeight, y: ArrawHeight))
        
        path.addArc(withCenter: CGPoint(x: CornerRadius, y: CornerRadius + ArrawHeight), radius: CornerRadius, startAngle: 270.radian, endAngle: 180.radian, clockwise: false)
        
        path.addLine(to: CGPoint(x: 0, y: bounds.height - CornerRadius))
        
        path.addArc(withCenter: CGPoint(x: CornerRadius, y: bounds.height - CornerRadius), radius: CornerRadius, startAngle: 180.radian, endAngle: 90.radian, clockwise: false)
        
        path.addLine(to: CGPoint(x: bounds.width - CornerRadius, y: bounds.height))
        
        path.addArc(withCenter: CGPoint(x: bounds.width - CornerRadius, y: bounds.height - CornerRadius), radius: CornerRadius, startAngle: 90.radian, endAngle: 0.radian, clockwise: false)
        
        path.addLine(to: CGPoint(x: bounds.width, y: CornerRadius + ArrawHeight))
        
        path.addArc(withCenter: CGPoint(x: bounds.width - CornerRadius, y: CornerRadius + ArrawHeight), radius: CornerRadius, startAngle: 0.radian, endAngle: -90.radian, clockwise: false)
        
        path.addLine(to: CGPoint(x: ArrawCenterX + ArrawWidthHalf, y: ArrawHeight))

        path.close()
        
        UIColor.blue.setFill()
        path.fill()
        
        UIColor.red.setStroke()
        path.stroke()
        
    }
}

internal func drawArrawImageIn(
    _ rect: CGRect,
    strokeColor: UIColor,
    fillColor: UIColor = UIColor.clear,
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
        context!.textMatrix = CGAffineTransform.identity
        context!.translateBy(x: 0, y: rect.height)
        context!.scaleBy(x: 1.0, y: -1.0)
    }
    
    // Perform the drawing
    context!.setLineWidth(lineWidth)
    context!.setStrokeColor(strokeColor.cgColor)
    context!.setFillColor(fillColor.cgColor)
    
    let path = CGMutablePath()
    let lineHalfWidth = lineWidth / 2.0
    let arrawHalfWidth = arrawWidth / 2.0
    path.move(to: CGPoint(x: arrawCenterX, y: lineWidth))
    path.addLine(to: CGPoint(x: arrawCenterX - arrawHalfWidth, y: arrawHeight + lineWidth))
    path.addLine(to: CGPoint(x: cornerRadius + arrawHeight, y: arrawHeight + lineWidth))
    path.addArc(center:  CGPoint(x:cornerRadius + lineHalfWidth, y:cornerRadius + arrawHeight + lineWidth), radius: cornerRadius, startAngle: 270.radian, endAngle: 180.radian, clockwise: true)
    path.addLine(to: CGPoint(x: lineHalfWidth, y: rect.height - cornerRadius - lineHalfWidth))
    path.addArc(center:  CGPoint(x:cornerRadius + lineHalfWidth, y:rect.height - cornerRadius - lineHalfWidth), radius: cornerRadius, startAngle: 180.radian, endAngle: 90.radian, clockwise: true)
    path.addLine(to: CGPoint(x: rect.width - cornerRadius - lineHalfWidth, y:  rect.height - lineHalfWidth))
    path.addArc(center:  CGPoint(x:rect.width - cornerRadius - lineHalfWidth, y: rect.height - cornerRadius - lineHalfWidth), radius: cornerRadius, startAngle: 90.radian, endAngle: 0.radian, clockwise: true)
    path.addLine(to: CGPoint(x: rect.width - lineHalfWidth, y: arrawHeight + cornerRadius + lineWidth / 2))
    path.addArc(center:  CGPoint(x:rect.width - cornerRadius - lineHalfWidth, y:cornerRadius + arrawHeight + lineWidth), radius: cornerRadius, startAngle: 0.radian, endAngle: -90.radian, clockwise: true)
    path.addLine(to: CGPoint(x: arrawCenterX + arrawHalfWidth, y: arrawHeight + lineWidth))
    
    path.closeSubpath()
    
    context!.addPath(path)
    context!.drawPath(using: .fillStroke)
    
    let output = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return output!
}
