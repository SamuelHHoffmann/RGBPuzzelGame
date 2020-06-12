//
//  GameViewController.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 5/24/18.
//  Copyright © 2018 Samuel Hoffmann. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    
    @IBOutlet weak var game_view: SKView!
    
    var home = welcomeMenu()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//                UserDefaults.standard.set(0, forKey: "Saved_Level_Record:Unlocked:\(1)")
//                UserDefaults.standard.set(0, forKey: "Saved_Level_Record:Last:\(1)")
//                UserDefaults.standard.set(0, forKey: "Saved_Level_Record:Completed:\(1)")
//                UserDefaults.standard.set(0, forKey: "Saved_Level_Record:Unlocked:\(0)")
//                UserDefaults.standard.set(0, forKey: "Saved_Level_Record:Last:\(0)")
//                UserDefaults.standard.set(0, forKey: "Saved_Level_Record:Completed:\(0)")
//                UserDefaults.standard.set(false, forKey: "isNotFirstTime")
//                while true {
//                    print("UserDefaults reset. Please comment out the reset lines and run the code again")
//                    sleep(5)
//                }
//        
        
        Standards.load()
        
        //setup background/overflow scene
        if let backgroundView = self.view as? SKView {
            
            Standards.backgroundSKScene = SKScene(size: self.view.frame.size)
            Standards.backgroundSKScene.backgroundColor = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 1)
            Standards.backgroundSKScene.scaleMode = .fill
            
            
            //generate background music
            if Standards.musicOn{
                Standards.backgroundSKScene.run(SKAction.repeatForever(SKAction.playSoundFileNamed(Standards.music[Int.random(in: 0...Standards.music.count-1)], waitForCompletion: true)), withKey: "music")
            }
//            Standards.backgroundSKScene.run(SKAction.repeatForever(SKAction.run {
//                if Standards.backgroundSKScene.action(forKey: "music") == nil && Standards.musicOn{
//                    Standards.backgroundSKScene.run(SKAction.playSoundFileNamed(Standards.music[Int.random(in: 0...Standards.music.count-1)], waitForCompletion: false), withKey: "music")
//                }
//            }))
            
            
            backgroundView.presentScene(Standards.backgroundSKScene)
        }
        
        
        //Setup Standards.swift
        Standards.settingsScene.size = self.game_view.frame.size
        Standards.settingsScene.setUpSettings()

        //show user their first scene
        if UserDefaults.standard.bool(forKey: "isNotFirstTime") == true {
            //not first time
            if let view = self.game_view {
                home = welcomeMenu()
                home.size = self.game_view.frame.size
                home.setUp(sceneSize: self.game_view.frame.size)
                home.scaleMode = .fill
                view.presentScene(home)
                view.ignoresSiblingOrder = true
                view.showsFPS = false
                view.showsNodeCount = false
            }
        }else{
            //is first time or has been reset
            UserDefaults.standard.set(true, forKey: "isNotFirstTime")
            
            let menuMenuTemp = MenuMenu()
            menuMenuTemp.size = self.game_view.frame.size
            menuMenuTemp.setUpMenu()
            menuMenuTemp.previousScene = menuMenuTemp
            
            
            menuMenuTemp.level0Menu.previousScene = menuMenuTemp
            
//            let firstLevel = Level()
//            firstLevel.size = self.game_view.frame.size
//            firstLevel.setUp(package: 0, numberInPackage: 1, locked: false, menu: menuMenuTemp.level0Menu)
            
            sleep(2) //slow down for a couple seconds
            
            if let view = self.game_view {
                menuMenuTemp.level0Menu.scaleMode = .fill
                view.presentScene(menuMenuTemp.level0Menu)
                view.ignoresSiblingOrder = true
                view.showsFPS = false
                view.showsNodeCount = false
            }
        }
        
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .allButUpsideDown
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
