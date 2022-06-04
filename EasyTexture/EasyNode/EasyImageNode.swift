//
//  EasyImageNode.swift
//  EasyTexture
//
//  Created by xuan on 2022/6/4.
//

import Foundation
import UIKit

class EasyImageNode: EasyNode {
    var image: UIImage?
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let image = image else {
            return .zero
        }
        let rate = image.size.width / image.size.height
        let width = rate * size.height
        if width <= size.width {
            return .init(width: width, height: size.height)
        } else {
            return .init(width: size.width, height: size.width / rate)
        }
    }
    
    override func draw(context: CGContext, size: CGSize) {
        guard let image = image else {
            return
        }
        context.saveGState()
        switch image.imageOrientation {
        case .right:
            context.rotate(by: .pi / 2)
            context.translateBy(x: 0, y: -size.width)
        case .left:
            context.rotate(by: -.pi / 2)
            context.translateBy(x: -size.height, y: 0)
            context.scaleBy(x: 1, y: -1)
            context.translateBy(x: 0, y: -size.width)
        case .down:
            context.scaleBy(x: -1, y: 1)
            context.translateBy(x: -size.width, y: 0)
        case .up, .upMirrored, .downMirrored, .leftMirrored, .rightMirrored:
            break
        @unknown default:
            break
        }
        image.draw(in: .init(origin: .zero, size: size))
        context.restoreGState()
    }
    
    override func copyPropToNode(_ node: EasyNode) {
        super.copyPropToNode(node)
        guard let node = node as? EasyImageNode else { return }
        node.image = image
    }
}
