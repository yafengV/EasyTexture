//
//  EasyView.swift
//  EasyTexture
//
//  Created by xuan on 2022/5/22.
//

import UIKit

class EasyView: UIView {

    weak var node: EasyNode?
    
    override class var layerClass: AnyClass {
        EasyLayer.self
    }
    
    override func setNeedsDisplay() {
        layer.setNeedsDisplay()
    }
    
    
}
