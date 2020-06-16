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

    var backButton = BackButton()

    var settingsButton = SettingsButton()
    
    private var level0Button = levelThumbnail()
    private var level1Button = levelThumbnail()
    private var level2Button = levelThumbnail()
    private var level3Button = levelThumbnail()
    var levels : [levelThumbnail] = []

    var level0Menu = LevelMenu()
    var level1Menu = LevelMenu()
    
    
    var level0MenuLoaded = false
    var level1MenuLoaded = false
    
    
    var menuClicked = levelThumbnail()
    
    
    
    var type = SceneType.none

    func setUpMenu(){

        self.type = SceneType.none

        setUpSettingsButtons()
        setUpMenus()
    }

    private func setUpSettingsButtons(){

        
        //print(self.size)
        
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

        levels.append(level0Button)
        levels.append(level1Button)
        levels.append(level2Button)
        levels.append(level3Button)
        
        let cs = colorSwitch()
        cs.setScale(0.35)
        cs.zPosition = 4
        cs.position = CGPoint(x: self.frame.minX+cs.width/2, y: self.frame.midY)
        //dont actually add, just use for back button spacing// self.addChild(cs)
        
        backButton.position = CGPoint(x: self.frame.minX+cs.width/2, y: self.frame.midY+(self.frame.height/2)-(self.frame.height/16))
        backButton.zRotation = CGFloat(-1*(Double.pi/2))
        //self.addChild(back) //don't want a back button

        settingsButton.position = CGPoint(x: self.frame.minX+cs.width/2, y: self.frame.midY-(self.frame.height/2)+(self.frame.height/16))
        settingsButton.zRotation = CGFloat(-1*(Double.pi/2))
        self.addChild(settingsButton)
        
        
        let menuFrame = SKSpriteNode(imageNamed: "menuframe")
        menuFrame.size = CGSize(width: self.frame.height, height: self.frame.width)
        menuFrame.zRotation = CGFloat(-1*(Double.pi/2))
        menuFrame.zPosition = 3
        menuFrame.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(menuFrame)
        

    }

    func setUpMenus(){
        
        
        level0Menu.size = self.size
        level0Menu.initializeMenu(NumberOfLevels: (Standards.levelCountPerPackage[0] ?? 0), Restricted: true, MenuNumber: 0)
        level0Menu.scaleMode = .fill
        
        //TODO: factor out to standards file
        level1Menu.size = self.size
        level1Menu.initializeMenu(NumberOfLevels: (Standards.levelCountPerPackage[1] ?? 0), Restricted: true, MenuNumber: 1)
        level1Menu.scaleMode = .fill
        
        
    }
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: self.view!)
        
        if menuClicked.getLevel() != -1{
            menuClicked.removeFromParent()
            let newThumbnail = levelThumbnail()
            newThumbnail.setUp(level: menuClicked.getLevel(), width: Double(self.frame.height), height: Double(self.frame.width)/4)
            newThumbnail.position = menuClicked.position
            newThumbnail.zRotation = -1 * CGFloat(Double.pi/2)
            self.addChild(newThumbnail)
            if menuClicked.getLevel() == 0{
                level0Button = newThumbnail
            }else if menuClicked.getLevel() == 1{
                level1Button = newThumbnail
            }else if menuClicked.getLevel() == 2{
                level2Button = newThumbnail
            }else if menuClicked.getLevel() == 3{
                level3Button = newThumbnail
            }
            
        }
        
    }

    
    private func update(){
        
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

                if let view = self.view as SKView? {
                    playClickSound()
                    level0Menu.previousScene = self
                    menuClicked = level0Button
                    view.presentScene(level0Menu)
                }

            }else if node == level1Button {

                if let view = self.view as SKView? {
                    playClickSound()
                    level1Menu.previousScene = self
                    menuClicked = level1Button
                    view.presentScene(level1Menu)
                }

            }else if node == level2Button {

                //disabled

            }else if node == level3Button {

                //disabled

            }else{


            }
        }
    }



    private func playClickSound(){
        
        if Standards.soundFXON {
            run(SKAction.playSoundFileNamed("secondaryClick.m4a", waitForCompletion: true))
        }
    }
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

    
    

}
