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
    
}

@IBDesignable
class GameView: UIView {
    
    
    
    
    var Center: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    
    //IBInspectable values overwrite these
    //They are priority. It will show those values
    //instead of these when you run the game.
    
    
    @IBInspectable
    var color: UIColor = UIColor.lightGrayColor() {
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
    var blockSpacing : Int = 75 {
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
    
    
    
    

    
    
    
    
    
    
    
    func SetUpBlockPoints() -> [CGPoint] {
        
        
        var BlockPointsArray : [CGPoint] = [CGPoint]()
        
        for var i = 0; i < numberOfBlocks; i++ {
            
            BlockPointsArray.append(CGPoint(x: CGFloat(0.0), y: CGFloat(0.0) + CGFloat(i*blockSpacing)))
            //[CGPointZero, CGPoint(x: 0, y: 0 + CGFloat(75)), CGPoint(x: 0, y: 0 + CGFloat(2*75))]
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
        
        //receives interpreted coordinates from RoodViewController
        BlockPoints = DataSource?.XYForGameView(self) ?? [CGPointZero, CGPoint(x: 0, y: 0 + CGFloat(75)), CGPoint(x: 0, y: 0 + CGFloat(2*75))]
        
        
        
        for var i = 0; i < numBlocks; ++i {
            
            
            
            
            print("DRAWN")
            
          
            XPosition = BlockPoints[i].x
            YPosition = BlockPoints[i].y
            
            
            
            //Delegation
            //appends the array of Paths depending on numberOfBlocks,
            //and other parameters
            
            
            
            
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
        numberOfBlocks = (DataSource?.NumberOfBlocksForGameView(self))!
    }
    
    //Drawing
    //called everytime setNeedsDisplay() is called
    override func drawRect(rect: CGRect) {
        
        
        //clears array of paths each time setNeedsDisplay is called
        Paths.removeAll()
        
        

        
        ArrangeBlocks(numberOfBlocks)
        
        
        
        
        
        for x in Paths {
            color.set()
            x.fill()
            x.stroke()
        }
        
       
        
        
        
    }
    
    
    
    
    
    
    
    
}

