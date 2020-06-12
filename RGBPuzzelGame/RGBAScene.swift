//
//  RGBAScene.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 8/11/19.
//  Copyright © 2019 Samuel Hoffmann. All rights reserved.
//

import Foundation
import SpriteKit

enum SceneType {
    case Level
    case MainMenu
    case LevelSelect
    case Settings
    case none
}

class RGBAScene: SKScene {
    
    var type = SceneType.none
    
    var redLayer = SKSpriteNode()
    var greenLayer = SKSpriteNode()
    var blueLayer = SKSpriteNode()
    
    let cs = colorSwitch()
    
    var redButton = SKShapeNode()
    var greenButton = SKShapeNode()
    var blueButton = SKShapeNode()
    
    var backgroundScene = SKScene()
    
    
    
    // categories for physics:
    let playerCat: UInt32 = 0x1 << 1
    //let endCat: UInt32 = 0x1 << 2
    //let colliiderCat: UInt32 = 0x1 << 3 //all collision layers
    let redCat : UInt32 = 0x1 << 4
    let blueCat : UInt32 = 0x1 << 5
    let greenCat : UInt32 = 0x1 << 6
    //let wallCat : UInt32 = 0x1 << 7
    //let bottomCat : UInt32 = 0x1 << 8
    
    
    public func setUp(redLayerStr: String, greenLayerStr: String, blueLayerStr: String, physics: Bool){
        //currently used level code
        
        self.backgroundColor = UIColor.white
        
        self.redLayer = SKSpriteNode(imageNamed: redLayerStr)
        self.redLayer.name = redLayerStr
        
        self.greenLayer = SKSpriteNode(imageNamed: greenLayerStr)
        self.greenLayer.name = greenLayerStr
        
        self.blueLayer = SKSpriteNode(imageNamed: blueLayerStr)
        self.blueLayer.name = blueLayerStr
        
        setUpLayers(physics: physics)
        setUpButtons()
    }
    
    
    
    internal func setUpLayers(physics: Bool){
        
        //can make more robust for future sized phones
        var size = CGSize(width: self.frame.height, height: self.frame.width)
        
        if self.size.width == 375 {
            size = CGSize(width: 667, height: 375) //x xr
        }else if self.size.width == 414 {
            size = CGSize(width: 736, height: 414) //xs max
        }else{
            //properly images scaleable
        }
        
        redLayer.size = size
        greenLayer.size = size
        blueLayer.size = size
        
        
        if(physics){
            //RED//
            redLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: redLayer.name!), alphaThreshold: 0, size: redLayer.size)
            
            redLayer.physicsBody?.affectedByGravity = false
            redLayer.physicsBody?.allowsRotation = false
            redLayer.physicsBody?.isDynamic = false
            redLayer.physicsBody?.pinned = false
            
            redLayer.physicsBody?.friction = 0.2
            redLayer.physicsBody?.restitution = 0.2
            redLayer.physicsBody?.angularDamping = 0.1
            redLayer.physicsBody?.linearDamping = 0.1
            
            redLayer.physicsBody?.categoryBitMask = redCat
            redLayer.physicsBody?.collisionBitMask = playerCat
            redLayer.physicsBody?.contactTestBitMask = playerCat
            
            
            
            //GREEN//
            greenLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: greenLayer.name!), alphaThreshold: 0, size: greenLayer.size)
            
            greenLayer.physicsBody?.affectedByGravity = false
            greenLayer.physicsBody?.allowsRotation = false
            greenLayer.physicsBody?.isDynamic = false
            greenLayer.physicsBody?.pinned = false
            
            greenLayer.physicsBody?.friction = 0.2
            greenLayer.physicsBody?.restitution = 0.2
            greenLayer.physicsBody?.angularDamping = 0.1
            greenLayer.physicsBody?.linearDamping = 0.1
            
            greenLayer.physicsBody?.categoryBitMask = greenCat
            greenLayer.physicsBody?.collisionBitMask = playerCat
            greenLayer.physicsBody?.contactTestBitMask = playerCat
            
            
            
            //BLUE//
            blueLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: blueLayer.name!), alphaThreshold: 0, size: blueLayer.size)
            
            blueLayer.physicsBody?.affectedByGravity = false
            blueLayer.physicsBody?.allowsRotation = false
            blueLayer.physicsBody?.isDynamic = false
            blueLayer.physicsBody?.pinned = false
            
            blueLayer.physicsBody?.friction = 0.2
            blueLayer.physicsBody?.restitution = 0.2
            blueLayer.physicsBody?.angularDamping = 0.1
            blueLayer.physicsBody?.linearDamping = 0.1
            
            blueLayer.physicsBody?.categoryBitMask = blueCat
            blueLayer.physicsBody?.collisionBitMask = playerCat
            blueLayer.physicsBody?.contactTestBitMask = playerCat
        }
        
        redLayer.name = "redLayer"
        greenLayer.name = "greenLayer"
        blueLayer.name = "blueLayer"
        
        redLayer.zPosition = 1.1
        greenLayer.zPosition = 1.2
        blueLayer.zPosition = 1.3
        
        redLayer.zRotation = CGFloat(-Double.pi/2)
        redLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        redLayer.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        greenLayer.zRotation = CGFloat(-Double.pi/2)
        greenLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        greenLayer.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        blueLayer.zRotation = CGFloat(-Double.pi/2)
        blueLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        blueLayer.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        redLayer.alpha = 0.333
        greenLayer.alpha = 0.333
        blueLayer.alpha = 0.333
        
        self.addChild(redLayer)
        self.addChild(greenLayer)
        self.addChild(blueLayer)
        
    }
    
    internal func setUpButtons(){
        
        cs.setScale(0.35)
        cs.zPosition = 4
        cs.position = CGPoint(x: self.frame.minX+cs.width/2, y: self.frame.midY)
        self.addChild(cs)
        
        redButton = SKShapeNode(rectOf: CGSize(width: (cs.width), height: (cs.height/3)/3)) //note: (cs.width/3) is the actual size but (cs.width) gives space for users to tap the buttons without frustration
        redButton.fillColor = UIColor(red: 255/255, green: 154/255, blue: 154/255, alpha: 0.001)
        redButton.position = CGPoint(x: cs.position.x, y: cs.position.y+redButton.frame.height)
        redButton.strokeColor = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 0.001)
        redButton.zPosition = 5
        self.addChild(redButton)
        
        
        greenButton = SKShapeNode(rectOf: CGSize(width: (cs.width), height: (cs.height/3)/3))
        greenButton.fillColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.001)
        greenButton.position = CGPoint(x: cs.position.x, y: cs.position.y)
        greenButton.strokeColor = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 0.001)
        greenButton.zPosition = 5
        self.addChild(greenButton)
        
        
        blueButton = SKShapeNode(rectOf: CGSize(width: (cs.width), height: (cs.height/3)/3))
        blueButton.fillColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.001)
        blueButton.position = CGPoint(x: cs.position.x, y: cs.position.y-redButton.frame.height)
        blueButton.strokeColor = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 0.001)
        blueButton.zPosition = 5
        self.addChild(blueButton)
        
        
    }
    
    
    
    internal func resetLevel(){
        
        cs.reset()
        
        if redLayer.parent == nil {
            toggleLayer(layer: redLayer)
        }
        if greenLayer.parent == nil {
            toggleLayer(layer: greenLayer)
        }
        if blueLayer.parent == nil {
            toggleLayer(layer: blueLayer)
        }
    }
    
    override func didMove(to view: SKView) {
        resetLevel()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for node in nodes(at: (touches.first?.location(in: self))!) {
            
            if node == redButton {
                
                playSwitchSound()
                cs.flipColor(color: COLOR.RED)
                self.run(SKAction.wait(forDuration: 0.025))
                toggleLayer(layer: redLayer)
                
            }else if node == blueButton {
                
                playSwitchSound()
                cs.flipColor(color: COLOR.BLUE)
                self.run(SKAction.wait(forDuration: 0.025))
                toggleLayer(layer: blueLayer)
                
                
            }else if node == greenButton {
                
                playSwitchSound()
                cs.flipColor(color: COLOR.GREEN)
                self.run(SKAction.wait(forDuration: 0.025))
                toggleLayer(layer: greenLayer)
                
            }else{
                if Standards.editmode{
                    //debug
                    print("Debug: Touch location: \((touches.first?.location(in: self))!)")
                }
            }
        }
    }
    
    
    private func playSwitchSound(){
        if Standards.soundFXON {
            run(SKAction.playSoundFileNamed("switch.mp3", waitForCompletion: false))
        }
    }
    
    private func playSquishedSound(){
        if Standards.soundFXON {
            run(SKAction.playSoundFileNamed("squished.mp3", waitForCompletion: false))
        }
    }
    
    
    internal func toggleLayer(layer: SKSpriteNode){
        if layer.parent != nil {
            layer.removeFromParent()
        }else{
            self.addChild(layer)
        }
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
