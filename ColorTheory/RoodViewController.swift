//
//  RoodViewController.swift
//  Rood
//
//  Created by Jose Canizares on 10/25/15.
//  Copyright © 2015 rustic_republic. All rights reserved.
//

import UIKit


class RoodViewController: UIViewController, GameViewDataSource {
    
    

    @IBOutlet weak var gameView: GameView! {
        didSet {
            gameView.XYDataSource = self
            
            //gameView.addGestureRecognizer(UIPanGestureRecognizer(target: gameView, action: "translate:"))
            
        }
        
        
    }

    
    var color: UIColor = UIColor.lightGrayColor() {
        didSet {
            
            UpdateUI()
        }
    }
    
    //X of block being dragged
    var xpos: CGFloat = 100 {
        didSet {
            UpdateUI()
        }
    }
    
    
    
    //Y of block being dragged
    var ypos: CGFloat  = 100 {
        didSet {
            UpdateUI()
        }
    }
    
    
    
    private struct Constants {
        static let GestureScale: CGFloat = 1
    }
    
    
    
    @IBAction func dragBlock(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            //how much it as changed in the gameView's
            //coordinate system
            let translation = gesture.translationInView(gameView)
            let XdragChange = translation.x
            let YdragChange = translation.y
            
            if XdragChange != 0 {
                xpos += XdragChange
                ypos += YdragChange
                print(xpos)
                print(ypos)
                gesture.setTranslation(CGPointZero, inView: gameView)
                
            }
        default: break
        }
    }
    
    
    
    
    
    
    
    
    
    
    

    
    struct PathNames {
        static let Block1 = "Block1"
        static let Block2 = "Block2"
        static let Block3 = "Block3"
    }
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    
        
    }
    
    func UpdateUI() {
        
        gameView?.setNeedsDisplay()
        //optional since when segue is preparing, outlets are not set!
    }
    
    
    
    
    func XYForGameView(sender: GameView) -> CGPoint? {
        let XYPoint = CGPoint(x: xpos, y: ypos)
        return XYPoint
    }
        
    
    
        
    

}
