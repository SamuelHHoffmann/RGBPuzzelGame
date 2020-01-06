//
//  Standards.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 12/23/19.
//  Copyright © 2019 Samuel Hoffmann. All rights reserved.
//

import Foundation
import UIKit

class Standards{
    
    //Music and Sounds//
    static let music = ["RGBA music - synth background.m4a", "background music piano,guitar.m4a"]
    
    
    //Level Data//
    static let startPositions = ["0,1" : CGPoint(x: 290, y: -50),
                                "0,2" : CGPoint(x: 290, y: -50),
                                "0,3" : CGPoint(x: 290, y: -50),
                                "0,4" : CGPoint(x: 290, y: -50)]
    
    static let endPositions = ["0,1" : CGPoint(x: -290, y: -50),
                               "0,2" : CGPoint(x: -290, y: -50),
                               "0,3" : CGPoint(x: -290, y: -50),
                               "0,4" : CGPoint(x: -290, y: -50)]
    
    
    
    //Misc//
    static var lastCompletedLocal = 0 //local value for UserDefaults.standard.set(levelNum, forKey: "Saved_Level_Record:Completed:\(packageNum)")
    
    
    
    
    
    
    //DEBUG TOOLS//
    static let editmode = false //prints location of touches
    static let debugMode = false //shows collision layers
    
    
    
    func update(){
        
        
    }
    
    func save(){
        
    }
    
}
