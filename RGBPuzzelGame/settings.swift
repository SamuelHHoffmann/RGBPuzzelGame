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
        
        let fxState = UserDefaults.standard.bool(forKey: "Saved_Data_Record:SoundFX")
        if fxState == true{fxButton.turnOff()}
        self.fxButton.zPosition = 3
        self.fxButton.setScale(0.35)
        self.fxButton.zRotation = CGFloat(-1*(Double.pi/2))
        self.fxButton.position = CGPoint(x: self.frame.midX - (self.frame.maxX/4), y: self.frame.midY + (self.frame.maxY/4))
        self.addChild(self.fxButton)
        
        let musicState = UserDefaults.standard.bool(forKey: "Saved_Data_Record:Music")
        if musicState == true{musicButton.turnOff()}
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
        if state == .ON { }
        
    }
    
    func toggleFX(){
        
        let state = self.fxButton.flip()
        
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
