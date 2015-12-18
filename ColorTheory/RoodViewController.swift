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
    
    var OnLock : [Bool] = [Bool]() {
        didSet {
            UpdateUI()
        }
        
    }
    
    
    //Bool Vector that keeps track of which block has been "picked up"
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
        
        
        let numberOfBlocks = gameStage.NumberOfBlocks
        for var i = 0; i < numberOfBlocks; i++ {
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
    
    
    
    
    
    //UIPanGesture called dragBlock.
    //Called everytime something is dragged.
    //Needs optimization.
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
            
            
            //if within column bounds, then make column capture color and delete block
            var numOfBlocks = numberOfBlocks
            
            for var l = 0; l < numOfBlocks; l++ {
                
                let BlockCenter = CGPoint(x: XYPoints[l].x + CGFloat(blockSize/2.0), y: XYPoints[l].y + CGFloat(blockSize/2.0))
                //If it is within bounds of ColumnOne
                //then color changes
                //bounds is larger than the actual ColumnOne
                if (WithinBoundsOf(BlockCenter, AreaPoint: CGPoint(x: gameStage.ColumnOne.x - 25, y: gameStage.ColumnOne.y - 25), Area: CGPoint(x: 100, y: 450))) {
                    
                    //
                    //XYPoints[l] = CGPoint(x: gameStage.ColumnOne.x, y: XYPoints[l].y)
                    //
                    gameStage.ColumnOneColor = gameStage.ColorVector[l]
                    
                    
                    
                    //All that is needed to delete a block.
                    
                    //Removes the XYPoint associated with the block that is being absorbed into the column.
                    XYPoints.removeAtIndex(l)
                    //Removes the corresponding color in the color vector.
                    gameStage.ColorVector.removeAtIndex(l)
                    //Removes corresponding bool in the OnLock vector.
                    OnLock.removeAtIndex(l)
                    //Decrement number of blocks.
                    gameStage.NumberOfBlocks--
                    
                    //Decrement the numOfBlocks of this for loop so 
                    //that Array Index is not out of range
                    numOfBlocks--
                    
                    
                    
                    
                }
                    //else
                    
                else {
                    
                   
                    
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
                
                
                
                print("BEGAN")
                
                
               
                //TESTING
                
                
                //All that is needed to add a new block.
                print("Added through began.")
                //Adds a new XYPoint to XYPoints
                XYPoints.append(XYPoints[i])
                //Adds a new color to the color vector.
                gameStage.ColorVector.append(gameStage.ColorVector[i])
                //Adds a new OnLock bool.
                OnLock.append(false)
                //Increments the number of blocks.
                gameStage.NumberOfBlocks++
                
                
                
                //numOfBlocks++
                
                //UpdateUI()
                
                //print(gameStage.ColorVector)
                //print("Changed \(OnLock)")
                
                
                
                
                XYPoints[i].x += Xdrag
                XYPoints[i].y += Ydrag
                
                //print(XYPoints)
                
                print(gameStage.NumberOfBlocks)
                print(numberOfBlocks)
                
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
            
            //print("CHANGED")
            print(gameStage.NumberOfBlocks)
            print(numberOfBlocks)
            
            //print("CHANGED \(OnLock)")
            
            let translation = gesture.translationInView(gameView)
            
            
            //print(XYPoints)
            //for each block
            for var i = 0; i < numberOfBlocks; i++ {
                
            //while looping through blocks, get the latest touch coordinate (safer 
            //than getting it outside of the loop?)
            let LatestTouchCoordinate = CGPoint(x: touchCoordinates.x + translation.x, y: touchCoordinates.y + translation.y)
                
            //print(translation)
            //if a block is already locked on (has a finger on it)
            //either by having the first touch placed over it,
            //or by dragging finger from empty space over to the top of the block.
            
            if (OnLock[i] == true)
            {
                //print("Locked On: \(translation)")
                let translation = gesture.translationInView(gameView)
                let Xdrag = translation.x
                let Ydrag = translation.y
                XYPoints[i].x += Xdrag
                XYPoints[i].y += Ydrag
                
                OnLock[i] = true
                
                //makes it incremental
                gesture.setTranslation(CGPointZero, inView: gameView)
                
                
                //print("Came from within.")
                
            
            
            }
            
                //else if block isn't set to lock yet, but user dragged over the block
            else if (WithinBoundsOf(LatestTouchCoordinate, AreaPoint: XYPoints[i], Area: CGPoint(x: blockSize, y: blockSize)) && !WithinBoundsOf(touchCoordinates, AreaPoint: XYPoints[i], Area: CGPoint(x: blockSize, y: blockSize)))
            {
                
                
                    OnLock[i] = true
                
                
                //reset translation to 0, 0
                gesture.setTranslation(CGPointZero, inView: gameView)
                
                //Only adds a new block when the touch right before is outside the block, and has been dragged inside the block (when the block wasn't locked on before)
                
                //All that is needed to add a new block.
                //print("Added through change.")
                //Adds a new XYPoint to XYPoints
                XYPoints.append(XYPoints[i])
                //Adds a new color to the color vector.
                gameStage.ColorVector.append(gameStage.ColorVector[i])
                //Adds a new OnLock bool.
                OnLock.append(false)
                //Increments the number of blocks.
                gameStage.NumberOfBlocks++
                
                
                
                
                
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
    
    
    //Updates the view.
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
