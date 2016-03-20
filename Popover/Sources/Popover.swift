//
//  Popover.swift
//  Popover
//
//  Created by Moch Xiao on 3/18/16.
//  Copyright © @2016 Moch Xiao (http://mochxiao.com).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

let CellLabelFont = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
let Leading: CGFloat = 20
let Spacing: CGFloat = 14
let ImageWidth: CGFloat = 20
let RowHeight: CGFloat = 44
let MaxRowCount = 7
let LineWidth: CGFloat = 1
let CornerRadius: CGFloat = 6

public enum Direction {
    case Up, Down
}

public enum PopoverStyle {
    case Normal, WithImage
}

internal struct AssociationKey {
    internal static var PopoverView: String = "PopoverView"
}

/// Convert a `void *` type to Swift type, use this function carefully
private func convertUnsafePointerToSwiftType<T>(value: UnsafePointer<Void>) -> T {
    return unsafeBitCast(value, UnsafePointer<T>.self).memory
}

internal extension UIViewController {
    internal var popoverView: PopoverView? {
        get { return objc_getAssociatedObject(self, &AssociationKey.PopoverView) as? PopoverView }
        set { objc_setAssociatedObject(self, &AssociationKey.PopoverView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

internal extension String {
    internal var length: Int {
        return lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    }
    
    internal func sizeWithFont(font: UIFont, preferredMaxLayoutWidth: CGFloat) -> CGSize {
        let str = self as NSString
        let options: NSStringDrawingOptions = [.UsesLineFragmentOrigin, .UsesFontLeading, .TruncatesLastVisibleLine]
        return str.boundingRectWithSize(CGSizeMake(preferredMaxLayoutWidth, CGFloat.max), options: options, attributes: [NSFontAttributeName: font], context: nil).size
    }
}

internal extension Double {
    var radian: CGFloat {
        return CGFloat(self / 180.0 * M_PI)
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
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
    let context = UIGraphicsGetCurrentContext()

    if handstand {
        CGContextSetTextMatrix(context, CGAffineTransformIdentity)
        CGContextTranslateCTM(context, 0, CGRectGetHeight(rect))
        CGContextScaleCTM(context, 1.0, -1.0)
    }
    
    // Perform the drawing
    CGContextSetLineWidth(context, lineWidth)
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor)
    CGContextSetFillColorWithColor(context, fillColor.CGColor)
    
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
    CGPathAddLineToPoint(path, nil, CGRectGetWidth(rect) - lineHalfWidth, arrawHeight + cornerRadius + lineHalfWidth)
    CGPathAddArc(path, nil, CGRectGetWidth(rect) - cornerRadius - lineHalfWidth, cornerRadius + arrawHeight + lineWidth, cornerRadius, 0.radian, -90.radian, true)
    CGPathAddLineToPoint(path, nil, arrawCenterX + arrawHalfWidth, arrawHeight + lineWidth)
    CGPathCloseSubpath(path)
    
    CGContextAddPath(context, path)
    CGContextDrawPath(context, .FillStroke)
    
    let output = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return output
}
