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
        
        if let backgroundView = self.view as? SKView {
            
            let tempScene = SKScene(size: self.view.frame.size)
            tempScene.backgroundColor = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 1)
            tempScene.scaleMode = .fill
            
            backgroundView.presentScene(tempScene)
        }
        
        
//        if let view = self.game_view { //used for testing RGBAScene's
//
//            let temp = RGBAScene()
//            temp.size = self.game_view.frame.size
//            temp.setUp(redLayerStr: "1,1R", greenLayerStr: "1,1G", blueLayerStr: "1,1B", physics: false)
//            temp.scaleMode = .fill
//
//            view.presentScene(temp)
//            view.ignoresSiblingOrder = true
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
        
        if let view = self.game_view {
            // Load the SKScene from 'GameScene.sks'

            
            home = welcomeMenu()
            home.size = self.game_view.frame.size
            home.setUp(sceneSize: self.game_view.frame.size)
            home.scaleMode = .fill
            view.presentScene(home)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
