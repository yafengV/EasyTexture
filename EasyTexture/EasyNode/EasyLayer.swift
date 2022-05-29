//
//  EasyLayer.swift
//  EasyTexture
//
//  Created by xuan on 2022/5/22.
//

import UIKit

class EasyLayer: CALayer {
    
    weak var node: EasyNode?
    
    override func display() {
        node?.display(self)
    }
    
}
