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
            gameView.DataSource = self
            
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
    
    //store last touch coordinates
    var touchCoordinates : CGPoint = CGPoint(x: 0, y: 0)

    
    
    var BlockSpacing : Int = 75 {
        didSet {
            UpdateUI()
        }
    }
    
    //doesn't matter what start value is because of calls in viewDidLoad
    var XYPoints : [CGPoint] = [CGPoint]() {
        didSet {
            UpdateUI()
        }
    }
    
    
    var NumberOfBlocks : Int = 7 {
        didSet {
            UpdateUI()
        }
    }
    
    
    var valid : [Bool] = [Bool]()
    
    func SetUpValidVector() -> [Bool]{
        
        var validVector = [Bool]()
        
        for var i = 0; i < NumberOfBlocks; i++ {
            validVector.append(false)
        }
        
        return validVector
        
    }
    
    
    /*
    private struct Constants {
        static let GestureScale: CGFloat = 1
    }
    */
    
    //if touch is within block validation
    //so that while holding after touching within the block
    //the dragging is valid, even if the finger location is
    //outside the block sometimes
    
    
    
    
    

    
    @IBAction func dragBlock(gesture: UIPanGestureRecognizer) {
        
        
        
        switch gesture.state {
            
            //when touch is let go
        case .Ended:
            
            for var i = 0; i < NumberOfBlocks; i++ {
            
            valid[i] = false
                
            }
            
            //first touch
        case .Began:
            
            //how much it as changed in the gameView's
            //coordinate system
            let translation = gesture.translationInView(gameView)
            let Xdrag = translation.x
            let Ydrag = translation.y
            
            /*gameView.XPosition < xpos && xpos < gameView.XPosition + gameView.blockSize && gameView.YPosition < ypos && ypos < gameView.YPosition + gameView.blockSize*/
            print("BEGAN")
            
            
            
            
            
            //for each block
            for var i = 0; i < NumberOfBlocks; i++ {
                
                
                print(i)
                //if the touch is within the block
            if (XYPoints[i].x < touchCoordinates.x && touchCoordinates.x < XYPoints[i].x + gameView.blockSize && XYPoints[i].y < touchCoordinates.y && touchCoordinates.y < XYPoints[i].y + gameView.blockSize) {
                
                valid[i] = true
                
                XYPoints[i].x += Xdrag
                XYPoints[i].y += Ydrag
                
                //print(xpos)
                //print(ypos)
                //print(gameView.XPosition)
                //print(gameView.YPosition)
                
                //print(gameView.Paths.count)
                
                //makes it incremental
                gesture.setTranslation(CGPointZero, inView: gameView)
                
                
                
            }
            
            
            
            
                
            }
            
            break
            
            //while being dragged
        case .Changed:
            
            print("CHANGED \(valid)")
            //for each block
            for var i = 0; i < NumberOfBlocks; i++ {
            
            if (valid[i] == true)
            {
                
                let translation = gesture.translationInView(gameView)
                let Xdrag = translation.x
                let Ydrag = translation.y
                XYPoints[i].x += Xdrag
                XYPoints[i].y += Ydrag
                
                
                //makes it incremental
                gesture.setTranslation(CGPointZero, inView: gameView)
            
            
            }
            
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
    
    
    
    
    
    

    /*
    struct PathNames {
        static let Block1 = "Block1"
        static let Block2 = "Block2"
        static let Block3 = "Block3"
    }
    
    */
    
    
    
    
    
    
    override func viewDidLoad() {
        
        //always call super in a lifecycle method
        super.viewDidLoad()
        
        //sets up vector of bools checking for validity of being selected
        valid = SetUpValidVector()
        
        gameView.SetUpNumberOfBlocks()
        
        
        //starts the xy arrays in gameView and in RoodViewController
        //with number of spots according to number of blocks
        gameView.BlockPoints = gameView.SetUpBlockPoints()
        XYPoints = gameView.SetUpBlockPoints()
        
        
        

    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    
        
    }
    
    func UpdateUI() {
        
        gameView?.setNeedsDisplay()
        //optional since when segue is preparing, outlets are not set!
    }
    
    
    
    
    func XYForGameView(sender: GameView) -> [CGPoint]? {
        
        
        return XYPoints
        
    }
    
    func NumberOfBlocksForGameView(sender: GameView) -> Int? {
        
        return NumberOfBlocks
    }
    
    
        
    

}
