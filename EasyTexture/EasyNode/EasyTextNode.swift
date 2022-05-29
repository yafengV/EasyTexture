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
                textLayout = .layoutWithContainer(.init(), text: text)
            } else {
                textLayout = nil
            }
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        textLayout?.frame.size ?? .zero
    }
    
    override func draw(context: CGContext, size: CGSize) {
        textLayout?.drawInContext(context)
    }
    
}
