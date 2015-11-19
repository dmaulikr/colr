//
//  RoodViewController.swift
//  Rood
//
//  Created by Jose Canizares on 10/25/15.
//  Copyright © 2015 rustic_republic. All rights reserved.
//

import UIKit


class RoodViewController: UIViewController {

  
    var lineWidth: CGFloat = 0.5
    
    
    @IBOutlet var gameView: GameView!

    
    var Center: CGPoint {
        return gameView.convertPoint(gameView.center, fromView: gameView.superview)
    }
    
    var Radius: CGFloat {
        return ((min(gameView.bounds.size.width, gameView.bounds.size.height))/4)
    }
    

    
    struct PathNames {
        static let Block1 = "Block1"
        static let Block2 = "Block2"
        static let Block3 = "Block3"
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        let Block1 = Block(PathName: PathNames.Block1, posX: Double(gameView.center.x - 105), posY: Double(gameView.center.y), lineWidth: CGFloat(0.5))
        
        let Block2 = Block(PathName: PathNames.Block2, posX: Double(gameView.center.x), posY: Double(gameView.center.y), lineWidth: CGFloat(0.5))
        
        let Block3 = Block(PathName: PathNames.Block3, posX: Double(gameView.center.x + 105), posY: Double(gameView.center.y), lineWidth: CGFloat(0.5))
        
       
        Block1.DrawSquircle()
        Block2.DrawSquircle()
        Block3.DrawSquircle()
        
        
        
        //make visible by adding to gameView

        gameView.setPath(Block1.Path, named: PathNames.Block1)
        gameView.setPath(Block2.Path, named: PathNames.Block2)
        gameView.setPath(Block3.Path, named: PathNames.Block3)
        
    }
    
    
        
    
    
        
    

}
