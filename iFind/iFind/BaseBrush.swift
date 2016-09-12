//
//  BaseBrush.swift
//  iFind
//
//  Created by 赵一达 on 16/8/17.
//  Copyright © 2016年 赵一达. All rights reserved.
//

import Foundation
import CoreGraphics

protocol PaintBrush {
    func supportedContinuousDrawing() -> Bool
    func drawInContext(context: CGContextRef)
}
class BaseBrush : NSObject, PaintBrush {
    var beginPoint: CGPoint!
    var endPoint: CGPoint!
    var lastPoint: CGPoint?
    var strokeWidth: CGFloat!
    func supportedContinuousDrawing() -> Bool {
        return false
    }
    func drawInContext(context: CGContextRef) {
        assert(false, "must implements in subclass.")
    }
}
