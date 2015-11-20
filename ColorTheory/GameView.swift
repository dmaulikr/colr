//
//  gameView.swift
//  Rood
//
//  Created by Jose Canizares on 10/25/15.
//  Copyright © 2015 rustic_republic. All rights reserved.
//

import UIKit



@IBDesignable
class GameView: UIView {
    
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
    
    var Center: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    private var bezierPaths = [String:UIBezierPath]() //strings as the keys
    //UIBezierPaths as the arguments

    
    
    func setPath(path: UIBezierPath?, named name: String) {
        //adds to dictionary
        bezierPaths[name] = path
        //changes model so you need setNeedDisplay
        setNeedsDisplay()
    }
    
    
    
    
    func DrawBlock(posX : CGFloat, posY: CGFloat, size: CGFloat) -> UIBezierPath {
        
        let Path : UIBezierPath = UIBezierPath()
        
        
        
        
        let point = CGPoint(x: posX - size, y: posY - size)
        let point1 = CGPoint(x: posX + size, y: posY - size)
        let point2 = CGPoint(x: posX + size, y : posY + size)
        let point3 = CGPoint(x: posX - size, y: posY + size)
        
        Path.moveToPoint(point)
        Path.addLineToPoint(point1)
        Path.addLineToPoint(point2)
        Path.addLineToPoint(point3)
        
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
        
        
        //let size = CGSize(width: 20, height: 20)
        
        
        Path.lineWidth = lineWidth
        
        //squircle centered at a,b equation: (x-a)^4 + (y-b)^4 = r^4
        
        return Path
    }
    
    
    
    
    
    
    
    
    //Drawing
    
    override func drawRect(rect: CGRect) {
        
        
        //for IBDesignability
        
        let Path = DrawBlock(Center.x, posY: Center.y, size: 20)
        
        color.set()
        Path.fill()
        Path.stroke()
        
        
        
    }
    
    
    
    
    
    
    
    
}

