//
//  gameView.swift
//  Rood
//
//  Created by Jose Canizares on 10/25/15.
//  Copyright © 2015 rustic_republic. All rights reserved.
//

import UIKit

//Delegation
//View delegates information getters to the controller so it can be handled there.
protocol GameViewDataSource: class {
    func XYForGameView(sender: GameView) -> [CGPoint]?
    func NumberOfBlocksForGameView(sender: GameView) -> Int?
    func BlockSpacingForGameView(sender: GameView) -> CGFloat?
    func BlockSizeForGameView(sender: GameView) -> CGFloat?
    func ColorVectorForGameView(sender: GameView) -> [UIColor]?
    
    //Columns
    func ColumnOnePositionForGameView(sender: GameView) -> CGPoint?
    func ColumnOneColorForGameView(sender: GameView) -> UIColor?
    func ColumnTwoPositionForGameView(sender: GameView) -> CGPoint?
    func ColumnTwoColorForGameView(sender: GameView) -> UIColor?
    func ColumnThreePositionForGameView(sender: GameView) -> CGPoint?
    func ColumnThreeColorForGameView(sender: GameView) -> UIColor?
    
    
}

//The view for a stage/level.


@IBDesignable
class GameView: UIView {
    
    
    
    //The true center, using superview's center.
    var Center: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    //If there is an @IBInspectable before a var:
    //IBInspectable values overwrite these
    //They are priority. It will show those values
    //instead of these when you run the game.
    //hit enter when changing the value in the storyboard attribute inspector
    
    
    //The view's vector of colors.
    
    var ColorVector: [UIColor] = [UIColor]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //The line width of the blocks.
    
    var lineWidth: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    

    
    
    //The number of blocks.
    //DataSource dependent.
    var numberOfBlocks: Int = 5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    //The block size.
    //DataSource dependent.
    var blockSize : CGFloat = 50 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    //The block spacing.
    //DataSource dependent.
    var blockSpacing : CGFloat = 500 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    
    //Temporary storage for y positions.
    var YPosition : CGFloat = CGFloat(50.0) {

        didSet {
            
            setNeedsDisplay()
        }
    }
    
   
    //Temporary storage for x positions.
    var XPosition : CGFloat = CGFloat(50.0) {

        didSet {
            setNeedsDisplay()
        }
    }
    
    //the corner radius of the blocks.
    var CornerRadius: CGFloat {
        return 0
    }
    
    
    
    
    
    
    //Empty rectangle
    var Rectangle : CGRect = CGRect(origin: CGPoint.zero, size: CGSize.zero);
    
    
    
    
    
    
    
    //GameViewDataSource for x and y position
    weak var DataSource: GameViewDataSource?
    
   
    
    
    //vector of UIBezierPaths
    
    var Paths = [UIBezierPath]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //XYPoints which comes from XYPoints in the RoodViewController.
    //DataSource dependent.
    var BlockPoints : [CGPoint] = [CGPoint]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    
    
    
    
    
    
    
    
    //Function that draws blocks in grid formation.
    
    func SetUpBlockPoints() -> [CGPoint] {
        
        //retrieves block spacing from data source
        blockSpacing = DataSource?.BlockSpacingForGameView(self) ?? 100
        blockSize = DataSource?.BlockSizeForGameView(self) ?? 50
        
        var BlockPointsArray : [CGPoint] = [CGPoint]()
        
        
        //on X
        let CenteringFormat : CGFloat = frame.size.width/6 - blockSize/2
        
        let GridBlockHeight : CGFloat = blockSpacing + blockSize
        
        let TopMargin : CGFloat = 25
        
        var i: Int
        
        //rows
        for i = 0; i < numberOfBlocks / 3; i++ {
            
            
            //columns
            for var j = 0; j < 3; j++ {
                
                let XWidth = (CGFloat(j)*(bounds.size.width/3))
                
            //Arrangement using starting points.
            BlockPointsArray.append(CGPoint(x:  XWidth + CenteringFormat, y: CGFloat(i)*GridBlockHeight + TopMargin))
            
                
            }
        }
        
        //leftovers
        for var k = 0; k < numberOfBlocks % 3; k++ {
            
            BlockPointsArray.append(CGPoint(x: CGFloat(k*Int(blockSpacing)), y: CGFloat(i*Int(blockSpacing))))
        }
        
        
        //print(BlockPointsArray)
        
        return BlockPointsArray
    }
    
    
    
    
    
    //Function that draws a block.
    
    func DrawBlock(originX: CGFloat, originY: CGFloat, size: CGFloat) -> UIBezierPath {
        
        
        
        Rectangle.origin.x = originX
        Rectangle.origin.y = originY
        Rectangle.size.width = size
        Rectangle.size.height = size
        
        let Path = UIBezierPath(roundedRect: Rectangle, cornerRadius: CornerRadius)
        
        
        Path.lineWidth = lineWidth
        
        
        
        return Path
        
        
    }
    
    
    //Function that draws a column.
    
    func DrawColumn(originX: CGFloat, originY: CGFloat, width: CGFloat, height: CGFloat) -> UIBezierPath {
        
        
        
        Rectangle.origin.x = originX
        Rectangle.origin.y = originY
        Rectangle.size.width = width
        Rectangle.size.height = height
        
        let Path = UIBezierPath(roundedRect: Rectangle, cornerRadius: CornerRadius)
        
        
        Path.lineWidth = lineWidth
        
        
        
        return Path
        
        
    }
    
    //Function that helps draw a squircle. Right now unused.
    /*
    func Squircle(x: Double) -> Double {
        
        //Wolfram: (6,000,000- x^4)^(1/4)
        let Bound = 10*pow(2, 0.75)*pow(3, 0.25)*sqrt(Double(5))
        let Num = 1000*(sqrt(Double(6)))
        
        let y3 = pow((Bound - Double(x)), 0.25)
        print(y3)
        let y4 = pow((Double(x) + Bound), 0.25)
        print(y4)
        let y5 = pow((pow(Double(x), 2) + Num), 0.25)
        print(y5)
        let y6 = y5*y4*y3
        print(y6)
        return y6
        
    }
    */
    
    
    //Function that draws a squircle. Right now unused.
    
    /*
    func DrawSquircle(posX: Double, posY: Double) -> UIBezierPath {
        
        let Path : UIBezierPath = UIBezierPath()
        let a = posX
        let b = posY
        var x = 0.0
        
        
        let point = CGPoint(x: Double(x) + a, y: Squircle(x) + b)
        Path.moveToPoint(point)
        
        //Domain of x:
        //10*sqrt(2)*pow(5, 0.25) ~21.147
        //207
        
        
        //Domain of x:
        //10*pow(10, 0.75) ~56.234
        //562.34
        //Wolfram: (10,000,000- x^4)^(1/4)
        
        //Domain of x:
        //10*2^(0.75)*3^(1/4)*sqrt(5)
        //49.4923
        //Wolfram: (6,000,000- x^4)^(1/4)
        //Domain = thisNumber * 10
        
        let Domain = 494
        
        for var index = 0; index < Domain; ++index
        {
            let point1 = CGPoint(x: Double(x) + a, y: Squircle(x) + b)
            Path.addLineToPoint(point1)
            
            x += 0.1
        }
        
        for var index = 0; index < Domain; ++index
        {
            let point1 = CGPoint(x: Double(x) + a, y: -1*Squircle(x) + b)
            Path.addLineToPoint(point1)
            
            x -= 0.1
        }
        
        
        //middle line in this for loop
        for var index = 0; index < Domain; ++index
        {
            let point1 = CGPoint(x: Double(x) + a, y: Squircle(x) + b)
            Path.addLineToPoint(point1)
            
            x -= 0.1
        }
        
        
        
        
        for var index = 0; index < Domain; ++index
        {
            let point1 = CGPoint(x: Double(x) + a, y: -1*Squircle(x) + b)
            Path.addLineToPoint(point1)
            
            x += 0.1
        }
        
    
        
        
        Path.lineWidth = lineWidth
        
        //squircle centered at a,b equation: (x-a)^4 + (y-b)^4 = r^4
        
        return Path
    }
    
    */
    
    
    //creates an array of Block paths.
    
    func ArrangeBlocks(numBlocks: Int)
    {
        //retrieve block points from data source
        //receives interpreted coordinates from RoodViewController
        
        BlockPoints = DataSource?.XYForGameView(self) ?? [CGPointZero, CGPoint(x: 0, y: 0 + CGFloat(75)), CGPoint(x: 0, y: 0 + CGFloat(2*75))]
        
        
        
        for var i = 0; i < numBlocks; ++i {
            
            
            
            
            
          
            XPosition = BlockPoints[i].x
            YPosition = BlockPoints[i].y
            
            
            
            
            //retrieve block spacing from data source
            blockSize = (DataSource?.BlockSizeForGameView(self))!
            
            Paths.append(DrawBlock(XPosition, originY:  YPosition, size: blockSize))
            
            //keep track of x and y position of ith block
            BlockPoints[i].x = XPosition
            BlockPoints[i].y = YPosition
            
            
            
            
            
            
        }
        
        
    }
    
    /*
    func translate(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            //how much it as changed in the gameView's
            //coordinate system
            let translation = gesture.translationInView(self)
            let XdragChange = translation.x
            let YdragChange = translation.y
            
            if XdragChange != 0 {
                XTranslation += XdragChange
                YTranslation += YdragChange
                print(XTranslation)
                print(YTranslation)
                gesture.setTranslation(CGPointZero, inView: self)
                
            }
        default: break
        }
    }
*/
    
    
    
    
    //Function that sets up the number of blocks according to what DataSource says it should be.
    
    func SetUpNumberOfBlocks() {
        //retrieve number of blocks from data source
        numberOfBlocks = (DataSource?.NumberOfBlocksForGameView(self))!
    }
    
    
    
    
    //Most important function.
    //Draws.
    //This is called everytime setNeedsDisplay() is called.
    //Do not add too much to this function, since it is called so often.
    //Optimization would be appropriate here.
    
    override func drawRect(rect: CGRect) {
        
        
        //clears array of paths each time setNeedsDisplay is called
        Paths.removeAll()
        
        //retrieve column one from data source
        let ColumnOneDraw : CGPoint = (DataSource?.ColumnOnePositionForGameView(self))!
        let ColumnOneColor : UIColor = (DataSource?.ColumnOneColorForGameView(self))!
        
        let ColumnTwoDraw : CGPoint = (DataSource?.ColumnTwoPositionForGameView(self))!
        let ColumnTwoColor : UIColor = (DataSource?.ColumnTwoColorForGameView(self))!
        
        let ColumnThreeDraw : CGPoint = (DataSource?.ColumnThreePositionForGameView(self))!
        let ColumnThreeColor : UIColor = (DataSource?.ColumnThreeColorForGameView(self))!
        
        
        blockSize = (DataSource?.BlockSizeForGameView(self)) ?? 50
        
        ColumnOneColor.set()
        DrawColumn(ColumnOneDraw.x, originY: ColumnOneDraw.y, width: blockSize, height: 500).fill()
        
        ColumnTwoColor.set()
        DrawColumn(ColumnTwoDraw.x, originY: ColumnTwoDraw.y, width: blockSize, height: 500).fill()
        
        ColumnThreeColor.set()
        DrawColumn(ColumnThreeDraw.x, originY: ColumnThreeDraw.y, width: blockSize, height: 500).fill()
        
        
        
        let BGColor1 = UIColor(red: 0.91, green: 0.71, blue: 0.81, alpha: 0.9)
        let BGColor2 = UIColor(red: 0.58, green: 0.76, blue: 0.79, alpha: 0.9)
        let BGColor3 = UIColor(red: 0.65, green: 0.81, blue: 0.86, alpha: 0.9)
        
        BGColor1.set()
        let bg1 = DrawColumn(0, originY: 150, width: self.bounds.size.width/3, height: self.bounds.size.height)
        
        bg1.fill()
        
        
        BGColor2.set()
        let bg2 = DrawColumn((self.bounds.size.width/3), originY: 150, width: self.bounds.size.width/3, height: self.bounds.size.height)
        
        bg2.fill()
        
        BGColor3.set()
        let bg3 = DrawColumn(2*(self.bounds.size.width/3), originY: 150, width: self.bounds.size.width/3, height: self.bounds.size.height)
        
        bg3.fill()
        
        //print(ColumnOneDraw)
        //print(ColumnTwoDraw)
        //print(ColumnThreeDraw)
        

        //receive latest number of blocks
        SetUpNumberOfBlocks()
        
        //make new paths according to latest number of blocks
        ArrangeBlocks(numberOfBlocks)
        
        //retrieve vector of colors from data source
        ColorVector = (DataSource?.ColorVectorForGameView(self))!
        
        
        //loop through the paths to draw the blocks with appropriate color
        for (index, value) in Paths.enumerate() {
            
            //sets the color of the block
            ColorVector[index].set()
            //print(ColorVector[index])
            //fill
            value.fill()
            //stroke
            value.stroke()
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
}

