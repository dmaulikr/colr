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
    
    var gameStage = GameStage() {
        didSet {
            UpdateUI()
        }
    }

    
    var color: UIColor = UIColor.lightGrayColor() {
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
    
    
    
    
    
    
    
    //DataSource dependent
    func SetUpColorVector() {
        
        
        //append gameStage's color vector with appropriate
        //number of colors
        for var i = 0; i < gameStage.NumberOfBlocks; i++ {
            gameStage.ColorVector.append(UIColor.lightGrayColor())
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    var OnLock : [Bool] = [Bool]()
    
    //var PickUp : [Bool] = [Bool]()
    
    func SetUpOnLockVector() -> [Bool] {
        
        var OnLockVector = [Bool]()
        
        for var i = 0; i < gameStage.NumberOfBlocks; i++ {
            OnLockVector.append(false)
        }
        
        return OnLockVector
        
    }
    
    /*
    func SetUpPickUpVector() -> [Bool]{
        
        var PickUpVector = [Bool]()
        
        for var i = 0; i < NumberOfBlocks; i++ {
            PickUpVector.append(false)
        }
        
        return PickUpVector
        
    }
    */
    
    
    
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
        
        let numberOfBlocks = gameStage.NumberOfBlocks
        
        let blockSize = gameStage.BlockSize
        
        
        
       
        
        for var l = 0; l < numberOfBlocks; l++ {
            
            
            //If it is within bounds of ColumnOne
        //then color changes
            if (gameStage.WithinBoundsOf(XYPoints[l], AreaPoint: gameStage.ColumnOne, Area: CGPoint(x: 50, y: 300))) {
                
                gameStage.ColorVector[l] = UIColor.darkGrayColor()
                
                
            }
            //else
            //change color back to original color
            else {
                
                gameStage.ColorVector[l] = UIColor.lightGrayColor()
            }
            
            
            
        }
        
        //print(gameView.ColorVector)
        
        
        switch gesture.state {
            
            //when touch is let go
        case .Ended:
            
            for var i = 0; i < numberOfBlocks; i++ {
            
            OnLock[i] = false
                
                
            }
            
            
            
            //first touch
        case .Began:
            
            //how much it as changed in the gameView's
            //coordinate system
            let translation = gesture.translationInView(gameView)
            let Xdrag = translation.x
            let Ydrag = translation.y
            
            
            //print("BEGAN")
            
            
            
            
            
            //for each block
            for var i = 0; i < numberOfBlocks; i++ {
                
                
                //print(i)
                //if the touch is within the block
            if (gameStage.WithinBoundsOf(touchCoordinates, AreaPoint: XYPoints[i], Area: CGPoint(x: blockSize, y: blockSize))) {
                
                OnLock[i] = true
                
                //print("Changed \(OnLock)");
                
                XYPoints[i].x += Xdrag
                XYPoints[i].y += Ydrag
                
                
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
            
            
            
            
            //print("CHANGED \(OnLock)")
            
            
            
            //for each block
            for var i = 0; i < numberOfBlocks; i++ {
                
                
                
            //if a block is already locked on (has a finger on it)
            
            
            if (OnLock[i] == true)
            {
                
                let translation = gesture.translationInView(gameView)
                let Xdrag = translation.x
                let Ydrag = translation.y
                XYPoints[i].x += Xdrag
                XYPoints[i].y += Ydrag
                
                
                //makes it incremental
                gesture.setTranslation(CGPointZero, inView: gameView)
            
            
            }
                
                /*
                
                //if the "dragging" touch is within the block
            else if (XYPoints[i].x < touchCoordinates.x && touchCoordinates.x < XYPoints[i].x + gameView.blockSize && XYPoints[i].y < touchCoordinates.y && touchCoordinates.y < XYPoints[i].y + gameView.blockSize) {
                
                
                
                    let translation = gesture.translationInView(gameView)
                    let Xdrag = translation.x
                    let Ydrag = translation.y
                    XYPoints[i].x += Xdrag
                    XYPoints[i].y += Ydrag
                
                
                    OnLock[i] = true
                    
                    //makes it incremental
                    gesture.setTranslation(CGPointZero, inView: gameView)
                    
                
                }


            */
            
                
                
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
    
    
    
    
    //called when views are loaded?
    //only called once
    
    override func viewDidLoad() {
        
        //always call super in a lifecycle method
        super.viewDidLoad()
        
        //sets up vector of bools checking for validity of being selected
        OnLock = SetUpOnLockVector()
        //PickUp = SetUpPickUpVector()
        
        gameView.SetUpNumberOfBlocks()
        
        
        //sets up the color vector in gameView with appropriate number
        //of colors
        SetUpColorVector()
        
        
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
    
    
    
    
    //GameViewDataSource Functions
    
    
    func XYForGameView(sender: GameView) -> [CGPoint]? {
        
        
        return XYPoints
        
    }
    
    func NumberOfBlocksForGameView(sender: GameView) -> Int? {
        
        return gameStage.NumberOfBlocks
    }
    
    func BlockSpacingForGameView(sender: GameView) -> Int? {
        
        return gameStage.BlockSpacing
        
    }
    
        
    func BlockSizeForGameView(sender: GameView) -> CGFloat? {
        
        return gameStage.BlockSize
        
    }
    
    
    func ColorVectorForGameView(sender: GameView) -> [UIColor]? {
        
        return gameStage.ColorVector
        
    }

}
