//
//  RoodViewController.swift
//  Rood
//
//  Created by Jose Canizares on 10/25/15.
//  Copyright © 2015 rustic_republic. All rights reserved.
//

import UIKit


class RoodViewController: UIViewController, GameViewDataSource {
    
    

    @IBOutlet weak var gameView: GameView! {
        didSet {
            gameView.XYDataSource = self
            
            //gameView.addGestureRecognizer(UIPanGestureRecognizer(target: gameView, action: "translate:"))
            
        }
        
        
    }

    
    var color: UIColor = UIColor.lightGrayColor() {
        didSet {
            
            UpdateUI()
        }
    }
    
    //X of block being dragged
    var xpos: CGFloat = 100 {
        didSet {
            UpdateUI()
        }
    }
    
    
    
    //Y of block being dragged
    var ypos: CGFloat  = 100 {
        didSet {
            UpdateUI()
        }
    }
    
    
    var touchCoordinates : CGPoint = CGPoint(x: 0, y: 0)

    
    private struct Constants {
        static let GestureScale: CGFloat = 1
    }
    
    
    //if touch is within block validation
    //so that while holding after touching within the block
    //the dragging is valid, even if the finger location is 
    //outside the block sometimes
    var valid : Bool = false
    
    @IBAction func dragBlock(gesture: UIPanGestureRecognizer) {
        
        
        
        switch gesture.state {
        case .Ended:
            valid = false
            
        case .Began:
            
            //how much it as changed in the gameView's
            //coordinate system
            let translation = gesture.translationInView(gameView)
            let Xdrag = translation.x
            let Ydrag = translation.y
            
            /*gameView.XPosition < xpos && xpos < gameView.XPosition + gameView.blockSize && gameView.YPosition < ypos && ypos < gameView.YPosition + gameView.blockSize*/
            
            //if the touch is within the block
            if (gameView.XPosition < touchCoordinates.x && touchCoordinates.x < gameView.XPosition + gameView.blockSize && gameView.YPosition < touchCoordinates.y && touchCoordinates.y < gameView.YPosition + gameView.blockSize) {
                valid = true
                
                xpos += Xdrag
                ypos += Ydrag
                //print(xpos)
                //print(ypos)
                //print(gameView.XPosition)
                //print(gameView.YPosition)
                
                
                //makes it incremental
                gesture.setTranslation(CGPointZero, inView: gameView)
                
            }
            
            break
            
        case .Changed:
            
            
            if (valid == true)
            {
            let translation = gesture.translationInView(gameView)
            let Xdrag = translation.x
            let Ydrag = translation.y
            xpos += Xdrag
            ypos += Ydrag
            
            
            //makes it incremental
            gesture.setTranslation(CGPointZero, inView: gameView)
            
            
            }
            
            
            
        default: break
        }
    }
    
    
    
    //detects finger touch location
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            touchCoordinates = touch.locationInView(gameView)
            //print(touchCoordinates)
        }
    }
    
    
    
    
    
    

    
    struct PathNames {
        static let Block1 = "Block1"
        static let Block2 = "Block2"
        static let Block3 = "Block3"
    }
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    
        
    }
    
    func UpdateUI() {
        
        gameView?.setNeedsDisplay()
        //optional since when segue is preparing, outlets are not set!
    }
    
    
    
    
    func XYForGameView(sender: GameView) -> CGPoint? {
        let XYPoint = CGPoint(x: xpos, y: ypos)
        return XYPoint
    }
        
    
    
        
    

}
