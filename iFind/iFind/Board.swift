//
//  Board.swift
//  iFind
//
//  Created by 赵一达 on 16/8/16.
//  Copyright © 2016年 赵一达. All rights reserved.
//

import Foundation
import UIKit

enum DrawingState {
    case Began, Moved, Ended
}

class Board: UIImageView {
    private var drawingState: DrawingState!
    var strokeColor:UIColor = UIColor.blackColor()
    
    var strokeWidth:CGFloat = 20
    var brush:BaseBrush?
    var undoer:NSUndoManager?
    var realImage:UIImage?
    var isBoardBeenDrawedOnce:Bool = false
    
    convenience init() {
        self.init(frame:CGRectZero)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        undoer?.beginUndoGrouping()
       
        if let brush = self.brush {
           
            brush.lastPoint = nil
            brush.beginPoint = touches.first?.locationInView(self)
            brush.endPoint = brush.beginPoint
            self.drawingState = .Began
            self.drawingImage()
            
        }
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let brush = self.brush {
           
            brush.endPoint = touches.first?.locationInView(self)
            self.drawingState = .Moved
            self.drawingImage()
          
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.drawingState = .Ended
        self.drawingImage()
        undoer?.endUndoGrouping()
        isBoardBeenDrawedOnce = true
    }
    func drawingImage() {
        
        if let brush = self.brush {
            // 0.
            let undoImage = self.realImage
            // 1.
            UIGraphicsBeginImageContext(self.bounds.size)
            // 2.
            let context = UIGraphicsGetCurrentContext()
            UIColor.clearColor().setFill()
            UIRectFill(self.bounds)
            CGContextSetLineCap(context, .Round)
            CGContextSetLineWidth(context, self.strokeWidth)
            CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor)
            // 3.
            if let realImage = self.realImage {
                realImage.drawInRect(self.bounds)
            }
            // 4.
            brush.strokeWidth = self.strokeWidth
            brush.drawInContext(context!);
            CGContextStrokePath(context)
            // 5.
            let previewImage = UIGraphicsGetImageFromCurrentImageContext()
            if self.drawingState == .Ended || brush.supportedContinuousDrawing() {
                self.realImage = previewImage
            }
            UIGraphicsEndImageContext()
            // 6.
            self.image = previewImage;
            brush.lastPoint = brush.endPoint
            if isBoardBeenDrawedOnce == true{
                undoer?.prepareWithInvocationTarget(self).undoImage(undoImage!, yImage:previewImage)
            }
            
        }
    }
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    func undoableDrawing(){
//        self.undoer?.prepareWithInvocationTarget(self).drawingImage()
//        self.undoer?.setActionName("Draw")
        self.drawingImage()
    }
    func undoImage(xImage:UIImage,yImage:UIImage){
        self.image = xImage
        self.realImage = xImage
        undoer?.prepareWithInvocationTarget(self).redoImage(yImage)
    }
    func redoImage(xImage:UIImage){
        self.image = xImage
        self.realImage = xImage

    }
}