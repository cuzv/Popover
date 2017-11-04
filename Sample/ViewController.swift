//
//  ViewController.swift
//  Sample
//
//  Created by Roy Shaw on 3/18/16.
//  Copyright © 2016 Red Rain. All rights reserved.
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
        
        view.backgroundColor = UIColor.lightGray
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.add(_:)))
    }
    
    func add(_ sender: UIBarButtonItem) {
        if popoverDidAppear {
            dismissPopover()
        } else {
            let controller = PopoverController(items: makeItems(), fromView: rightTopButton, direction: .down, style: .withImage)
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
    
    func makeHugeItems() -> [PopoverItem] {
        let image = UIImage(named: "collection_hightlight")
        return (0..<100).map { PopoverItem(title: "Item #\($0+1)", image: image) }
    }

    @IBAction func centerTopAction(_ sender: AnyObject) {
        let controller = PopoverController(items: makeHugeItems(), fromView: centerButton, style: .withImage, initialIndex: 50)
        controller.coverColor = UIColor.gray
        controller.textColor = UIColor.white
        popover(controller)
    }

    @IBAction func leftTopAction(_ sender: AnyObject) {
        let controller = PopoverController(items: makeItems(), fromView: leftTopButton, direction: .down)
        popover(controller)
    }

    @IBAction func rightTopAction(_ sender: AnyObject) {
        let controller = PopoverController(items: makeItems(), fromView: rightTopButton, direction: .down, style: .withImage)
        popover(controller)
    }
    
    @IBAction func leftBottomAction(_ sender: AnyObject) {
        let controller = PopoverController(items: makeItems(), fromView: leftBottomButton, direction: .up, reverseHorizontalCoordinates: true)
        popover(controller)
    }
    
    @IBAction func rightBottomAction(_ sender: AnyObject) {
        let controller = PopoverController(items: makeItems(), fromView: rightBottomButton, direction: .up, reverseHorizontalCoordinates: true)
        popover(controller)
    }
}

