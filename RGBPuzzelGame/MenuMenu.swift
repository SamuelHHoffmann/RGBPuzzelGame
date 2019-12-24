//
//  MenuMenu.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 9/30/19.
//  Copyright © 2019 Samuel Hoffmann. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit




class MenuMenu: SKScene {

    var previousScene = SKScene()
    var previousSceneType = SceneType.none

    var backButton = SKShapeNode()
    var backButton_img = SKSpriteNode()

    var settingsButton = SKShapeNode()
    var settingsButton_img = SKSpriteNode()

    var level0Button = levelThumbnail()
    var level1Button = levelThumbnail()
    var level2Button = levelThumbnail()
    var level3Button = levelThumbnail()

    var level1Menu = LevelMenu()
    
    var type = SceneType.none

    func setUpMenu(){

        self.type = SceneType.none

        setUpSettingsButtons()
        setUpMenus()
    }

    private func setUpSettingsButtons(){

        
        print(self.size)
        
        level0Button.setUp(level: 0, width: Double(self.frame.height), height: Double(self.frame.width)/4)
        level0Button.position = CGPoint(x: self.frame.maxX - self.frame.width/8, y: self.frame.height/2)
        level0Button.zRotation = -1 * CGFloat(Double.pi/2)
        self.addChild(level0Button)
        
        level1Button.setUp(level: 1, width: Double(self.frame.height), height: Double(self.frame.width)/4)
        level1Button.position = CGPoint(x: level0Button.position.x - self.frame.width/4, y: self.frame.height/2)
        level1Button.zRotation = -1 * CGFloat(Double.pi/2)
        self.addChild(level1Button)
        
        level2Button.setUp(level: 2, width: Double(self.frame.height), height: Double(self.frame.width)/4)
        level2Button.position = CGPoint(x: level1Button.position.x - self.frame.width/4, y: self.frame.height/2)
        level2Button.zRotation = -1 * CGFloat(Double.pi/2)
        self.addChild(level2Button)
        
        level3Button.setUp(level: 3, width: Double(self.frame.height), height: Double(self.frame.width)/4)
        level3Button.position = CGPoint(x: level2Button.position.x - self.frame.width/4, y: self.frame.height/2)
        level3Button.zRotation = -1 * CGFloat(Double.pi/2)
        self.addChild(level3Button)

        
        

//        backButton_img = SKSpriteNode(imageNamed: "back button")
//        backButton_img.position = CGPoint(x: self.frame.minX+cs.width/2, y: self.frame.midY+(self.frame.height/2)-(self.frame.height/16))
//        backButton_img.zPosition = 4
//        backButton_img.zRotation = CGFloat(-1*(Double.pi/2))
//        backButton_img.setScale(0.35)
//        self.addChild(backButton_img)
//
//        backButton = SKShapeNode(rectOf: CGSize(width: (backButton_img.frame.width)*2, height: (backButton_img.frame.height)*2))
//        backButton.fillColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.001)
//        backButton.position = backButton_img.position
//        backButton.strokeColor = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.001)
//        backButton.zPosition = 5
//        self.addChild(backButton)

    }

    func setUpMenus(){
        
        level1Menu.size = self.size
        level1Menu.initializeMenu(NumberOfLevels: 4, Restricted: true, MenuNumber: 1)
        level1Menu.scaleMode = .fill
        
        
        
        
    }
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: self.view!)
    }


    func goBack(){
//        //go back to previous scene
//        var scene = SKScene()
//
//        scene = previousScene as! welcomeMenu
//
//            //type is none or settings
//            print("Fatal Error Detection: Trying to transition Settings -> Settings or Settings -> none")
//            return
//        }
//
//        if let view = self.view as SKView? {
//            scene.isPaused = false
//            view.presentScene(scene)
//        }

    }


    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        //print(touches.first?.location(in: self))
        //#level1Button.position = (touches.first?.location(in: self))!
        
        
        for node in nodes(at: (touches.first?.location(in: self))!) {

            if node == settingsButton {



            }else if node == backButton {



            }else if node == level0Button {



            }else if node == level1Button {

                if let view = self.view as SKView? {
                    view.presentScene(level1Menu)
                }

            }else if node == level2Button {



            }else if node == level3Button {



            }else{


            }
        }
    }




    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }


}
