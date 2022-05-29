//
//  Task.swift
//  EasyTexture
//
//  Created by xuan on 2022/5/28.
//

import UIKit

class EasyTask: NSObject {
    
    var obj: Any?
    
    var action: (() -> Void)?
    
    enum State {
        case waiting, runing, finshed, canceled
    }
    
    var state: State = .waiting
    
    func cancel() {
        state = .canceled
    }
    
    func run() {
        if state != .waiting {
            return
        }
        state = .runing
        action?()
        if state == .runing {
            state = .finshed
        }
    }

}
