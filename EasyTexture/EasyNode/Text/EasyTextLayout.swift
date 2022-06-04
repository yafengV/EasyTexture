//
//  EasyTextLayout.swift
//  EasyTexture
//
//  Created by xuan on 2022/5/28.
//

import UIKit

class EasyTextLayout: NSObject {
    
    var text: NSAttributedString?
    var container: EasyTextContainer?
    
    var frame: CGRect = .zero
    var lines: [EasyTextLine] = []
    var setter: CTFramesetter?
    
    static func layoutWithContainer(_ container: EasyTextContainer, text: NSAttributedString) -> EasyTextLayout {
        let layout: EasyTextLayout = .init()
        layout.text = text
        layout.container = container
        
        if container.size == .zero {
            return layout
        }
        _ = layout.sizeThatFit(container.size)
        return layout
    }
    
    func sizeThatFit(_ size: CGSize) -> CGSize {
        guard let container = container, let text = text else {
            return .zero
        }
        container.size = size
        let originRect: CGRect = .init(origin: .zero, size: container.size)
        let rect = originRect.applying(.init(scaleX: 1, y: -1))
        let path: CGPath = .init(rect: rect, transform: nil)
        
        let ctSetter: CTFramesetter = CTFramesetterCreateWithAttributedString(text)
        let ctFrame: CTFrame = CTFramesetterCreateFrame(ctSetter, .init(location: 0, length: text.length), path, nil)
        
        let ctLines = CTFrameGetLines(ctFrame) as! [CTLine]
        let lineCount = ctLines.count
        
        let ctLineorigins = UnsafeMutablePointer<CGPoint>.allocate(capacity: lineCount)
        CTFrameGetLineOrigins(ctFrame, .init(location: 0, length: lineCount), ctLineorigins)
        
        var textRect: CGRect = .zero
        
        var lines: [EasyTextLine] = []
        for i in 0..<lineCount {
            let ctLine = ctLines[i]
            let ctRuns = CTLineGetGlyphRuns(ctLine) as! [CTRun]
            guard !ctRuns.isEmpty else { continue }
            let ctLineOrigin = ctLineorigins[i]
            let position: CGPoint = .init(x: originRect.origin.x + ctLineOrigin.x, y: originRect.height + originRect.origin.y - ctLineOrigin.y)
            
            let line: EasyTextLine = .lineWithCTLine(ctLine, position: position)
            line.row = i
            lines.append(line)
            
            if container.numberOfLines == 0 || container.numberOfLines > i {
                textRect = textRect.union(line.bounds)
            } else {
                break
            }
        }
        
        self.frame = textRect
        self.lines = lines
        self.setter = ctSetter
        return textRect.size
    }
    
    func drawInContext(_ context: CGContext) {
        let origin = frame.origin
        let size = frame.size
        context.saveGState()
        context.translateBy(x: origin.x, y: origin.y)
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1, y: -1)
        
        for line in lines {
            let posX = line.position.x
            let posY = size.height - line.position.y
            guard let ctLine = line.ctLine else { continue }
            let runs = CTLineGetGlyphRuns(ctLine) as! [CTRun]
            let count = runs.count
            for i in 0..<count {
                let run = runs[i]
                context.textMatrix = .identity
                context.textPosition = .init(x: posX, y: posY)
                drawRun(run, context: context)
            }
        }
        context.restoreGState()
    }
    
    func drawRun(_ run: CTRun, context: CGContext) {
        let runTextMatrix = CTRunGetTextMatrix(run)
        if !runTextMatrix.isIdentity {
            context.saveGState()
            context.textMatrix = runTextMatrix
        }
        CTRunDraw(run, context, .init(location: 0, length: 0))
        if !runTextMatrix.isIdentity {
            context.restoreGState()
        }
    }
    
}
