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

    var tapTouchCoordinates : CGPoint = CGPoint(x: 0, y: 0)
    

    //Storage for XYPoints. For now, it stays here, in the Controller.
    //doesn't matter what start value is because of calls in viewDidLoad
    var XYPoints : [CGPoint] = [CGPoint]() {
        didSet {
            UpdateUI()
        }
    }
    
    
    //The previous Colors.
    //regularly appended.
    
    var ColumnOneColors : [UIColor] = []
    
    var ColumnTwoColors : [UIColor] = []
    
    var ColumnThreeColors : [UIColor] = []
    
    
    
    
    //Starting Block Colors.
    //red 0.933 0.147 0.32
    //yellow 0.964 0.957 0.002
    //blue 0.454 0.454 0.8
    
    let CyanColor = UIColor(red: 0.57, green: 0.90, blue: 0.933, alpha: 1)

    let MagentaColor = UIColor(red: 0.933, green: 0.63, blue: 0.90, alpha: 1)
    
    let YellowColor = UIColor(red: 0.952, green: 0.945, blue: 0.312, alpha: 1)
    
    
    
    //Set-up function for initiating gameStage's colorVector with appropriate number of colors.
    //DataSource dependent
    func SetUpColorVector() {
        
        
        //append gameStage's color vector with appropriate
        //number of colors
        for var i = 0; i < gameStage.NumberOfBlocks; i++ {
            
            if (i % 3 == 0) {
                gameStage.ColorVector.append(CyanColor)
            }
            
            else if (i % 3 == 1) {
                gameStage.ColorVector.append(MagentaColor)
            }
            else {
                gameStage.ColorVector.append(YellowColor)
            }
            
            
        }
        
        
    }
    
    
    
    func SetUpColumnPositions() {
        
        let CenteringFormat : CGFloat = gameView.frame.size.width/6 - gameStage.BlockSize/2
        
        gameStage.ColumnOnePosition = CGPoint(x: CenteringFormat, y: 50)
        gameStage.ColumnTwoPosition = CGPoint(x: gameView.frame.size.width/3 + CenteringFormat, y: 50)
        gameStage.ColumnThreePosition = CGPoint(x: 2*(gameView.frame.size.width/3) + CenteringFormat, y: 50)
        
    }
    
    
    func SetUpColorMemory() {
        
        
        
    }
    
    
    //Snaps one block to Grid.
    func SnapToGrid(XYPointIndex: Int) {
        
        let GridBlockWidth : CGFloat = gameView.bounds.width/3
        
        
        let GridBlockHeight : CGFloat = gameStage.BlockSpacing + gameStage.BlockSize
        
        let numberOfBlocks = XYPoints.count
        
        let BlockCenter = CGPoint(x: XYPoints[XYPointIndex].x + CGFloat(gameStage.BlockSize/2.0), y: XYPoints[XYPointIndex].y + CGFloat(gameStage.BlockSize/2.0))
        
        //on X
        let CenteringFormat : CGFloat = gameView.frame.size.width/6 - gameStage.BlockSize/2
        
        
        
        let TopMargin : CGFloat = 25
        
            
        //rows
        for var i = 0; i < numberOfBlocks/3; i++ {
                
            //columns
            for var j = 0; j < 3; j++ {
                    
                if (WithinBoundsOf(BlockCenter, AreaPoint: CGPoint(x: GridBlockWidth*CGFloat(j), y: CGFloat(i)*GridBlockHeight), Area: CGPoint(x: GridBlockWidth, y: GridBlockHeight + TopMargin)))
                {
                    
                        let XWidth = CGFloat(j)*GridBlockWidth
                        
                        XYPoints[XYPointIndex] = CGPoint(x:  XWidth + CenteringFormat, y: CGFloat(i)*GridBlockHeight + TopMargin)
                        
                        break
                }
                        
                else {
                    
                    
                
                    }
                
                
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
            
            
            
            print(touchCoordinates)
            //if within column bounds, then make column capture color and delete block
            var numOfBlocks = numberOfBlocks
            
            for var l = 0; l < numOfBlocks; l++ {
                
                let BlockCenter = CGPoint(x: XYPoints[l].x + CGFloat(blockSize/2.0), y: XYPoints[l].y + CGFloat(blockSize/2.0))
                
                
                SnapToGrid(l)
                
                //If it is within bounds of ColumnOne
                //then color changes
                //(these bounds are larger than the actual ColumnOne drawn)
                //Check if OnLock is true for that block so we know we are just adding the color of the block we are dragging to the column
                //and not the blocks that might already be on top of a column
                if (WithinBoundsOf(BlockCenter, AreaPoint: CGPoint(x: 0, y: 150), Area: CGPoint(x: gameView.bounds.size.width/3, y: gameView.bounds.size.height)) && OnLock[l] == true) {
                    
                    print("FIRST AREA")
                    
                    
                    //Here is where the mixing of colors occurs. 
                    //Colors are mixed using CMYK addition.
                    //The final color depends on the previous colors in the column array.
                    
                    
                    
                    //set the color of the block that was just added to the columnOne bounds to AddedColor)
                    let AddedColor : UIColor = gameStage.ColorVector[l]
                    
                    //Add to the array of colors for that column
                    ColumnOneColors.append(AddedColor)
                
                    
                    //get the new column using MixColumnColors
                    let NewColor = MixColumnColors(ColumnOneColors)
                    
                    
                    //Set ColumnOne's color to this final result
                    gameStage.ColumnOneColor = NewColor
                    
                    
                    
                    
                    
                    
                    
                    UpdateUI()
                    
                    
                    //Delete the block that was just dragged into the column area.
                    
                    
                    
                    //All that is needed to delete a block.
                    /*
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
                    
                    */
                    
                    
                    //break from the for loop once we add the color because only one color will be added
                    //so this is sufficient
                    break
                    
                    
                }
                    
                    
                    
                //If it is within bounds of ColumnTwo
                //then color changes
                //(these bounds are larger than the actual ColumnTwo drawn)
                    //Check if OnLock is true for that block so we know we are just adding the color of the block we are dragging to the column
                    //and not the blocks that might already be on top of a column
                else if (WithinBoundsOf(BlockCenter, AreaPoint: CGPoint(x: gameView.bounds.size.width/3, y: 150), Area: CGPoint(x: gameView.bounds.size.width/3, y: gameView.bounds.size.height)) && OnLock[l] == true) {
                    
                    
                    print("SECOND AREA")
                    
                    //Here is where the mixing of colors occurs.
                    //Colors are mixed using CMYK addition.
                    //The final color depends on the previous colors in the column array.
                    
                    
                    
                    //set the color of the block that was just added to the columnOne bounds to AddedColor)
                    let AddedColor : UIColor = gameStage.ColorVector[l]
                    
                    //Add to the array of colors for that column
                    ColumnTwoColors.append(AddedColor)
                    
                    
                    //get the new column using MixColumnColors
                    let NewColor = MixColumnColors(ColumnTwoColors)
                    
                    
                    //Set ColumnOne's color to this final result
                    gameStage.ColumnTwoColor = NewColor
                    
                    UpdateUI()
                    
                    
                    //Delete the block that was just dragged into the column area.
                    
                    
                    
                    //All that is needed to delete a block.
                    /*
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
                    */
                    
                    //break from the for loop once we add the color because only one color will be added
                    //so this is sufficient
                    break
                    
                }
                    
                    
                    
                    
                    
                //If it is within bounds of ColumnThree
                //then color changes
                //(these bounds are larger than the actual ColumnThree drawn)
                    
                //Check if OnLock is true for that block so we know we are just adding the color of the block we are dragging to the column
                    //and not the blocks that might already be on top of a column
                else if (WithinBoundsOf(BlockCenter, AreaPoint: CGPoint(x: 2*(gameView.bounds.size.width/3), y: 150), Area: CGPoint(x: gameView.bounds.size.width/3, y: gameView.bounds.size.height)) && OnLock[l] == true) {
                    
                    
                    print("THIRD AREA")
                    
                    //Here is where the mixing of colors occurs.
                    //Colors are mixed using CMYK addition.
                    //The final color depends on the previous colors in the column array.
                    
                    
                    
                    //set the color of the block that was just added to the columnOne bounds to AddedColor)
                    let AddedColor : UIColor = gameStage.ColorVector[l]
                    
                    //Add to the array of colors for that column
                    ColumnThreeColors.append(AddedColor)
                    
                    
                    //get the new column using MixColumnColors
                    let NewColor = MixColumnColors(ColumnThreeColors)
                    
                    
                    //Set ColumnOne's color to this final result
                    gameStage.ColumnThreeColor = NewColor
                    
                    
                    UpdateUI()
                    
                    
                    //Delete the block that was just dragged into the column area.
                    
                    
                    
                    //All that is needed to delete a block.
                    /*
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
                    
                    */
                    
                    
                    //break from the for loop once we add the color because only one color will be added
                    //so this is sufficient
                    break
                    
                    
                }


                    
                    
                else {
                    
                   
                    
                }
                
                
                
                
                
                
                
                
            }
            
            for var i = 0; i < numberOfBlocks; i++ {
                    
                    OnLock[i] = false
                    
                
                    
                    
                    
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
            if (WithinBoundsOf(touchCoordinates, AreaPoint: XYPoints[i], Area: CGPoint(x: blockSize + 10, y: blockSize + 10))) {
                
                
                
                OnLock[i] = true
                
                
                
                //print("BEGAN")
                
                
               
                //TESTING
                
                /*
                
                //All that is needed to add a new block.
                //print("Added through began.")
                //Adds a new XYPoint to XYPoints
                XYPoints.append(XYPoints[i])
                //Adds a new color to the color vector.
                gameStage.ColorVector.append(gameStage.ColorVector[i])
                //Adds a new OnLock bool.
                OnLock.append(false)
                //Increments the number of blocks.
                gameStage.NumberOfBlocks++
                
                */
                
                //numOfBlocks++
                
                //UpdateUI()
                
                //print(gameStage.ColorVector)
                //print("Changed \(OnLock)")
                
                
                //fix mouse to center of block
                XYPoints[i].x = touchCoordinates.x - blockSize/2
                XYPoints[i].y = touchCoordinates.y - blockSize/2
                
                
                XYPoints[i].x += Xdrag
                XYPoints[i].y += Ydrag
                
                //print(XYPoints)
                
                //print(gameStage.NumberOfBlocks)
                //print(numberOfBlocks)
                
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
            //print(gameStage.NumberOfBlocks)
            //print(numberOfBlocks)
            
            //print("CHANGED \(OnLock)")
            
            let translation = gesture.translationInView(gameView)
            
            
            //print(XYPoints)
            //for each block
            for var i = 0; i < numberOfBlocks; i++ {
                
            //while looping through blocks, get the latest touch coordinate (safer 
            //than getting it outside of the loop?)
            let LatestTouchCoordinates = CGPoint(x: touchCoordinates.x + translation.x, y: touchCoordinates.y + translation.y)
                
            
            //print(translation)
            //if a block is already locked on (has a finger on it)
            //either by having the first touch placed over it,
            //or by dragging finger from empty space over to the top of the block.
                
                
            
            if (OnLock[i] == true)
            {
               
                
                //then get translation
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
            else if (WithinBoundsOf(LatestTouchCoordinates, AreaPoint: XYPoints[i], Area: CGPoint(x: blockSize, y: blockSize)) && !WithinBoundsOf(touchCoordinates, AreaPoint: XYPoints[i], Area: CGPoint(x: blockSize, y: blockSize)))
            {
                
                
                    OnLock[i] = true
                
                
                //reset translation to 0, 0
                gesture.setTranslation(CGPointZero, inView: gameView)
                
                //Only adds a new block when the touch right before is outside the block, and has been dragged inside the block (when the block wasn't locked on before)
                
                
                /*
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
                */
                
                
                
                
                }
                
                
            
                
                
            }
            
        default: break
        }
    }
    
    
    
    @IBAction func clearColumnColor(gesture: UITapGestureRecognizer) {
        
        
        print("TAPPED")
        //print(ColumnOneColorVector)
        //print(touchCoordinates)
        //print(tapTouchCoordinates)
        
        
        switch gesture.state {
            
        case .Began:
            fallthrough
        case .Changed:
            fallthrough
        case .Ended:
            
            
            if (WithinBoundsOf(tapTouchCoordinates, AreaPoint: CGPoint(x: 0, y: 150), Area: CGPoint(x: gameView.bounds.size.width/3, y: gameView.bounds.size.height))){
                
                
                //Set column color to white
                
                gameStage.ColumnOneColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
                
                ColumnOneColors = []
               
                print("Cleared Column One")
                
                
                UpdateUI()
            }
            
            else if (WithinBoundsOf(tapTouchCoordinates, AreaPoint: CGPoint(x: gameView.bounds.size.width/3, y: 150), Area: CGPoint(x: gameView.bounds.size.width/3, y: gameView.bounds.size.height))){
                
                
                //Set column color to white
                
                
                gameStage.ColumnTwoColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
                
                ColumnTwoColors = []
                
                print("Cleared Column Two")
                
                
                UpdateUI()
            }
            
            else if (WithinBoundsOf(tapTouchCoordinates, AreaPoint: CGPoint(x: 2*(gameView.bounds.size.width/3), y: 150), Area: CGPoint(x: gameView.bounds.size.width/3, y: gameView.bounds.size.height))){
                
                
                //Set column color to white
                
               
                gameStage.ColumnThreeColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
                
                ColumnThreeColors = []
                
                print("Cleared Column Three")
                
                UpdateUI()
            }
            
            
            
            
            
            
            
            
            
            
            
            
        default: break
        }
    }
    
    
    //detects finger touch location
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            touchCoordinates = touch.locationInView(gameView)
            //print("from changed \(touchCoordinates)")
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            tapTouchCoordinates = touch.locationInView(gameView)
            print("from began \(tapTouchCoordinates)")
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
        
        
        

        
        
        

    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    XYPoints = gameView.SetUpBlockPoints()
    SetUpColumnPositions()
        
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
    
    func BlockSpacingForGameView(sender: GameView) -> CGFloat? {
        
        return gameStage.BlockSpacing
        
    }
    
        
    func BlockSizeForGameView(sender: GameView) -> CGFloat? {
        
        return gameStage.BlockSize
        
    }
    
    
    func ColorVectorForGameView(sender: GameView) -> [UIColor]? {
        
        return gameStage.ColorVector
        
    }
    
    func ColumnOnePositionForGameView(sender: GameView) -> CGPoint? {
        
        
        return gameStage.ColumnOnePosition
    }
    
    func ColumnOneColorForGameView(sender: GameView) -> UIColor? {
        
        return gameStage.ColumnOneColor
        
    }
    
    
    
    func ColumnTwoPositionForGameView(sender: GameView) -> CGPoint? {
        
        return gameStage.ColumnTwoPosition
    }
    func ColumnTwoColorForGameView(sender: GameView) -> UIColor? {
        
        return gameStage.ColumnTwoColor
        
    }
    func ColumnThreePositionForGameView(sender: GameView) -> CGPoint? {
        
        return gameStage.ColumnThreePosition
        
    }
    func ColumnThreeColorForGameView(sender: GameView) -> UIColor? {
        
        return gameStage.ColumnThreeColor
        
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
