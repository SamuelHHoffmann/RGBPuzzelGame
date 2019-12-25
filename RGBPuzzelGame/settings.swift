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
    
    
    func setUpSettings(){
        super.setUp(redLayerStr: "settingsRed", greenLayerStr: "settingsGreen", blueLayerStr: "settingsBlue", physics: false)
        
        self.type = SceneType.Settings
        
        setUpSettingsButtons()
    }
    
    private func setUpSettingsButtons(){
        
        back.position = CGPoint(x: self.frame.minX+cs.width/2, y: self.frame.midY+(self.frame.height/2)-(self.frame.height/16))
        back.zRotation = CGFloat(-1*(Double.pi/2))
        self.addChild(back)
        
        
    }
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: self.view!)
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

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for node in nodes(at: (touches.first?.location(in: self))!) {
            
            if node == back {
                
                goBack()
                
            }else{
            
            
            }
        }
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    

}
