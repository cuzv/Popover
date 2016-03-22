//
//  PopoverCell.swift
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

final class PopoverCell: UITableViewCell {
    static let identifier: String = "PopoverCell"
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = CellLabelFont
        label.lineBreakMode = .ByCharWrapping
        label.textAlignment = .Center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clearColor()
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUserInterface()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

#if DEBUG
    deinit {
        debugPrint("\(#file):\(#line):\(self.dynamicType):\(#function)")
    }
#endif
}

extension PopoverCell {
    private func setupUserInterface() {
        separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
        backgroundColor = UIColor.clearColor()
        
        contentView.addSubview(contentLabel)
        contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "|-\(Leading)-[contentLabel]-\(Leading)-|",
                options: NSLayoutFormatOptions.DirectionLeadingToTrailing,
                metrics: nil,
                views: ["contentLabel": contentLabel]
            )
        )
        contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:|-0-[contentLabel]-0-|",
                options: NSLayoutFormatOptions.DirectionLeadingToTrailing,
                metrics: nil,
                views: ["contentLabel": contentLabel]
            )
        )
    }

    func setupData(data: PopoverItem) {
        contentLabel.text = data.title
        if let textColor = data.textColor {
            contentLabel.textColor = textColor
        }
        
        contentView.backgroundColor = data.coverColor ?? UIColor.whiteColor()        
    }
}


final class PopoverWihtImageCell: UITableViewCell {
    static let identifier: String = "PopoverWihtImageCell"
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = CellLabelFont
        label.lineBreakMode = .ByCharWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clearColor()
        return label
    }()
    
    let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.clearColor()
        return imageView
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUserInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
#if DEBUG
    deinit {
        debugPrint("\(#file):\(#line):\(self.dynamicType):\(#function)")
    }
#endif
}

extension PopoverWihtImageCell {
    private func setupUserInterface() {
        separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
        backgroundColor = UIColor.clearColor()
        
        contentView.addSubview(contentLabel)
        contentView.addSubview(leftImageView)
        contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "|-\(Leading)-[leftImageView(\(ImageWidth))]-\(Spacing)-[contentLabel]-\(Leading)-|",
                options: NSLayoutFormatOptions.DirectionLeadingToTrailing,
                metrics: nil,
                views: ["contentLabel": contentLabel, "leftImageView": leftImageView]
            )
        )
        contentView.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:|-0-[contentLabel]-0-|",
                options: NSLayoutFormatOptions.DirectionLeadingToTrailing,
                metrics: nil,
                views: ["contentLabel": contentLabel]
            )
        )        
        contentView.addConstraint(
            NSLayoutConstraint(
                item: leftImageView,
                attribute: .CenterY,
                relatedBy: .Equal,
                toItem: contentLabel,
                attribute: .CenterY,
                multiplier: 1,
                constant: 0
            )
        )
    }
    
    func setupData(data: PopoverItem) {
        contentLabel.text = data.title
        if let textColor = data.textColor {
            contentLabel.textColor = textColor
        }
        leftImageView.image = data.image
        contentView.backgroundColor = data.coverColor ?? UIColor.whiteColor()
    }
}


