//
//  gameView.swift
//  Rood
//
//  Created by Jose Canizares on 10/25/15.
//  Copyright © 2015 rustic_republic. All rights reserved.
//

import UIKit

class GameView: UIView {
    
    var lineWidth: CGFloat = 5 {didSet { setNeedsDisplay() } }
    
    var color: UIColor = UIColor.lightGrayColor() {didSet { setNeedsDisplay() } }


    var Center: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    var Radius: CGFloat {
        return ((min(bounds.size.width, bounds.size.height))/4)
    }

    override func drawRect(rect: CGRect) {
        let Path = UIBezierPath(arcCenter: Center, radius: Radius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        
            Path.lineWidth = lineWidth
            color.set()
            Path.fill()
            Path.stroke()
    }
    

}
