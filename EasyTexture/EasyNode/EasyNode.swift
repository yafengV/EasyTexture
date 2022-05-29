//
//  EasyNode.swift
//  EasyTexture
//
//  Created by xuan on 2022/5/22.
//

import UIKit

class EasyNode: NSObject {
    
    weak var superNode: EasyNode?
    var subnodes: [EasyNode] = []

    var frame: CGRect
    var backgroundColor: UIColor? {
        didSet {
            guard backgroundColor != oldValue else {
                return
            }
            setNeedsDisplay()
        }
    }
    
    var view: EasyView
    var layer: EasyLayer
    lazy var layout: EasyLayout = .init(node: self)
    
    var content: UIImage?
    
    var drawTask: EasyTask?
    
    var layoutNode: EasyNode {
        if let superNode = superNode {
            return superNode.layoutNode
        }
        return self
    }
    
    init(frame: CGRect) {
        self.frame = frame
        view = .init(frame: frame)
        layer = view.layer as! EasyLayer
        super.init()
        layer.node = self
        view.node = self
    }
    
    func _layout() {
        layout.layout()
    }
    
    func sizeThatFits(_ size: CGSize) -> CGSize {
        .zero
    }
    
    func setNeedsLayout() {
        assert(Thread.current == Thread.main)
        if let superNode = superNode {
            superNode.setNeedsLayout()
        } else {
            commitLayout()
        }
    }
    
    func commitLayout() {
        assert(Thread.current == Thread.main)
        EasyLayoutOperation.defaultOperation().pushLayoutNode(self)
    }
    
    func willLayout() {
        assert(Thread.current == Thread.main)
        layout.willLayout()
    }
    
    func didLayout() {
        assert(Thread.current == Thread.main)
        layout.didLayout()
    }
    
    func attachFrameToView() {
        view.frame = frame
        for subnode in subnodes {
            subnode.attachFrameToView()
        }
    }
    
    func layoutChanged() {
        assert(Thread.current == Thread.main)
        attachFrameToView()
        view.setNeedsLayout()
        setNeedsDisplay()
    }
    
    func _display() {
        drawTask?.run()
    }
    
    func setNeedsDisplay() {
        assert(Thread.current == Thread.main)
        EasyDrawOperation.defaultOperation().pushDrawNode(self)
        for subnode in subnodes {
            subnode.setNeedsDisplay()
        }
    }
    
    func willDisplay() {
        drawTask?.cancel()
        let node = self.easyCopy()
        drawTask = .init()
        drawTask?.obj = node
        let size = node.frame.size
        let opaque = true
        let scale = layer.contentsScale
        drawTask?.action = {
            node._draw(size: size, opaque: opaque, scale: scale)
        }
    }
    
    func didDisplay() {
        guard let drawTask = drawTask, drawTask.state == .finshed, let node = drawTask.obj as? EasyNode else {
            return
        }
        content = node.content
        layer.contents = content?.cgImage
    }
    
    func draw(context: CGContext, size: CGSize) {
        
    }
}

extension EasyNode: CALayerDelegate {
    func display(_ layer: CALayer) {
        layer.contents = content?.cgImage
        setNeedsDisplay()
    }
}

extension EasyNode: EasyCopy {
    typealias T = EasyNode
    func easyCopy() -> EasyNode {
        let node: EasyNode = .init(frame: frame)
        node.superNode = superNode
        node.subnodes = .init(subnodes)
        node.backgroundColor = backgroundColor
        node.layout = layout.easyCopy()
        node.content = content
        return node
    }
}

extension EasyNode {
    func _draw(size: CGSize, opaque: Bool, scale: CGFloat) {
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        guard let context: CGContext = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor((backgroundColor ?? .clear).cgColor)
        context.addRect(.init(x: 0, y: 0, width: size.width * scale, height: size.height * scale))
        context.fillPath()
        draw(context: context, size: size)
        content = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}

extension EasyNode {
    func addSubNode(_ subNode: EasyNode) {
        subnodes.append(subNode)
        view.addSubview(subNode.view)
        subNode.superNode = self
        setNeedsLayout()
    }
    
    func insetSubNode(_ subNode: EasyNode, index: Int) {
        guard index >= 0, index <= subnodes.count else {
            return
        }
        subnodes.insert(subNode, at: index)
        view.insertSubview(subNode.view, at: index)
        subNode.superNode = self
        setNeedsLayout()
    }
    
    func removeFromSupperNode() {
        guard let superNode = superNode, let index = superNode.subnodes.firstIndex(of: self) else {
            return
        }
        superNode.subnodes.remove(at: index)
        view.removeFromSuperview()
        self.superNode = nil
        superNode.setNeedsLayout()
    }
}
