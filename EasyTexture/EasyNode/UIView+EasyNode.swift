//
//  UIView+EasyNode.swift
//  EasyTexture
//
//  Created by xuan on 2022/5/29.
//

import Foundation
import UIKit

extension UIView {
    func addSubNode(_ subNode: EasyNode) {
        addSubview(subNode.view)
        subNode.setNeedsLayout()
    }
    
    func insetSubNode(_ subNode: EasyNode, index: Int) {
        guard index >= 0, index <= subviews.count else {
            return
        }
        insertSubview(subNode.view, at: index)
        subNode.setNeedsLayout()
    }
}
