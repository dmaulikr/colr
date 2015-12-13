//
//  GameStage.swift
//  ColorTheory
//
//  Created by Jose Canizares on 12/11/15.
//  Copyright © 2015 Singulariti. All rights reserved.
//

import Foundation
import UIKit

public struct GameStage {
    
    var NumberOfBlocks : Int = 20
    
    
    var BlockSpacing : Int = 75
    
    
    var BlockSize : CGFloat = 50
    
    var ColorVector : [UIColor] = [UIColor]()
    
    
    
    
    
    
    var ColumnOne : CGPoint = CGPoint(x: 0, y: 50)
        

    
    //Find a place for this function elsewhere
    func WithinBoundsOf(Point: CGPoint, AreaPoint: CGPoint, Area: CGPoint) -> Bool
    {
        //checks if Point is within the bounds defined by AreaPoint and Area
        
        return (((AreaPoint.x < Point.x) && (Point.x < AreaPoint.x + Area.x)) && ((AreaPoint.y < Point.y) && (Point.y < AreaPoint.y + Area.y)))
    }
    
}