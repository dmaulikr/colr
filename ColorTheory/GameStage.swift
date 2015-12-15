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


public struct GameStage {
    
    //stagelevel data
    
    //Number of Blocks
    var NumberOfBlocks : Int = 20
    
    //Block Spacing
    var BlockSpacing : Int = 75
    
    //Block Size
    var BlockSize : CGFloat = 50
    
    
    //Vector of Colors for each corresponding block.
    //The order of this vector corresponds exactly with the order of the XYPoints vector.
    var ColorVector : [UIColor] = [UIColor]()
    
    
    
    
    //The first column (the left one) that will keep track of the sum of colors somehow.
    
    var ColumnOne : CGPoint = CGPoint(x: 0, y: 50)
        

    
    
    
}