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
    
    var backButton = SKShapeNode()
    var backButton_img = SKSpriteNode()
    
    
    func setUpSettings(){
        super.setUp(redLayerStr: "settingsRed", greenLayerStr: "settingsGreen", blueLayerStr: "settingsBlue", physics: false)
        
        self.type = SceneType.Settings
        
        setUpSettingsButtons()
    }
    
    private func setUpSettingsButtons(){
        
        backButton_img = SKSpriteNode(imageNamed: "back button")
        backButton_img.position = CGPoint(x: self.frame.minX+cs.width/2, y: self.frame.midY+(self.frame.height/2)-(self.frame.height/16))
        backButton_img.zPosition = 4
        backButton_img.zRotation = CGFloat(-1*(Double.pi/2))
        backButton_img.setScale(0.35)
        self.addChild(backButton_img)
        
        backButton = SKShapeNode(rectOf: CGSize(width: (backButton_img.frame.width)*2, height: (backButton_img.frame.height)*2))
        backButton.fillColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.001)
        backButton.position = backButton_img.position
        backButton.strokeColor = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.001)
        backButton.zPosition = 5
        self.addChild(backButton)
        
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
            
            if node == backButton {
                
                goBack()
                
            }else{
            
            
            }
        }
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    

}
