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
    
    
    //The previous Color.
    //regularly updated.
    var PreviousColor : UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
    
    
    //Starting Block Colors.
    let RedColor = UIColor(red: 0.933, green: 0.147, blue: 0.32, alpha: 1)
    let YellowColor = UIColor(red: 0.964, green: 0.957, blue: 0.002, alpha: 1)
    let BlueColor = UIColor(red: 0.454, green: 0.454, blue: 0.8, alpha: 1)
    
    
    
    
    //Set-up function for initiating gameStage's colorVector with appropriate number of colors.
    //DataSource dependent
    func SetUpColorVector() {
        
        
        //append gameStage's color vector with appropriate
        //number of colors
        for var i = 0; i < gameStage.NumberOfBlocks; i++ {
            
            if (i == 0) {
                gameStage.ColorVector.append(RedColor)
            }
            
            else if (i == 1) {
                gameStage.ColorVector.append(YellowColor)
            }
            else {
                gameStage.ColorVector.append(BlueColor)
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
    
    
    //Setup function for OnLockVector
    //gets called in ViewDidLoad
    func SetUpOnLockVector() -> [Bool] {
        
        var OnLockVector = [Bool]()
        
        for var i = 0; i < gameStage.NumberOfBlocks; i++ {
            
            OnLockVector.append(false)
            
        }
        
        return OnLockVector
        
    }
    
    
    
    
    
    
    
    //UIPanGesture called dragBlock.
    //Called everytime something is dragged.
    //Needs optimization.
    @IBAction func dragBlock(gesture: UIPanGestureRecognizer) {
        
        let numberOfBlocks = gameStage.NumberOfBlocks
        
        let blockSize = gameStage.BlockSize
        
        
        //print("PANNED")
        
       
        
       
        
        
        
        
        
        //print(gameView.ColorVector.count)
        //print(XYPoints.count)
        //print(OnLock.count)
        
        
        
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
                //(these bounds are larger than the actual ColumnOne drawn)
                if (WithinBoundsOf(BlockCenter, AreaPoint: CGPoint(x: gameStage.ColumnOne.x - 25, y: gameStage.ColumnOne.y - 25), Area: CGPoint(x: 100, y: 450))) {
                    
                    
                    
                    
                    //Here is where the mixing of colors occurs. 
                    //Colors are mixed using CMYK addition.
                    //The final color depends on the newly added one and the previous one.
                    //The final color becomes the previous color in the end.
                    
                    
                    //set the color of the block that was just added to the columnOne bounds to NewColor)
                    let NewColor : UIColor = gameStage.ColorVector[l]
                    
                    //Extract the RGB Components of this new color)
                    let NewColorComponents = NewColor.components
                    
                    //Calculate CMYK values using RGB to CMYK function
                    let (C, M, Y, K) = RGBToCMYK(NewColorComponents.red, g: NewColorComponents.green, b: NewColorComponents.blue)
                    
                    //get PreviousColor RGB Components
                    let PreviousColorComponents = PreviousColor.components
                    
                    
                    //Calculate CMYK values of PreviousColor
                    let (C2, M2, Y2, K2) = RGBToCMYK(PreviousColorComponents.red, g: PreviousColorComponents.green, b: PreviousColorComponents.blue)
                    
                    
                    //Calculate RGB values using MixColors function
                    let (r, g, b) = MixColors(C, m1: M, y1: Y, k1: K, c2: C2, m2: M2, y2: Y2, k2: K2)
                    
                    
                    //Set ColumnOne's color to this final result
                    gameStage.ColumnOneColor = UIColor(red: r, green: g, blue: b, alpha: 1)
                    
                    //Set PreviousColor to this final result
                    PreviousColor = UIColor(red: r, green: g, blue: b, alpha: 1)
                    
                    
                    //print(r, g, b)
                    
                    UpdateUI()
                    
                    
                    //Delete the block that was just dragged into the column area.
                    
                    
                    
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
            
            
            
            
            
            
            
            
            //for each block
            for var i = 0; i < numberOfBlocks; i++ {
                
                
                //print(i)
                //if the touch is within the block
            if (WithinBoundsOf(touchCoordinates, AreaPoint: XYPoints[i], Area: CGPoint(x: blockSize, y: blockSize))) {
                
                
                
                OnLock[i] = true
                
                
                
                //print("BEGAN")
                
                
               
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
    
    
    
    @IBAction func clearColumnColor(gesture: UITapGestureRecognizer) {
        
        
        print("TAPPED")
        //print(ColumnOneColorVector)
        print(touchCoordinates)
        
        switch gesture.state {
            
        case .Began:
            fallthrough
        case .Changed:
            fallthrough
        case .Ended:
            if (WithinBoundsOf(touchCoordinates, AreaPoint: CGPoint(x: 0, y: 0), Area: CGPoint(x: 250, y: 900))){
                
                
                //Set column color to white
                
                gameStage.ColumnOneColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
                PreviousColor = gameStage.ColumnOneColor
                UpdateUI()
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











//Needed for extracting the components of a color
//uses the getRed function to do so...

extension UIColor {
    var components:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r,g,b,a)
    }
}
