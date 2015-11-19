//
//  Block.swift
//  Rood
//
//  Created by Jose Canizares on 11/6/15.
//  Copyright © 2015 rustic_republic. All rights reserved.
//

import UIKit

class Block {
    
    var Path : UIBezierPath = UIBezierPath()
    var PathName : String
    var lineWidth: CGFloat
    var posX : Double
    var posY : Double
    
    //(x-a)^4 + (y-b)^4 = r^4
    
    var x = 0.0
    
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
    
    func DrawSquircle() {
        
        let a = posX
        let b = posY
        
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

    
    }
    
    
    
    
    
    
    init(PathName: String, posX: Double, posY: Double, lineWidth: CGFloat) {
        self.PathName = PathName
        self.posX = posX
        self.posY = posY
        self.lineWidth = lineWidth
        
        
    }
    
    
    
}