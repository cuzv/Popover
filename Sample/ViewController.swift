//
//  ViewController.swift
//  Sample
//
//  Created by Moch Xiao on 3/18/16.
//  Copyright © 2016 mochxiao.com. All rights reserved.
//

import UIKit
import PopoverSwift

class ViewController: UIViewController {

    @IBOutlet weak var leftTopButton: UIButton!
    
    @IBOutlet weak var rightTopButton: UIButton!

    @IBOutlet weak var centerButton: UIButton!

    @IBOutlet weak var leftBottomButton: UIButton!
    
    @IBOutlet weak var rightBottomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGrayColor()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ViewController.add(_:)))
    }
    
    func add(sender: UIBarButtonItem) {
        if popoverDidAppear {
            dismissPopover()
        } else {
            let controller = PopoverController(items: makeItems(), fromView: rightTopButton, direction: .Down, style: .WithImage)
            popover(controller)
        }
    }
    
    
    func makeItems() -> [PopoverItem] {
        let image = UIImage(named: "collection_hightlight")
        let item0 = PopoverItem(title: "发起群聊", image: image) { debugPrint($0.title) }
        let item1 = PopoverItem(title: "添加胖友", image: image) { debugPrint($0.title) }
        let item2 = PopoverItem(title: "扫一扫", image: image) { debugPrint($0.title) }
        let item3 = PopoverItem(title: "收付款", image: image) { debugPrint($0.title) }
        return [item0, item1, item2, item3]
    }

    @IBAction func centerTopAction(sender: AnyObject) {
        let controller = PopoverController(items: makeItems(), fromView: centerButton, style: .WithImage)
        controller.coverColor = UIColor.grayColor()
        controller.textColor = UIColor.whiteColor()
        popover(controller)
    }

    @IBAction func leftTopAction(sender: AnyObject) {
        let controller = PopoverController(items: makeItems(), fromView: leftTopButton, direction: .Down)
        popover(controller)
    }

    @IBAction func rightTopAction(sender: AnyObject) {
        let controller = PopoverController(items: makeItems(), fromView: rightTopButton, direction: .Down, style: .WithImage)
        popover(controller)
    }
    
    @IBAction func leftBottomAction(sender: AnyObject) {
        let controller = PopoverController(items: makeItems(), fromView: leftBottomButton, direction: .Up, reverseHorizontalCoordinates: true)
        popover(controller)
    }
    
    @IBAction func rightBottomAction(sender: AnyObject) {
        let controller = PopoverController(items: makeItems(), fromView: rightBottomButton, direction: .Up, reverseHorizontalCoordinates: true)
        popover(controller)
    }
}

