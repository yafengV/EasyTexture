//
//  ViewController.swift
//  EasyTexture
//
//  Created by xuan on 2022/5/22.
//

import UIKit
import YogaKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Demo"
        view.backgroundColor = .white
//
        let node: EasyNode = .init(frame: .zero)
        node.layout.left = 0
        node.layout.top = 0
        node.layout.width = Float(view.bounds.width)
        node.layout.height = Float(view.bounds.height)
        node.backgroundColor = .red
        node.layout.flexDirection = .row
        node.layout.justifyContent = .flexStart
        node.layout.alignItems = .center

        let node2: EasyNode = .init(frame: .zero)
        node2.layout.flexGrow = 1
        node2.layout.alignSelf = .stretch
        node2.backgroundColor = .yellow

        let node3: EasyNode = .init(frame: .zero)
        node3.layout.flexGrow = 1
        node3.layout.height = 100
        node3.backgroundColor = .blue

        node.addSubNode(node2)
        node.addSubNode(node3)

        view.addSubNode(node)
        node.setNeedsLayout()
        
//        let view1 = UIView.init(frame: .zero)
//        view1.backgroundColor = .red
//        view1.yoga.left = 0
//        view1.yoga.top = 0
//        view1.yoga.width = YGValue(view.bounds.width)
//        view1.yoga.height = YGValue(view.bounds.height)
//        view1.yoga.flexDirection = .row
//        view1.yoga.justifyContent = .flexStart
//        view1.yoga.alignItems = .center
//        view1.yoga.isEnabled = true
//
//        let view2 = UIView.init(frame: .zero)
//        view2.backgroundColor = .yellow
//        view2.yoga.width = 100
//        view2.yoga.height = 100
//        view2.yoga.isEnabled = true
//
//        let view3 = UIView.init(frame: .zero)
//        view3.backgroundColor = .blue
//        view3.yoga.width = 100
//        view3.yoga.height = 200
//        view3.yoga.isEnabled = true
//
//        view.addSubview(view1)
//        view1.addSubview(view2)
//        view1.addSubview(view3)
//        view1.yoga.applyLayout(preservingOrigin: false)
    }


}

