//
//  RunLoopObserver.swift
//  EasyTexture
//
//  Created by xuan on 2022/5/22.
//

import UIKit

class RunLoopObserver {
    static let defaultObserver = RunLoopObserver()
    
    var operations: [RunLoopOperation] = []
    
    lazy var observer: CFRunLoopObserver = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.beforeWaiting.rawValue, true, 0) { [weak self] observer, activity in
        for operation in self?.operations ?? [] {
            operation.run()
        }
        self?.operations.removeAll()
    }
    
    func commitOperation(_ operation: RunLoopOperation) {
        operations.append(operation)
    }
    
    init() {
        CFRunLoopAddObserver(CFRunLoopGetMain(), observer, .commonModes)
    }
    
    deinit {
        CFRunLoopRemoveObserver(CFRunLoopGetMain(), observer, .commonModes)
    }
}
