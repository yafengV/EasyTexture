//
//  EasyControl.swift
//  EasyTexture
//
//  Created by xuan on 2022/6/5.
//

import UIKit

class EasyControl: UIControl {

    override class var layerClass: AnyClass {
        EasyLayer.self
    }
    
    override func setNeedsDisplay() {
        layer.setNeedsDisplay()
    }
    

}
