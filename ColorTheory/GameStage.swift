//
//  GameStage.swift
//  ColorTheory
//
//  Created by Jose Canizares on 12/11/15.
//  Copyright © 2015 Singulariti. All rights reserved.
//

import Foundation
import UIKit

//The model for a stage/level.


public class GameStage {
    
    //stagelevel data
    
    //Number of Blocks
    var NumberOfBlocks : Int = 3
    
    //Block Spacing
    var BlockSpacing : Int = 70
    
    //Block Size
    var BlockSize : CGFloat = 50
    
    //Column One Color
    var ColumnOneColor : UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
    
    //var x = fetchData()
    
    //Vector of Colors for each corresponding block.
    //The order of this vector corresponds exactly with the order of the XYPoints vector.
    var ColorVector : [UIColor] = [UIColor]()
    
    

    
    //The first column (the left one) that will keep track of the sum of colors somehow.
    
    var ColumnOne : CGPoint = CGPoint(x: 50, y: 50)
        
    
    
    //XYPoints.append(CGPoint(x: CGFloat(0.0) + CGFloat(j*BlockSpacing), y: CGFloat(0.0) + CGFloat(i*BlockSpacing)))
    
    
    
    
    
    
}