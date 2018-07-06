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

    var menu = LevelMenu()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            menu = LevelMenu()
            
            menu.size = self.view.frame.size
            
//            testLevel.setUp(package: 1, numberInPackage: 1, redLayer: "red", greenLayer: "green", blueLayer: "blue", startingPos: CGPoint(x: 143, y: 717), endingPos: CGPoint(x: 0, y: 0))
            
//            testLevel.setUp(package: 1, numberInPackage: 1, redLayer: "red_1_1", greenLayer: "green_1_1", blueLayer: "blue_1_1", startingPos: CGPoint(x: view.frame.midX, y: view.frame.maxY), endingPos: CGPoint(x: view.frame.midX, y: view.frame.minY))
            
            menu.initializeMenu(NumberOfLevels: 6, Restricted: true, MenuNumber: 1)
            
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
            
            menu.scaleMode = .fill
            
            //testLevel.size = view.bounds.size
            view.presentScene(menu)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    func showScene(scene: SKScene){
        
    }
    
    func showMenu(){
        if let view = self.view as! SKView? {
            view.presentScene(menu)
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
            return .all
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
