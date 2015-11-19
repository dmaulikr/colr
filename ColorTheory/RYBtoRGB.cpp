//
//  main.cpp
//  RYB to RGB
//
//  Created by Hunter Leise on 11/4/15.
//  Copyright © 2015 Singulariti. All rights reserved.
//

#include <iostream>
#include <stdio.h>
#include <math.h>
using namespace std;

// calculate max of 3 floating point values
float calculateMax(float r, float y, float b) {
    float max = r;
    if (y >= max) {
        max = y;
    }
    
    if (b >= max) {
        max = b;
    }
    
    return max;
}

// calculate RGB from RYB value
float RYBtoRGB(float r, float y, float b, int i){
    float white[] = {1.0, 1.0, 1.0};
    float red[] = {1.0, 0.0, 0.0};
    float yellow[] = {1.0, 1.0, 0.0};
    float blue[] = {0.163, 0.373, 0.6};
    float violet[] = {0.5, 0.0, 0.5};
    float green[] = {0.0, 0.66, 0.2};
    float orange[] = {1.0, 0.5, 0.0};
    float black[] = {0.2, 0.094, 0.0};
    
    float rPoint = 1 - r;
    float yPoint = 1 - y;
    float bPoint = 1 - b;
    
    return (white[i] * rPoint * bPoint * yPoint +
        red[i] * r * bPoint * yPoint +
        blue[i] * rPoint * b * yPoint +
        violet[i] * r * b * yPoint +
        yellow[i] * rPoint * bPoint * y +
        orange[i] * r * bPoint * y +
        green[i] * rPoint * b * y +
        black[i] * r * b * y) * 255;
}

// Calculate RYB value from amound of each color
float PiecesToRYB(float color, float max) {
    if (color == max) {
        color = 1.0;
    } else {
        color = (color / max);
    }
    return color;
}

int main(){
    float r, y, b;
    int RGB_Red, RGB_Green, RGB_Blue;
    
    // get user input of how many pieces of each color there are
    cout << "red: ";
    cin >> r;
    
    cout << "yellow: ";
    cin >> y;
    
    cout << "blue: ";
    cin >> b;
    
    // calculate RYB value from pieces
    float max = calculateMax(r, y, b);
    r = PiecesToRYB(r, max);
    y = PiecesToRYB(y, max);
    b = PiecesToRYB(b, max);
    
    // calculate RGB from RYB
    RGB_Red = int(RYBtoRGB(r, y, b, 0) + 0.5);
    RGB_Green = int(RYBtoRGB(r, y, b, 1) + 0.5);
    RGB_Blue = int(RYBtoRGB(r, y, b, 2) + 0.5);
    
    printf("%f %f %f\n", r, y, b);
    printf("%d %d %d\n", RGB_Red, RGB_Green, RGB_Blue);
    
    return 0;
}