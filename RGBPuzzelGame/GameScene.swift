//
//  GameScene.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 5/24/18.
//  Copyright © 2018 Samuel Hoffmann. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    let manager = CMMotionManager()
    
    var redLayer = SKSpriteNode()
    var greenLayer = SKSpriteNode()
    var blueLayer = SKSpriteNode()
    
    var player = SKSpriteNode()
    
    var redButton = SKSpriteNode()
    var greenButton = SKSpriteNode()
    var blueButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        redLayer = self.childNode(withName: "red") as! SKSpriteNode
        greenLayer = self.childNode(withName: "green") as! SKSpriteNode
        blueLayer = self.childNode(withName: "blue") as! SKSpriteNode
        
        redLayer.zPosition = 1.1
        greenLayer.zPosition = 1.2
        blueLayer.zPosition = 1.3
        
        

        
        
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        
        player.zPosition = 1
        
        redButton = self.childNode(withName: "redB") as! SKSpriteNode
        greenButton = self.childNode(withName: "greenB") as! SKSpriteNode
        blueButton = self.childNode(withName: "blueB")  as! SKSpriteNode
        
        redButton.zPosition = 2
        greenButton.zPosition = 2
        blueButton.zPosition = 2
        
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx: CGFloat(-5), dy: CGFloat((data?.acceleration.y)! * 10))
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for node in nodes(at: (touches.first?.location(in: self))!) {
            if node == redButton {
                if redLayer.parent != nil {
                    redLayer.removeFromParent()
                }else{
                    self.addChild(redLayer)
                }
            }else if node == blueButton {
                if blueLayer.parent != nil {
                    blueLayer.removeFromParent()
                }else{
                    self.addChild(blueLayer)
                }
            }else if node == greenButton {
                if greenLayer.parent != nil {
                    greenLayer.removeFromParent()
                }else{
                    self.addChild(greenLayer)
                }
            }else{
                
            }
        }
        
    }
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
