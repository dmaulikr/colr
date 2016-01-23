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


//dot product
func DotProduct(firstColor : UIColor, secondColor : UIColor) -> CGFloat {
    
    let firstColorComponents = firstColor.components
    let secondColorComponents = secondColor.components
    
    let sum1 = firstColorComponents.red * secondColorComponents.red
    let sum2 = firstColorComponents.green * secondColorComponents.green
    let sum3 = firstColorComponents.blue * secondColorComponents.blue
    
    let sum = sum1 + sum2 + sum3
    
    
    return sum
}



//Mixes colors of a column with an added color using MixColors
func MixColumnColors(ColumnColors : [UIColor]) -> UIColor {
    
//    let CyanColor = UIColor(red: 0.57, green: 0.90, blue: 0.933, alpha: 1)
//    
//    let MagentaColor = UIColor(red: 0.933, green: 0.63, blue: 0.90, alpha: 1)
//    
//    let YellowColor = UIColor(red: 0.952, green: 0.945, blue: 0.312, alpha: 1)

    var Ranking : [(Num: CGFloat, Color: UIColor)] = []
    
    
    //reference point color
    let firstColor = UIColor(red: 0.6, green: 0.4, blue: 0.5, alpha: 1)
    
    for var i = 0; i < ColumnColors.count; i++ {
        
        print("ITERATION")

        Ranking.append((Num : DotProduct(firstColor, secondColor: ColumnColors[i]), Color : ColumnColors[i]))
        
        
    }
    
    
    
    let SortedRanking = Ranking.sort() {$0.0 < $1.0}

    for var i = 0; i < SortedRanking.count; i++ {
        
        
        print("SORTED ITERATION")
        print("Dot Product Ranking is: \(SortedRanking[i].Num) and Color is: \(SortedRanking[i].Color)")
        
        
    }
    
    
    var sumColor : UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    
   
    
    for var i = 0; i < SortedRanking.count/2; i++ {
        
        
        
            print("LAST MIXTURE: \(SortedRanking.endIndex - (i+1)) Color: \(SortedRanking[SortedRanking.endIndex - (i+1)].Color)")
            let (r1, g1, b1) = MixColors(sumColor, secondColor: SortedRanking[SortedRanking.endIndex - (i+1)].Color)
            let sumColor1 : UIColor = UIColor(red: r1, green: g1, blue: b1, alpha: 1)
        
        
        
        
            
            print("FIRST MIXTURE: \(i) Color: \(SortedRanking[i].Color)")
            let (r2, g2, b2) = MixColors(sumColor1, secondColor: SortedRanking[i].Color)
            sumColor = UIColor(red: r2, green: g2, blue: b2, alpha: 1)
            
        
        
        
        
        
    }
    
    
    
    
    if (SortedRanking.count % 2) == 1 {
        
        print("LAST MIXTURE: \(SortedRanking.endIndex/2) Color: \(SortedRanking[SortedRanking.endIndex/2].Color)")
        let (r1, g1, b1) = MixColors(sumColor, secondColor: SortedRanking[SortedRanking.endIndex/2].Color)
        sumColor = UIColor(red: r1, green: g1, blue: b1, alpha: 1)
        
        
    }
    
    
    print(sumColor)
    
    return sumColor
}

//Mixes two sets of CMYK values by adding them and dividing them by the largest number
func MixColors(firstColor : UIColor, secondColor : UIColor) -> (r: CGFloat, g: CGFloat, b : CGFloat) {
    
    let firstColorComponents = firstColor.components
    
    let (c1, m1, y1, k1) = RGBToCMYK(firstColorComponents.red, g: firstColorComponents.green, b: firstColorComponents.blue)

    let secondColorComponents = secondColor.components
    
    let (c2, m2, y2, k2) = RGBToCMYK(secondColorComponents.red, g: secondColorComponents.green, b: secondColorComponents.blue)
    
    
    let c : CGFloat = c1 + c2
    let m : CGFloat = m1 + m2
    let y : CGFloat = y1 + y2
    let k : CGFloat = k1 + k2
    
    let divider = 1.1 * max(c, m, y, k)
    
    let C = c/divider
    let M = m/divider
    let Y = y/divider
    let K = k/(1.2 * divider)
    
    
    
    
    
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


//Needed for extracting the components of a color
//uses the getRed function to do so...

