//
//  ViewController.swift
//  iFind
//
//  Created by 赵一达 on 16/8/15.
//  Copyright © 2016年 赵一达. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func redo(sender: AnyObject) {
        self.undoer.redo()
    }
    @IBAction func undo(sender: AnyObject) {
        self.undoer.undo()
        print("hhh")
    }
    
    
    @IBOutlet weak var pencil: BaseToolView!
    @IBOutlet weak var eraser: BaseToolView!
    
    
    var brushes = [PencilBrush()]
    var erasers = [EraserBrush()]
    var undoer = NSUndoManager()

    
    @IBOutlet weak var board: Board!
    @IBAction func pencilTouched(sender: AnyObject) {
        self.board.brush = brushes[0]
        resetToolToOrigin(eraser)
    }
    @IBAction func eraserTouched(sender: AnyObject) {
        self.board.brush = erasers[0]
        resetToolToOrigin(pencil)
    }
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.layoutIfNeeded()
        print(pencil.frame.origin.y)
        self.board.brush = brushes[0]
        pencil.originPointY = pencil.frame.origin.y
        eraser.originPointY = eraser.frame.origin.y
        
        board.undoer = undoer
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetToolToOrigin(tool:BaseToolView){
        print("//")
        tool.isBeenTouchedFirst = false
        tool.moveToOriginPoint()
    }


}

