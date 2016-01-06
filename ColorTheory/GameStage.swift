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
    
    //ColorBuffer
    var ColorMemory : Int = 4
    
    
    //Number of Blocks
    var NumberOfBlocks : Int = 15
    
    //Block Spacing
    //includes the blocksize
    //so actual spacing between blocks is BlockSpacing - BlockSize
    
    
    var BlockSpacing : CGFloat = 50
    
    //Block Size
    var BlockSize : CGFloat = 50
    
    //Column One Color
    var ColumnOneColor : UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
    
    var ColumnTwoColor : UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
    
    var ColumnThreeColor : UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
    
    //var x = fetchData()
    
    //Vector of Colors for each corresponding block.
    //The order of this vector corresponds exactly with the order of the XYPoints vector.
    var ColorVector : [UIColor] = [UIColor]()
    
    

    
    //The Three Column Positions (top left corner)
    
    var ColumnOnePosition : CGPoint = CGPoint(x: 0, y: 0)
    
    var ColumnTwoPosition : CGPoint = CGPoint(x: 10, y: 10)
    
    var ColumnThreePosition : CGPoint = CGPoint(x: 20, y: 20)
        
    
    
    //XYPoints.append(CGPoint(x: CGFloat(0.0) + CGFloat(j*BlockSpacing), y: CGFloat(0.0) + CGFloat(i*BlockSpacing)))
    
    
    
    
    
    
}