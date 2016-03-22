//
//  PopoverView.swift
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

public class PopoverView: UIView {
    private let items: [PopoverItem]
    private let fromView: UIView
    private let direction: Direction
    private let reverseHorizontalCoordinates: Bool
    private let style: PopoverStyle
    
    private weak var commonSuperView: UIView!
    
    let arrawView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.rowHeight = RowHeight
        tableView.bounces = false
        tableView.tableHeaderView = UIView(frame: CGRectMake(0, 0, 0, CGFloat.min))
        tableView.tableFooterView = UIView(frame: CGRectMake(0, 0, 0, CGFloat.min))        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = CornerRadius
        tableView.layer.masksToBounds = true
        
        return tableView
    }()
    
    lazy var tableViewWidth: CGFloat = {
        var maxLengthTitle: String = ""
        self.items.forEach { (item: PopoverItem) -> () in
            if item.title.length > maxLengthTitle.length {
                maxLengthTitle = item.title
            }
        }
        var width: CGFloat = maxLengthTitle.sizeWithFont(CellLabelFont, preferredMaxLayoutWidth: CGFloat.max).width
        if width < 60 {
            width = 60
        }
        
        width += Leading * 2
        
        if self.style == .WithImage {
            width += ImageWidth + Spacing
        }
        
        return width
    }()
    
    lazy var tableViewHeight: CGFloat = {
        let count = self.items.count > MaxRowCount ? MaxRowCount : self.items.count
        return CGFloat(count) * RowHeight
    }()

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(_ host: PopoverController, commonSuperView: UIView) {
        if host.reverseHorizontalCoordinates {
            self.items = host.items.reverse()
        } else {
            self.items = host.items
        }
        self.fromView = host.fromView
        self.direction = host.direction
        self.reverseHorizontalCoordinates = host.reverseHorizontalCoordinates
        self.style = host.style
        
        self.commonSuperView = commonSuperView
        
        super.init(frame: CGRectZero)
        
        setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if nil != arrawView.layer.contents {
            return
        }
        
        let color = items[0].coverColor ?? UIColor.whiteColor()
        let arrawCenterX: CGFloat = CGRectGetMidX(fromView.frame) - CGRectGetMidX(arrawView.frame) + CGRectGetMidX(arrawView.bounds)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            let image = drawArrawImageIn(
                self.arrawView.bounds,
                strokeColor: color,
                fillColor: color,
                lineWidth: LineWidth,
                arrawCenterX: arrawCenterX,
                arrawWidth: 10,
                arrawHeight: 10,
                cornerRadius: CornerRadius,
                handstand: self.reverseHorizontalCoordinates
            )
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.arrawView.image = image
            })
        }
    }

    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(arrawView)
        addSubview(tableView)
        
        var clazz: AnyClass? = PopoverCell.self
        var identifier: String = PopoverCell.identifier
        if style == .WithImage {
            clazz = PopoverWihtImageCell.self
            identifier = PopoverWihtImageCell.identifier
        }
        tableView.registerClass(clazz, forCellReuseIdentifier: identifier)
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let location = touches.first?.locationInView(self) where !CGRectContainsPoint(arrawView.frame, location) {
            dismiss()
        }
    }
    
    func dismiss() {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.tableView.alpha = 0
            self.arrawView.alpha = 0
        }) {_ in
            self.subviews.forEach{ $0.removeFromSuperview() }
            self.removeFromSuperview()
        }
    }
    
    func addConstraints() {
        let screenWidth: CGFloat = CGRectGetWidth(superview!.frame)
        var centerX: CGFloat = fromView.frame.origin.x + CGRectGetWidth(fromView.bounds) / 2.0
        let rightHand = centerX - screenWidth / 2.0 > 0
        if rightHand {
            centerX = screenWidth - centerX
        }
        
        var constant0: CGFloat = 0
        let distance = centerX - (tableViewWidth / 2.0 + 6)
        if distance <= 0 {
            constant0 = rightHand ? distance : -distance
        }
        
        var attribute0: NSLayoutAttribute = .Top
        var attribute1: NSLayoutAttribute = .Bottom
        var constant1: CGFloat = 10

        if direction == .Up {
            attribute0 = .Bottom
            attribute1 = .Top
            constant1 = -10
        }
        
        commonSuperView.addConstraints([
            NSLayoutConstraint(
                item: tableView,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: fromView,
                attribute: .CenterX,
                multiplier: 1,
                constant: constant0
            ),
            NSLayoutConstraint(
                item: tableView,
                attribute: attribute0,
                relatedBy: .Equal,
                toItem: fromView,
                attribute: attribute1,
                multiplier: 1,
                constant: constant1
            ),
            NSLayoutConstraint(
                item: tableView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1,
                constant: tableViewWidth
            ),
            NSLayoutConstraint(
                item: tableView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1,
                constant: tableViewHeight
            )
        ])
        
        commonSuperView.addConstraints([
            NSLayoutConstraint(
                item: arrawView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: tableView,
                attribute: .Width,
                multiplier: 1,
                constant: LineWidth * 2
            ),
            NSLayoutConstraint(
                item: arrawView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: tableView,
                attribute: .Height,
                multiplier: 1,
                constant: fabs(constant1) - 2
            ),
            NSLayoutConstraint(
                item: arrawView,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: tableView,
                attribute: .CenterX,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: arrawView,
                attribute: .CenterY,
                relatedBy: .Equal,
                toItem: tableView,
                attribute: .CenterY,
                multiplier: 1,
                constant: -constant1 / 2.0
            ),            
        ])
    }
    
#if DEBUG
    deinit {
        debugPrint("\(#file):\(#line):\(self.dynamicType):\(#function)")
    }
#endif
}

extension PopoverView: UITableViewDataSource {
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if style == .WithImage {
            guard let cell = tableView.dequeueReusableCellWithIdentifier(PopoverWihtImageCell.identifier) as? PopoverWihtImageCell else {
                fatalError("Must register cell first")
            }
            cell.setupData(items[indexPath.row])
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCellWithIdentifier(PopoverCell.identifier) as? PopoverCell else {
                fatalError("Must register cell first")
            }
            cell.setupData(items[indexPath.row])
            return cell
        }
    }
}

extension PopoverView: UITableViewDelegate {
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let popoverItem = items[indexPath.row]
        popoverItem.handler?(popoverItem)
        dismiss()
    }
}