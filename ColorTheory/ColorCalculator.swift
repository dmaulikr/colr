//
//  main.swift
//  RYBtoRGB
//
//  Created by Hunter Leise on 11/11/15.
//  Copyright © 2015 Singulariti. All rights reserved.
//

import Foundation
import UIKit
/*
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
        black[i] * r * b * y)
}

// Calculate RYB value from amount of each color
func PiecesToRYB(var color:Double, max:Double) -> Double {
    if (color == max) {
        color = 1.0
    } else {
        color = (color / max)
    }
    return color
}

func colorCalculator(redCount : Double, yellowCount : Double, blueCount : Double) -> (Red: Double, Green: Double, Blue: Double)
{
    let red = Double(redCount)
    let yellow = Double(yellowCount)
    let blue = Double(blueCount)
    
    var RGB_Red, RGB_Green, RGB_Blue: Double
    
    // calculate RYB value from pieces
    let max = calculateMax(red, y: yellow, b: blue)
    let r = PiecesToRYB(red, max:max)
    let y = PiecesToRYB(yellow, max:max)
    let b = PiecesToRYB(blue, max:max)
    
    // calculate RGB from RYB
    RGB_Red = RYBtoRGB(Double(red), y:Double(yellow), b:Double(blue), i:0) + 0.5
    RGB_Green = RYBtoRGB(Double(red), y:Double(yellow), b:Double(blue), i:1) + 0.5
    RGB_Blue = RYBtoRGB(Double(red), y:Double(yellow), b:Double(blue), i:2) + 0.5
    
    print("\(r) \(y) \(b)")
    print("\(RGB_Red) \(RGB_Green) \(RGB_Blue)")
    
    
    return (RGB_Red, RGB_Green, RGB_Blue)
}

*/

//Mixes two sets of CMYK values by adding them and dividing them by the largest number
func MixColors(c1: CGFloat, m1: CGFloat, y1 : CGFloat, k1: CGFloat, c2: CGFloat, m2: CGFloat, y2 : CGFloat, k2: CGFloat) -> (r: CGFloat, g: CGFloat, b : CGFloat) {
    
    let c : CGFloat = c1 + c2
    let m : CGFloat = m1 + m2
    let y : CGFloat = y1 + y2
    let k : CGFloat = k1 + k2
    
    let divider = max(c, m, y, k)
    
    let C = c/divider
    let M = m/divider
    let Y = y/divider
    let K = k/divider
    
    
    
    return CMYKToRGB(C, m: M, y: Y, k: K)
}

//Converts RGB values to CMYK values
func RGBToCMYK(r : CGFloat, g : CGFloat, b : CGFloat) -> (c : CGFloat, m : CGFloat, y : CGFloat, k : CGFloat) {
    
    if r==0 && g==0 && b==0 {
        return (0, 0, 0, 1)
    }
    var c = 1 - r
    var m = 1 - g
    var y = 1 - b
    let minCMY = min(c, m, y)
    c = (c - minCMY) / (1 - minCMY)
    m = (m - minCMY) / (1 - minCMY)
    y = (y - minCMY) / (1 - minCMY)
    return (c, m, y, minCMY)
}

//Converts CMYK values to RGB values
func CMYKToRGB(c: CGFloat, m : CGFloat, y : CGFloat, k : CGFloat) -> (r: CGFloat, g: CGFloat, b: CGFloat) {
    
    let r = (1 - c) * (1 - k)
    let g = (1 - m) * (1 - k)
    let b = (1 - y) * (1 - k)
    return (r, g, b)
    
}