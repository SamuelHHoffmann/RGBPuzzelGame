//
//  settings.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 8/7/19.
//  Copyright © 2019 Samuel Hoffmann. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit




class Settings: RGBAScene {

    var previousScene = SKScene()
    var previousSceneType = SceneType.none
    
    var back = backButton()
    var fxButton = SettingsButton(name: "Sound FX", initState: .ON)
    var musicButton = SettingsButton(name: "Music", initState: .ON)
    
    
    func setUpSettings(){
        super.setUp(redLayerStr: "settingsRed", greenLayerStr: "settingsGreen", blueLayerStr: "settingsBlue", physics: false)
        
        self.type = SceneType.Settings
        
        setUpSettingsButtons()
    }
    
    private func setUpSettingsButtons(){
        
        back.position = CGPoint(x: self.frame.minX+cs.width/2, y: self.frame.midY+(self.frame.height/2)-(self.frame.height/16))
        back.zRotation = CGFloat(-1*(Double.pi/2))
        self.addChild(back)
        
        let fxState = Standards.soundFXON
        if fxState == false{fxButton.turnOff()}
        self.fxButton.zPosition = 3
        self.fxButton.setScale(0.35)
        self.fxButton.zRotation = CGFloat(-1*(Double.pi/2))
        self.fxButton.position = CGPoint(x: self.frame.midX - (self.frame.maxX/4), y: self.frame.midY + (self.frame.maxY/4))
        self.addChild(self.fxButton)
        
        let musicState = Standards.musicOn
        if musicState == false{musicButton.turnOff()}
        self.musicButton.zPosition = 3
        self.musicButton.setScale(0.35)
        self.musicButton.zRotation = CGFloat(-1*(Double.pi/2))
        self.musicButton.position = CGPoint(x: self.frame.midX - (self.frame.maxX/4), y: self.frame.midY - (self.frame.maxY/4))
        self.addChild(self.musicButton)
        
    }
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: self.view!)
        self.previousScene.isPaused = true
    }
    
    
    func goBack(){
        //go back to previous scene
        var scene = SKScene()
        
        if(previousSceneType == .Level){
            scene = previousScene as! Level
        }else if(previousSceneType == .LevelSelect){
            scene = previousScene as! LevelMenu
        }else if(previousSceneType == .MainMenu){
            scene = previousScene as! welcomeMenu
        }else{
            //type is none or settings
            print("Fatal Error Detection: Trying to transition Settings -> Settings or Settings -> none")
            return
        }
        
        if let view = self.view as SKView? {
            scene.isPaused = false
            view.presentScene(scene)
        }
        
    }

    func toggleMusic(){
        let state = self.musicButton.flip()
        if state == .ON {
            Standards.musicOn = true
            if Standards.backgroundSKScene.action(forKey: "music") == nil{
                Standards.backgroundSKScene.run(SKAction.repeatForever(SKAction.playSoundFileNamed(Standards.music[Int.random(in: 0...Standards.music.count-1)], waitForCompletion: true)), withKey: "music")
            }
            
//            Standards.backgroundSKScene.run(SKAction.repeatForever(SKAction.run {
//                if Standards.backgroundSKScene.action(forKey: "music") == nil && Standards.musicOn{
//                    Standards.backgroundSKScene.run(SKAction.playSoundFileNamed(Standards.music[Int.random(in: 0...Standards.music.count-1)], waitForCompletion: false), withKey: "music")
//                }
//            }))
        }else{
            Standards.backgroundSKScene.removeAction(forKey: "music")
            Standards.musicOn = false
        }
    }
    
    func toggleFX(){
        let state = self.fxButton.flip()
        if state == .ON {
            Standards.soundFXON = true
        }else{
            Standards.soundFXON = false
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for node in nodes(at: (touches.first?.location(in: self))!) {
            
            if node == self.back {
                
                goBack()
                
            }else if node == self.fxButton {
                
                toggleFX()
                
            }else if node == self.musicButton {
                
                toggleMusic()
                
            }else{
            
            
            }
        }
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    

}
