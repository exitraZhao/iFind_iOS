//
//  PencilBrush.swift
//  iFind
//
//  Created by 赵一达 on 16/8/19.
//  Copyright © 2016年 赵一达. All rights reserved.
//

import Foundation
import CoreGraphics

class PencilBrush: BaseBrush {
    override func drawInContext(context: CGContextRef) {
        if let lastPoint = self.lastPoint {
            CGContextMoveToPoint(context, lastPoint.x, lastPoint.y)
            CGContextAddLineToPoint(context, endPoint.x, endPoint.y)
        } else {
            CGContextMoveToPoint(context, beginPoint.x, beginPoint.y)
            CGContextAddLineToPoint(context, endPoint.x, endPoint.y)
        }
    }
    override func supportedContinuousDrawing() -> Bool {
        return true
    }
}
class EraserBrush: PencilBrush {
    
    
    override func drawInContext(context: CGContextRef) {
        CGContextSetBlendMode(context, .Clear);
        super.drawInContext(context)
    }
}