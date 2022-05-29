//
//  EasyProtocol.swift
//  EasyTexture
//
//  Created by xuan on 2022/5/29.
//

import Foundation

protocol EasyCopy {
    associatedtype T
    func easyCopy() -> T
}
