//
//  gameView.swift
//  Rood
//
//  Created by Jose Canizares on 10/25/15.
//  Copyright © 2015 rustic_republic. All rights reserved.
//

import UIKit
    



class GameView: UIView {
    
    private var bezierPaths = [String:UIBezierPath]() //strings as the keys
    //UIBezierPaths as the arguments
    
    var color: UIColor = UIColor.lightGrayColor()
    
    func setPath(path: UIBezierPath?, named name: String) {
        //adds to dictionary
        bezierPaths[name] = path
        //changes model so you need setNeedDisplay
        setNeedsDisplay()
    }
    override func drawRect(rect: CGRect) {
        for(_, path) in bezierPaths {
            color.set()
            path.fill()
            path.stroke()
        }
    }
    
}

