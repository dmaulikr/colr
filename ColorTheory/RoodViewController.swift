//
//  RoodViewController.swift
//  Rood
//
//  Created by Jose Canizares on 10/25/15.
//  Copyright © 2015 rustic_republic. All rights reserved.
//

import UIKit
//No import needed to import Library.swift functions


//The controller for ColorTheory.

class RoodViewController: UIViewController, GameViewDataSource {
    
    
    //The instance of a game view. The "window" for our levels.
    
    @IBOutlet weak var gameView: GameView! {
        didSet {
            gameView.DataSource = self
            
            //gameView.addGestureRecognizer(UIPanGestureRecognizer(target: gameView, action: "translate:"))
            
        }
        
        
    }
    
    
    //The Model for the game. The GameStage struct holds all data related to the current stage on display. 
    
    var gameStage = GameStage() {
        didSet {
            UpdateUI()
        }
    }
    
    
    //Here is the storage for the touch coordinate last made on the screen.
    
    var touchCoordinates : CGPoint = CGPoint(x: 0, y: 0)

    
    //Storage for XYPoints. For now, it stays here, in the Controller.
    //doesn't matter what start value is because of calls in viewDidLoad
    var XYPoints : [CGPoint] = [CGPoint]() {
        didSet {
            UpdateUI()
        }
    }
    
    
    
    
    let BlockColor = UIColor(red: 0.38, green: 0.36, blue: 0.39, alpha: 1)
    
    
    
    
    //Set-up function for initiating gameStage's colorVector with appropriate number of colors.
    //DataSource dependent
    func SetUpColorVector() {
        
        
        //append gameStage's color vector with appropriate
        //number of colors
        for var i = 0; i < gameStage.NumberOfBlocks; i++ {
            
            if (i == 0) {
                gameStage.ColorVector.append(UIColor(red: 0.45, green: 0.30, blue: 0.34, alpha: 1))
            }
            
            else if (i == 1) {
                gameStage.ColorVector.append(UIColor(red: 0.57, green: 0.43, blue: 0.46, alpha: 1))
            }
            else {
                gameStage.ColorVector.append(BlockColor)
            }
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    //Bool Vector that keeps track of which block is "locked on"
    //the block being touched on
    
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
    
    
    
    
    

    //called everytime something is dragged
    @IBAction func dragBlock(gesture: UIPanGestureRecognizer) {
        
        let numberOfBlocks = gameStage.NumberOfBlocks
        
        let blockSize = gameStage.BlockSize
        
        
        
        
       
        
       
        
        
        
        
        
        //print(gameView.ColorVector)
        
        
        
        //switch statement for cases: .Ended, .Began, and .Changed
        switch gesture.state {
            
            //.Ended
            //case for when touch leaves the screen
        case .Ended:
            
            for var i = 0; i < numberOfBlocks; i++ {
            
            OnLock[i] = false
                
                
                
                
                
            }
            
            
            
            for var l = 0; l < numberOfBlocks; l++ {
                
                let BlockCenter = CGPoint(x: XYPoints[l].x + CGFloat(blockSize/2.0), y: XYPoints[l].y + CGFloat(blockSize/2.0))
                //If it is within bounds of ColumnOne
                //then color changes
                //bounds is larger than the actual ColumnOne
                if (WithinBoundsOf(BlockCenter, AreaPoint: CGPoint(x: gameStage.ColumnOne.x - 25, y: gameStage.ColumnOne.y - 25), Area: CGPoint(x: 100, y: 450))) {
                    
                    //
                    XYPoints[l] = CGPoint(x: gameStage.ColumnOne.x, y: XYPoints[l].y)
                    //
                    gameStage.ColumnOneColor = gameStage.ColorVector[l]
                    
                }
                    //else
                    //change color back to original color
                else {
                    
                    
                    if (l == 0) {
                        gameStage.ColorVector.append(UIColor(red: 0.45, green: 0.30, blue: 0.34, alpha: 1))
                    }
                        
                    else if (l == 1) {
                        gameStage.ColorVector.append(UIColor(red: 0.55, green: 0.41, blue: 0.44, alpha: 1))
                    }
                    else {
                        gameStage.ColorVector.append(BlockColor)
                    }
                    
                    
                }
                
                
                
            }
            
            
            
            
            
            //.Began
            //case for when the finger first touches the screen
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
            if (WithinBoundsOf(touchCoordinates, AreaPoint: XYPoints[i], Area: CGPoint(x: blockSize, y: blockSize))) {
                
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
            
            //.Changed
            //case for while touch is on the screen
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
    //XYPoints lives in the RoodViewController for now.
    
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
    
    func ColumnOneForGameView(sender: GameView) -> CGPoint? {
        
        
        return gameStage.ColumnOne
    }
    
    func ColumnOneColorForGameView(sender: GameView) -> UIColor? {
        
        return gameStage.ColumnOneColor
        
    }

}
