//
//  EasyView.swift
//  EasyTexture
//
//  Created by xuan on 2022/5/22.
//

import UIKit

class EasyView: UIView {
    
    override class var layerClass: AnyClass {
        EasyLayer.self
    }
    
    override func setNeedsDisplay() {
        layer.setNeedsDisplay()
    }
    
    
}
