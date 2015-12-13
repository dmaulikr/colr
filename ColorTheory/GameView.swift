//
//  gameView.swift
//  Rood
//
//  Created by Jose Canizares on 10/25/15.
//  Copyright © 2015 rustic_republic. All rights reserved.
//

import UIKit

//Delegation
//
protocol GameViewDataSource: class {
    func XYForGameView(sender: GameView) -> [CGPoint]?
    func NumberOfBlocksForGameView(sender: GameView) -> Int?
    func BlockSpacingForGameView(sender: GameView) -> Int?
    func BlockSizeForGameView(sender: GameView) -> CGFloat?
    func ColorVectorForGameView(sender: GameView) -> [UIColor]?
}

@IBDesignable
class GameView: UIView {
    
    
    
    
    var Center: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    
    //IBInspectable values overwrite these
    //They are priority. It will show those values
    //instead of these when you run the game.
    //hit enter when changing the value in the storyboard attribute inspector
    
    
    @IBInspectable
    var ColorVector: [UIColor] = [UIColor]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var lineWidth: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    

    
    
    
    //DataSource dependent
    var numberOfBlocks: Int = 5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var blockSize : CGFloat = 50 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var blockSpacing : Int = 500 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    
    
    var YPosition : CGFloat = CGFloat(50.0) {

        didSet {
            
            setNeedsDisplay()
        }
    }
    
   
    
    var XPosition : CGFloat = CGFloat(50.0) {

        didSet {
            setNeedsDisplay()
        }
    }
    
    
    var CornerRadius: CGFloat {
        return 0
    }
    
    
    
    
    
    
    
    var Rectangle : CGRect = CGRect(origin: CGPoint.zero, size: CGSize.zero);
    
    
    
    
    
    
    
    //GameViewDataSource for x and y position
    weak var DataSource: GameViewDataSource?
    
   
    
    
    
    
    var Paths = [UIBezierPath]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    //DataSource dependent
    var BlockPoints : [CGPoint] = [CGPoint]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    
    
    
    
    
    
    
    
    //draws blocks in grid formation
    
    func SetUpBlockPoints() -> [CGPoint] {
        
        //retrieve block spacing from data source
        blockSpacing = DataSource?.BlockSpacingForGameView(self) ?? 100
        
        var BlockPointsArray : [CGPoint] = [CGPoint]()
        
        
        var i: Int
        
        //rows
        for i = 0; i < numberOfBlocks / 3; i++ {
            
            
            //columns
            for var j = 0; j < 3; j++ {
                
            BlockPointsArray.append(CGPoint(x: CGFloat(0.0) + CGFloat(j*blockSpacing), y: CGFloat(0.0) + CGFloat(i*blockSpacing)))
            //[CGPointZero, CGPoint(x: 0, y: 0 + CGFloat(75)), CGPoint(x: 0, y: 0 + CGFloat(2*75))]
                
            }
        }
        
        //leftovers
        for var k = 0; k < numberOfBlocks % 3; k++ {
            
            BlockPointsArray.append(CGPoint(x: CGFloat(0.0) + CGFloat(k*blockSpacing), y: CGFloat(0.0) + CGFloat(i*blockSpacing)))
        }
        
        
        print(BlockPointsArray)
        
        return BlockPointsArray
    }
    
    
    
    
    
    
    func DrawBlock(originX: CGFloat, originY: CGFloat, size: CGFloat) -> UIBezierPath {
        
        
        
        Rectangle.origin.x = originX
        Rectangle.origin.y = originY
        Rectangle.size.width = size
        Rectangle.size.height = size
        
        let Path = UIBezierPath(roundedRect: Rectangle, cornerRadius: CornerRadius)
        
        
        Path.lineWidth = lineWidth
        
        
        
        return Path
        
        
    }
    
    
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
    
    
    
    
    //creates an array of Block paths
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
    
    func SetUpNumberOfBlocks() {
        //retrieve number of blocks from data source
        numberOfBlocks = (DataSource?.NumberOfBlocksForGameView(self))!
    }
    
    //Drawing
    //called everytime setNeedsDisplay() is called
    override func drawRect(rect: CGRect) {
        
        
        //clears array of paths each time setNeedsDisplay is called
        Paths.removeAll()
        
        

        
        ArrangeBlocks(numberOfBlocks)
        
        //retrieve Color Vector from data source
        ColorVector = (DataSource?.ColorVectorForGameView(self))!
        
        
        //loop through the paths to draw the blocks with appropriate color
        for (index, value) in Paths.enumerate() {
            
            
            ColorVector[index].set()
            print(ColorVector[index])
            value.fill()
            value.stroke()
        }
        
       
        
        
        
    }
    
    
    
    
    
    
    
    
}

