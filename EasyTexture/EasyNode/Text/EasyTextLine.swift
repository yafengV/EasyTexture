//
//  EasyTextLine.swift
//  EasyTexture
//
//  Created by xuan on 2022/5/28.
//

import UIKit

class EasyTextLine: NSObject {
    var position: CGPoint = .zero
    
    var ascent: CGFloat = 0
    var descent: CGFloat = 0
    var leading: CGFloat = 0
    
    var lineWidth: CGFloat = 0
    
    var range: NSRange = .init(location: 0, length: 0)
    
    var firstGlyphPos: CGFloat = 0
    
    var trailingWhitespaceWidth: CGFloat = 0
    
    var bounds: CGRect = .zero
    
    var row: Int = 0
    
    var ctLine: CTLine? {
        didSet {
            guard ctLine != oldValue else {
                return
            }
            if let ctLine = ctLine {
                lineWidth = CTLineGetTypographicBounds(ctLine, &ascent, &descent, &leading)
                let range = CTLineGetStringRange(ctLine)
                self.range = .init(location: range.location, length: range.length)
                if CTLineGetGlyphCount(ctLine) > 0 {
                    let runs = CTLineGetGlyphRuns(ctLine)
                    let run = CFArrayGetValueAtIndex(runs, 0).load(as: CTRun.self)
                    var pos: CGPoint = .zero
                    CTRunGetPositions(run, .init(location: 0, length: 1), &pos)
                    firstGlyphPos = pos.x
                } else {
                    firstGlyphPos = 0
                }
                trailingWhitespaceWidth = CTLineGetTrailingWhitespaceWidth(ctLine)
            } else {
                lineWidth = 0
                ascent = 0
                descent = 0
                leading = 0
                firstGlyphPos = 0
                trailingWhitespaceWidth = 0
                range = .init(location: 0, length: 0)
            }
            
            bounds = .init(x: position.x + firstGlyphPos, y: position.y - ascent, width: lineWidth, height: ascent + descent)
            
        }
    }
    
    static func lineWithCTLine(_ ctLine: CTLine, position: CGPoint) -> EasyTextLine {
        let line: EasyTextLine = .init()
        line.ctLine = ctLine
        line.position = position
        return line
    }
}
