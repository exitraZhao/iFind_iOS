//
//  BaseToolView.swift
//  iFind
//
//  Created by 赵一达 on 16/8/20.
//  Copyright © 2016年 赵一达. All rights reserved.
//

import Foundation
import UIKit

class BaseToolView: UIButton {
    
    
    var isBeenTouchedFirst:Bool = false
    var isBeenTouchedSec:Bool = false
    var moveLittle:CGFloat = 27
    var moveLot:CGFloat = 200
    var originPointY:CGFloat?
    
    convenience init() {
        self.init(frame:CGRectZero)
        originPointY = frame.origin.y
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isBeenTouchedFirst == false {
            UIButton.animateWithDuration(0.15, animations: { () -> Void in
                self.frame.origin.y -= self.moveLittle
            })
            isBeenTouchedFirst = true
        } else{
            if isBeenTouchedSec == false {
                UIButton.animateWithDuration(0.2, animations: { () -> Void in
                    self.frame.origin.y -= self.moveLot
                })
                isBeenTouchedSec = true
            }
            else{
                    UIButton.animateWithDuration(0.15, animations: { () -> Void in
                        self.frame.origin.y = self.originPointY! - self.moveLittle
                    })
                isBeenTouchedSec = false
                isBeenTouchedFirst = true
            }
        }
        super.touchesBegan(touches, withEvent: event)
    }
    func moveToOriginPoint(){
        UIButton.animateWithDuration(0.15, animations: { () -> Void in
            self.frame.origin.y = self.originPointY!
        })
    }
    
}