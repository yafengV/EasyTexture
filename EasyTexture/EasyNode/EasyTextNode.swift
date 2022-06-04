//
//  EasyTextNode.swift
//  EasyTexture
//
//  Created by xuan on 2022/5/28.
//

import UIKit

class EasyTextNode: EasyNode {
    
    var textLayout: EasyTextLayout?
    var text: NSAttributedString? {
        didSet {
            guard text != oldValue else {
                return
            }
            if let text = text {
                let container: EasyTextContainer = .init()
                container.size = frame.size
                textLayout = .layoutWithContainer(container, text: text)
            } else {
                textLayout = nil
            }
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        textLayout?.sizeThatFit(size) ?? .zero
    }
    
    override func draw(context: CGContext, size: CGSize) {
        textLayout?.drawInContext(context)
    }
    
    override func copyPropToNode(_ node: EasyNode) {
        super.copyPropToNode(node)
        guard let node = node as? EasyTextNode else { return }
        node.text = text
    }
    
}
