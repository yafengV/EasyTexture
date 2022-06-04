//
//  EasyLayout.swift
//  EasyTexture
//
//  Created by xuan on 2022/5/22.
//

import UIKit
import yoga

class EasyLayout {
    
    static let globalConfig = YGConfigNew()
    
    static func setup() {
        YGConfigSetExperimentalFeatureEnabled(globalConfig, .webFlexBasis, true)
        YGConfigSetPointScaleFactor(globalConfig, Float(UIScreen.main.scale))
    }
    
    static let YGMeasureNode: YGMeasureFunc = { ref, width, widthMode, height, heightMode in
        let constrainedWidth = widthMode == YGMeasureMode.undefined ? Float.greatestFiniteMagnitude : width
        let constrainedHeight = heightMode == YGMeasureMode.undefined ? Float.greatestFiniteMagnitude : height
        guard let node = YGNodeGetContext(ref)?.load(as: EasyNode.self) else {
            return YGSize.init(width: 0, height: 0)
        }
        let sizeThatFits = node.sizeThatFits(.init(width: CGFloat(constrainedWidth), height: CGFloat(constrainedHeight)))
        return YGSize.init(width: YGSanitizeMeasurement(constrainedWidth, Float(sizeThatFits.width), widthMode), height: YGSanitizeMeasurement(constrainedHeight, Float(sizeThatFits.height), heightMode))
        
    }
    
    static let YGSanitizeMeasurement: (Float, Float, YGMeasureMode) -> Float = { constrainedSize, measuredSize, measureMode in
        if measureMode == YGMeasureMode.exactly {
            return constrainedSize
        }
        if measureMode == YGMeasureMode.atMost {
            return min(constrainedSize, measuredSize)
        }
        return measuredSize
    }
    
    var direction: YGDirection {
        set {
            YGNodeStyleSetDirection(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetDirection(ygRef)
        }
    }
    
    var flexDirection: YGFlexDirection {
        set {
            YGNodeStyleSetFlexDirection(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetFlexDirection(ygRef)
        }
    }
    
    var justifyContent: YGJustify {
        set {
            YGNodeStyleSetJustifyContent(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetJustifyContent(ygRef)
        }
    }
    
    var alignContent: YGAlign {
        set {
            YGNodeStyleSetAlignContent(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetAlignContent(ygRef)
        }
        
    }
    var alignItems: YGAlign {
        set {
            YGNodeStyleSetAlignItems(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetAlignItems(ygRef)
        }
    }
    var alignSelf: YGAlign {
        set {
            YGNodeStyleSetAlignSelf(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetAlignSelf(ygRef)
        }
    }
    var position: YGPositionType {
        set {
            YGNodeStyleSetPositionType(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetPositionType(ygRef)
        }
    }
    var flexWrap: YGWrap {
        set {
            YGNodeStyleSetFlexWrap(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetFlexWrap(ygRef)
        }
    }
    
    var flex: Float {
        set {
            YGNodeStyleSetFlex(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetFlex(ygRef)
        }
    }
    var flexGrow: Float {
        set {
            YGNodeStyleSetFlexGrow(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetFlexGrow(ygRef)
        }
    }
    var flexShrink: Float {
        set {
            YGNodeStyleSetFlexShrink(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetFlexShrink(ygRef)
        }
        
    }
    var flexBasis: Float {
        set {
            YGNodeStyleSetFlexBasis(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetFlexBasis(ygRef).value
        }
    }
    
    var left: Float {
        set {
            YGNodeStyleSetPosition(ygRef, .left, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetPosition(ygRef, .left).value
        }
    }
    
    var top: Float {
        set {
            YGNodeStyleSetPosition(ygRef, .top, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetPosition(ygRef, .top).value
        }
    }
    var right: Float {
        set {
            YGNodeStyleSetPosition(ygRef, .right, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetPosition(ygRef, .right).value
        }
    }
    var bottom: Float {
        set {
            YGNodeStyleSetPosition(ygRef, .bottom, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetPosition(ygRef, .bottom).value
        }
    }
    
    var marginLeft: Float {
        set {
            YGNodeStyleSetMargin(ygRef, .left, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetMargin(ygRef, .left).value
        }
    }
    var marginTop: Float {
        set {
            YGNodeStyleSetMargin(ygRef, .top, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetMargin(ygRef, .top).value
        }
    }
    
    var marginRight: Float {
        set {
            YGNodeStyleSetMargin(ygRef, .right, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetMargin(ygRef, .right).value
        }
    }
    
    var marginBottom: Float {
        set {
            YGNodeStyleSetMargin(ygRef, .bottom, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetMargin(ygRef, .bottom).value
        }
    }
    
    var paddingLeft: Float {
        set {
            YGNodeStyleSetPadding(ygRef, .left, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetPadding(ygRef, .left).value
        }
    }
    
    var paddingTop: Float {
        set {
            YGNodeStyleSetPadding(ygRef, .top, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetPadding(ygRef, .top).value
        }
    }
    var paddingRight: Float {
        set {
            YGNodeStyleSetPadding(ygRef, .right, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetPadding(ygRef, .right).value
        }
    }
    
    var paddingBottom: Float {
        set {
            YGNodeStyleSetPadding(ygRef, .bottom, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetPadding(ygRef, .bottom).value
        }
    }
    
    var width: Float {
        set {
            YGNodeStyleSetWidth(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetWidth(ygRef).value
        }
    }
    
    var height: Float {
        set {
            YGNodeStyleSetHeight(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetHeight(ygRef).value
        }
    }
    var minWidth: Float {
        set {
            YGNodeStyleSetMinWidth(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetMinWidth(ygRef).value
        }
    }
    var minHeight: Float {
        set {
            YGNodeStyleSetMinHeight(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetMinHeight(ygRef).value
        }
    }
    var maxWidth: Float {
        set {
            YGNodeStyleSetMaxWidth(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetMaxWidth(ygRef).value
        }
    }
    var maxHeight: Float {
        set {
            YGNodeStyleSetMaxHeight(ygRef, newValue)
            node.setNeedsLayout()
        }
        get {
            YGNodeStyleGetMaxHeight(ygRef).value
        }
    }
    
    let ygRef: YGNodeRef
    var node: EasyNode
    var subLayouts: [EasyLayout] = []
    
    init(node: EasyNode) {
        self.node = node
        ygRef = YGNodeNewWithConfig(Self.globalConfig)
        YGNodeSetContext(ygRef, &self.node)
    }
    
    deinit {
        YGNodeFree(ygRef)
    }
    
    var isDirty:Bool {
        YGNodeIsDirty(ygRef)
    }
    
    var isLeaf: Bool {
        node.subnodes.isEmpty
    }
    
    func markDirty() {
        guard !isDirty, isLeaf else {
            return
        }
        if !YGNodeHasMeasureFunc(ygRef) {
            YGNodeSetMeasureFunc(ygRef, Self.YGMeasureNode)
        }
        
        YGNodeMarkDirty(ygRef)
    }
    
    /// 刷新同步node和yoga布局
    func reset() {
        subLayouts.removeAll()
        YGNodeRemoveAllChildren(ygRef)
        if isLeaf {
            YGNodeSetMeasureFunc(ygRef, Self.YGMeasureNode)
        } else {
            YGNodeSetMeasureFunc(ygRef, nil)
            for (index, subnode) in node.subnodes.enumerated() {
                let layout = subnode.layout.easyCopy()
                subLayouts.append(layout)
                YGNodeInsertChild(ygRef, layout.ygRef, UInt32(index))
            }
        }
        
        for layout in subLayouts {
            layout.reset()
        }
    }
    
    /// 计算大小
    /// - Parameter size: 目标size
    /// - Returns: 适配size
    func sizeThatFit(_ size: CGSize) -> CGSize {
        YGNodeCalculateLayout(ygRef, Float(size.width), Float(size.height), direction)
        return CGSize(width: CGFloat(YGNodeLayoutGetWidth(ygRef)), height: CGFloat(YGNodeLayoutGetHeight(ygRef)))
    }
    
    func attachFrameToNode() {
        node.frame = .init(x: CGFloat(YGNodeLayoutGetLeft(ygRef)), y: CGFloat(YGNodeLayoutGetTop(ygRef)), width: CGFloat(YGNodeLayoutGetWidth(ygRef)), height: CGFloat(YGNodeLayoutGetHeight(ygRef)))
        for layout in subLayouts {
            layout.attachFrameToNode()
        }
    }
    
    var task: EasyTask?
    
    func willLayout() {
        task?.cancel()
        let layout = self.easyCopy()
        let size = layout.node.frame.size
        layout.reset()
        task = .init()
        task?.obj = layout
        task?.action = {
            _ = layout.sizeThatFit(size)
        }
    }
    
    func layout() {
        task?.run()
    }
    
    func didLayout() {
        guard let task = task, task.state == .finshed, let layout = task.obj as? EasyLayout else {
            return
        }
        layout.attachFrameToNode()
        node.layoutChanged()
    }
}

extension EasyLayout: EasyCopy {
    typealias T = EasyLayout
    func easyCopy() -> EasyLayout {
        let layout: EasyLayout = .init(node: node)
        YGNodeCopyStyle(layout.ygRef, ygRef)
        return layout
    }
}
