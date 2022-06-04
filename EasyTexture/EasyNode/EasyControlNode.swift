//
//  EasyControlNode.swift
//  EasyTexture
//
//  Created by xuan on 2022/6/5.
//

import UIKit

class EasyControlNode: EasyNode {
    
    var control: UIControl? {
        guard let control = view as? UIControl else { return nil }
        return control
    }
    
    override var viewClass: UIView.Type {
        EasyControl.self
    }
}
