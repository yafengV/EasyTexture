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
        testNode()
//        testView()
    }
    
    func testNode() {
        let node: EasyNode = .init(frame: .zero)
        node.layout.left = 0
        node.layout.top = 0
        node.layout.width = Float(view.bounds.width)
        node.layout.height = Float(view.bounds.height)
        node.backgroundColor = .white
        node.layout.flexDirection = .row
        node.layout.justifyContent = .flexStart
        node.layout.alignItems = .center

        let node2: EasyNode = .init(frame: .zero)
        node2.backgroundColor = .yellow
        node2.layout.flexDirection = .column
        node2.layout.justifyContent = .center
        
        let textNode: EasyTextNode = .init(frame: .zero)
        textNode.layout.alignSelf = .stretch
        textNode.backgroundColor = .red
        textNode.text = .init(string: "我我我我我我我我我我我我我哦我我我", attributes:[.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16)])
        textNode.tag = "text"
        textNode.layout.maxWidth = Float(UIScreen.main.bounds.width / 2)
        node2.addSubNode(textNode)
        
        let controlNode: EasyControlNode = .init(frame: .zero)
        controlNode.layout.width = 100
        controlNode.layout.height = 100
        controlNode.backgroundColor = .brown
        controlNode.control?.addTarget(self, action: #selector(onClick(sender:)), for: .touchUpInside)
        node2.addSubNode(controlNode)

        let node3: EasyNode = .init(frame: .zero)
        node3.layout.flexGrow = 1
        node3.layout.alignSelf = .stretch
        node3.layout.justifyContent = .center
        node3.backgroundColor = .green
        
        let imageNode: EasyImageNode = .init(frame: .zero)
        imageNode.image = .init(named: "test")
        node3.addSubNode(imageNode)

        node.addSubNode(node2)
        node.addSubNode(node3)

        view.addSubNode(node)
        node.setNeedsLayout()
    }
    
    func testView() {
        let node: UIView = .init(frame: .zero)
        node.yoga.isEnabled = true
        node.yoga.left = 0
        node.yoga.top = 0
        node.yoga.width = .init(view.bounds.width)
        node.yoga.height = .init(view.bounds.height)
        node.backgroundColor = .red
        node.yoga.flexDirection = .row
        node.yoga.justifyContent = .flexStart
        node.yoga.alignItems = .center
        node.yoga.flexGrow = 1
        node.yoga.flexShrink = 1
        node.yoga.flexWrap = .noWrap

        let node2: UIView = .init(frame: .zero)
        node2.yoga.isEnabled = true
        node2.yoga.flexGrow = 1
//        node2.yoga.flexShrink = 1
//        node2.yoga.flexWrap = .noWrap
//        node2.yoga.alignSelf = .stretch
        node2.backgroundColor = .yellow
//        node2.yoga.flexDirection = .column
//        node2.yoga.justifyContent = .center
//        node2.yoga.alignItems = .flexStart
        
//        let node4: UIView = .init(frame: .zero)
//        node4.yoga.isEnabled = true
//        node4.backgroundColor = .gray
//        node4.yoga.height = 100
//        node4.yoga.alignSelf = .stretch
//        node2.addSubview(node4)

        let textNode: UILabel = .init(frame: .zero)
        textNode.yoga.isEnabled = true
        textNode.yoga.alignSelf = .stretch
        textNode.backgroundColor = .blue
        textNode.text = "哈哈哈哈哈哈哈哈哈哈或或或或或或或或或或或或或或或或或或或或或或或或或或"
        textNode.font = .systemFont(ofSize: 16)
//        textNode.yoga.flexGrow = 1
//        textNode.yoga.flexShrink = 1
//        textNode.yoga.flexWrap = .noWrap
        textNode.yoga.maxWidth = YGValue(UIScreen.main.bounds.width / 2)
        textNode.textColor = .white
        textNode.numberOfLines = 0
        node2.addSubview(textNode)

        let node3: UIView = .init(frame: .zero)
        node3.yoga.isEnabled = true
        node3.yoga.flexGrow = 1
        node3.yoga.alignSelf = .stretch
        node3.backgroundColor = .green
//        node3.yoga.flexShrink = 1
//        node3.yoga.flexWrap = .noWrap

        node.addSubview(node2)
        node.addSubview(node3)

        view.addSubview(node)
        node.yoga.applyLayout(preservingOrigin: false)
    }

    @objc func onClick(sender: UIControl) {
        print("xuan xuan")
    }

}

