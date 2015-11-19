//
//  main.swift
//  RYBtoRGB
//
//  Created by Hunter Leise on 11/11/15.
//  Copyright © 2015 Singulariti. All rights reserved.
//

import Foundation

// calculate max of 3 floating point values
func calculateMax(r:Double, y:Double, b:Double) -> Double {
    var max = r
    if (y >= max) {
        max = y
    }
    
    if (b >= max) {
        max = b
    }
    
    return max
}

// calculate RGB from RYB value
func RYBtoRGB(r:Double, y:Double, b:Double, i:Int) -> Double {
    let white = [1.0, 1.0, 1.0]
    let red = [1.0, 0.0, 0.0]
    let yellow = [1.0, 1.0, 0.0]
    let blue = [0.163, 0.373, 0.6]
    let violet = [0.5, 0.0, 0.5]
    let green = [0.0, 0.66, 0.2]
    let orange = [1.0, 0.5, 0.0]
    let black = [0.2, 0.094, 0.0]
    
    let rPoint: Double = 1 - r
    let yPoint: Double = 1 - y
    let bPoint: Double = 1 - b
    
    return (white[i] * rPoint * bPoint * yPoint +
        red[i] * r * bPoint * yPoint +
        blue[i] * rPoint * b * yPoint +
        violet[i] * r * b * yPoint +
        yellow[i] * rPoint * bPoint * y +
        orange[i] * r * bPoint * y +
        green[i] * rPoint * b * y +
        black[i] * r * b * y) * 255
}

// Calculate RYB value from amound of each color
func PiecesToRYB(var color:Double, max:Double) -> Double {
    if (color == max) {
        color = 1.0
    } else {
        color = (color / max)
    }
    return color
}

func colorCalculator(){/*
    var r:Double, y:Double, b:Double
    var RGB_Red, RGB_Green, RGB_Blue: Int
    
    // calculate RYB value from pieces
    let max = calculateMax(r, y:y, b:b)
    r = PiecesToRYB(r, max:max)
    y = PiecesToRYB(y, max:max)
    b = PiecesToRYB(b, max:max)
    
    // calculate RGB from RYB
    RGB_Red = Int(RYBtoRGB(r, y:y, b:b, i:0) + 0.5)
    RGB_Green = Int(RYBtoRGB(r, y:y, b:b, i:1) + 0.5)
    RGB_Blue = Int(RYBtoRGB(r, y:y, b:b, i:2) + 0.5)
    
    print("\(r) \(y) \(b)")
    print("\(RGB_Red) \(RGB_Green) \(RGB_Blue)")*/
}