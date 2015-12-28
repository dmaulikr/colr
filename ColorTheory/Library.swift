//
//  Library.swift
//  ColorTheory
//
//  Created by Jose Canizares on 12/15/15.
//  Copyright © 2015 Singulariti. All rights reserved.
//

import Foundation
import UIKit



//Function that determines whether the first Point is within the area defined by 
//AreaPoint and Area
//returns True if it is, False if it isn't.

func WithinBoundsOf(Point: CGPoint, AreaPoint: CGPoint, Area: CGPoint) -> Bool
{
    //checks if Point is within the bounds defined by AreaPoint and Area
    
    return (((AreaPoint.x < Point.x) && (Point.x < AreaPoint.x + Area.x)) && ((AreaPoint.y < Point.y) && (Point.y < AreaPoint.y + Area.y)))
}

//Grid and Snap-to-Grid Functions.


//Animation Functions.

//Physics Functions. (gravity in pull-up main menu? blocks bounce off each other a little?)
//easy to do with UIDynamicAnimator and UIDynamicBehaviors
