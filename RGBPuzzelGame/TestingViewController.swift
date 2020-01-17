//
//  TestingViewController.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 1/16/20.
//  Copyright © 2020 Samuel Hoffmann. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class TestingViewController: UIViewController {

    
    @IBOutlet weak var game_view: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /////reset code: uncomment and run once to reset saved values to first time run state/////
//        UserDefaults.standard.set(0, forKey: "Saved_Level_Record:Unlocked:\(1)")
//        UserDefaults.standard.set(0, forKey: "Saved_Level_Record:Last:\(1)")
//        UserDefaults.standard.set(0, forKey: "Saved_Level_Record:Completed:\(1)")
//        UserDefaults.standard.set(0, forKey: "Saved_Level_Record:Unlocked:\(0)")
//        UserDefaults.standard.set(0, forKey: "Saved_Level_Record:Last:\(0)")
//        UserDefaults.standard.set(0, forKey: "Saved_Level_Record:Completed:\(0)")
//        UserDefaults.standard.set(false, forKey: "isNotFirstTime")
//        while true {
//            print("UserDefaults reset. Please comment out the reset lines and run the code again")
//            sleep(5)
//        }
        ///////////////////////////////////////////////////////////////////////////////////////////
        
        /////load a level/////
//        if let view = self.game_view {
//
//            let temp = Level()
//            temp.size = self.game_view.frame.size
//            temp.setUp(package: 1, numberInPackage: 1, locked: false, menu: LevelMenu())
//            temp.scaleMode = .fill
//
//            view.presentScene(temp)
//            view.ignoresSiblingOrder = true
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
        ///////////////////////
        
        


        
        
    }
}
