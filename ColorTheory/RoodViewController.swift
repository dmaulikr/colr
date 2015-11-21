//
//  RoodViewController.swift
//  Rood
//
//  Created by Jose Canizares on 10/25/15.
//  Copyright © 2015 rustic_republic. All rights reserved.
//

import UIKit


class RoodViewController: UIViewController {
    
    

    @IBOutlet weak var gameView: GameView!

    
    var color: UIColor = UIColor.lightGrayColor() {
        didSet {
            
            UpdateUI()
        }
    }
    
    
    
    @IBAction func dragBlock(sender: UIPanGestureRecognizer) {
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
    
    
    
    
    
        
    
    
        
    

}
