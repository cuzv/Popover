//
//  TypeAliases.swift
//  PopoverSwift
//
//  Created by Vadim Yushchenko on 2/4/19.
//  Copyright © 2019 mochxiao.com. All rights reserved.
//

import UIKit

#if swift(>=4.2)
typealias FontTextStyle = UIFont.TextStyle
typealias AttributedStringKey = NSAttributedString.Key
typealias LayoutFormatOptions = NSLayoutConstraint.FormatOptions
typealias TableViewCellStyle = UITableViewCell.CellStyle
typealias LayoutAttribute = NSLayoutConstraint.Attribute
#else
typealias FontTextStyle = UIFontTextStyle
typealias AttributedStringKey = NSAttributedStringKey
typealias LayoutFormatOptions = NSLayoutFormatOptions
typealias TableViewCellStyle = UITableViewCellStyle
typealias LayoutAttribute = NSLayoutAttribute
#endif
