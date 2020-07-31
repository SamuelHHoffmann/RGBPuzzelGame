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
        
        NotificationCenter.default.addObserver(self, selector: #selector(setupView), name: Notification.Name("Reset Game"), object: nil)
        
//        testLevel(package: 2, level: 10)
        
        setupView()

        
    }
    
    @objc func setupView(){
        //load standards data
        Standards.load()

        //setup background/overflow scene
        if let backgroundView = self.view as? SKView {
            Standards.backgroundSKScene = SKScene(size: self.view.frame.size)
            Standards.backgroundSKScene.backgroundColor = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 1)
            Standards.backgroundSKScene.scaleMode = .fill
            //generate background music
            if Standards.musicOn{
                MusicPlayer.play(continuous: true)
            }
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
                home.scaleMode = .aspectFit
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
    
    func testLevel(package: Int, level: Int){
        if let view = self.game_view {
            let temp = Level()
            temp.size = self.game_view.frame.size
            temp.setUp(package: package, numberInPackage: level, locked: false, menu: LevelMenu())
            temp.scaleMode = .fill

            view.presentScene(temp)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
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
