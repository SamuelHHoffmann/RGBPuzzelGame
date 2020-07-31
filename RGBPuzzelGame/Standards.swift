//
//  Standards.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 12/23/19.
//  Copyright © 2019 Samuel Hoffmann. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Standards{
    
    //Music and Sounds//
    static var musicOn = true
    static var soundFXON = true
    
    
    //Level Data//
    static let levelCountPerPackage = [0 : 4,
                                       1 : 10,
                                       2 : 0,
                                       3 : 0]
    
    static let startPositions = ["0,1" : CGPoint(x: 290, y: -50),
                                "0,2" : CGPoint(x: 290, y: -50),
                                "0,3" : CGPoint(x: 290, y: -50),
                                "0,4" : CGPoint(x: 290, y: -50),
                                "1,1" : CGPoint(x: 300, y: -35),
                                "1,2" : CGPoint(x: 300, y: -35),
                                "1,3" : CGPoint(x: 300, y: -35),
                                "1,4" : CGPoint(x: 300, y: -35),
                                "1,5" : CGPoint(x: 300, y: -35),
                                "1,6" : CGPoint(x: 300, y: -35),
                                "1,7" : CGPoint(x: 300, y: -35),
                                "1,8" : CGPoint(x: 300, y: -35),
                                "1,9" : CGPoint(x: 300, y: -35),
                                "1,10" : CGPoint(x: 300, y: -35)]
    
    static let endPositions = ["0,1" : CGPoint(x: -290, y: -50),
                               "0,2" : CGPoint(x: -290, y: -50),
                               "0,3" : CGPoint(x: -290, y: -50),
                               "0,4" : CGPoint(x: -290, y: -50),
                               "1,1" : CGPoint(x: -290, y: -35),
                               "1,2" : CGPoint(x: -290, y: -35),
                               "1,3" : CGPoint(x: -290, y: -35),
                               "1,4" : CGPoint(x: -290, y: -35),
                               "1,5" : CGPoint(x: -290, y: -35),
                               "1,6" : CGPoint(x: -290, y: -35),
                               "1,7" : CGPoint(x: -290, y: -35),
                               "1,8" : CGPoint(x: -290, y: -2),
                               "1,9" : CGPoint(x: -290, y: -35),
                               "1,10" : CGPoint(x: -290, y: -35)]
    
    
    
    
    
    //Misc//
//    static var lastCompletedLocal = 0 //local value for UserDefaults.standard.set(levelNum, forKey: "Saved_Level_Record:Completed:\(packageNum)")
    
    
    
    //Background SKScene//
    static var backgroundSKScene = SKScene()
    
    static let settingsScene = Settings()
    
    
    //DEBUG TOOLS//
    static let editmode = false //prints location of touches
//    #warning("Edit Mode On! Please turn off before deploying.")
    static let debugMode = false //shows collision layers
//    #warning("Debug Mode On! Please turn off before deploying.")
    
    
    static func update(){
        
        
    }
    
    static func load(){
        soundFXON = !UserDefaults.standard.bool(forKey: "Saved_Data_Record:SoundFX")
        musicOn = !UserDefaults.standard.bool(forKey: "Saved_Data_Record:Music")
    }
    
    static func save(){
        UserDefaults.standard.set(!soundFXON, forKey: "Saved_Data_Record:SoundFX")
        UserDefaults.standard.set(!musicOn, forKey: "Saved_Data_Record:Music")
    }
    
    static func reset(){
        UserDefaults.standard.set(false, forKey: "Saved_Data_Record:SoundFX")
        UserDefaults.standard.set(false, forKey: "Saved_Data_Record:Music")
        for num in levelCountPerPackage.keys {
            UserDefaults.standard.set(0, forKey: "Saved_Level_Record:Unlocked:\(num)")
            UserDefaults.standard.set(0, forKey: "Saved_Level_Record:Last:\(num)")
            UserDefaults.standard.set(0, forKey: "Saved_Level_Record:Completed:\(num)")
        }
        UserDefaults.standard.set(false, forKey: "isNotFirstTime")
     
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Reset Game"), object: nil)
    }
    
}
