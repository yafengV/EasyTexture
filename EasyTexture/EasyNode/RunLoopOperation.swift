//
//  RunLoopOperation.swift
//  EasyTexture
//
//  Created by xuan on 2022/5/22.
//

import UIKit

protocol RunLoopOperation {
    func run()
}

class EasyLayoutOperation: RunLoopOperation {
    
    static weak var operation: EasyLayoutOperation?
    static func defaultOperation() -> EasyLayoutOperation {
        let operation = operation ?? EasyLayoutOperation()
        if self.operation == nil {
            self.operation = operation
            RunLoopObserver.defaultObserver.commitOperation(operation)
        }
        return operation
    }
    
    var layoutNode = Set<EasyNode>()
    
    var group: DispatchGroup = .init()
    var queue: DispatchQueue = .init(label: "com.xuan.easylayout", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    
    func run() {
        
        var layoutNode = Set<EasyNode>()
        
        for node in self.layoutNode {
            layoutNode.insert(node.layoutNode)
        }
        
        self.layoutNode.removeAll()
        
        for node in layoutNode {
            node.willLayout()
            queue.async(group: group, execute: .init(block: {
                node._layout()
            }))
        }
        
        group.notify(queue: .main) {
            for node in layoutNode {
                node.didLayout()
            }
        }
    }
    
    func pushLayoutNode(_ node: EasyNode) {
        layoutNode.insert(node)
    }
}

class EasyDrawOperation: RunLoopOperation {
    
    static weak var operation: EasyDrawOperation?
    static func defaultOperation() -> EasyDrawOperation {
        let operation = operation ?? EasyDrawOperation()
        if self.operation == nil {
            self.operation = operation
            RunLoopObserver.defaultObserver.commitOperation(operation)
        }
        return operation
    }
    
    var drawNode = Set<EasyNode>()
    
    var group: DispatchGroup = .init()
    var queue: DispatchQueue = .init(label: "com.xuan.easydraw", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    
    func run() {
        
        let drawNode = drawNode
        
        self.drawNode.removeAll()
        
        for node in drawNode {
            node.willDisplay()
            queue.async(group: group, execute: .init(block: {
                node._display()
            }))
        }
        
        group.notify(queue: .main) {
            for node in drawNode {
                node.didDisplay()
            }
        }
    }
    
    func pushDrawNode(_ node: EasyNode) {
        drawNode.insert(node)
    }
}

