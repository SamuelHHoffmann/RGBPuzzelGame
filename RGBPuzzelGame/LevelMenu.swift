//
//  LevelMenu.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 6/20/18.
//  Copyright © 2018 Samuel Hoffmann. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class LevelMenu: SKScene {
    
    var menuSkin = SKSpriteNode()
    
    var numberOfLevels = 0
    
    var menuNumber = -1
    
    var restricted = false
    
    var levels : [Level] = []
    
    var currentLevel = Level()
    var currentLevelNumber = 0
    
    var numbers : [SKNode] = [] //useless (but use positioning for layers)
    
    
    var redLayers : [SKSpriteNode] = []
    var greenLayers : [SKSpriteNode] = []
    var blueLayers : [SKSpriteNode] = []
    
    
    private var playerLeft = true
    
    
    func initializeMenu(NumberOfLevels: Int, Restricted: Bool, MenuNumber: Int){
        
        
        
        
        menuNumber = MenuNumber
        restricted = Restricted
        numberOfLevels = NumberOfLevels
        
        setUpMenuGraphics()
        setUpLevelMenu()
    }
    
    func setUpMenuGraphics(){
        
        self.backgroundColor = UIColor.white
        
        setUpLayers()
        setUpSecondaryGraphics()
        
        //set up menu buttons
    }
    
    func setUpSecondaryGraphics(){
        //set up background
//
//        rightMenuBlocker = SKSpriteNode(imageNamed: "rightMenuBlocker")
//        rightMenuBlocker.size = CGSize(width: self.frame.height, height: self.frame.width)
//        rightMenuBlocker.zRotation = CGFloat(-Double.pi/2)
//        rightMenuBlocker.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        rightMenuBlocker.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
//        rightMenuBlocker.zPosition = 2
//        self.addChild(rightMenuBlocker)
        
        
        
        
    }
    
    func setUpLayers(){
        //set up numbers
        
        
        for i in 1...(numberOfLevels) {
            //red layer
            let tempRed = SKSpriteNode(imageNamed: "ls-r-\(menuNumber)-\(i)-L")
            tempRed.name = "ls-r-\(menuNumber)-\(i)-L"
            tempRed.size = CGSize(width: self.frame.height/2, height: self.frame.width)
            tempRed.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            tempRed.zRotation = CGFloat(-Double.pi/2)
            tempRed.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: tempRed.name!), alphaThreshold: 0, size: tempRed.size)
            
            tempRed.physicsBody?.affectedByGravity = false
            tempRed.physicsBody?.allowsRotation = false
            tempRed.physicsBody?.isDynamic = false
            tempRed.physicsBody?.pinned = false

            tempRed.physicsBody?.friction = 0.2
            tempRed.physicsBody?.restitution = 0.2
            tempRed.physicsBody?.angularDamping = 0.1
            tempRed.physicsBody?.linearDamping = 0.1

            tempRed.physicsBody?.categoryBitMask = UInt32(1)
            tempRed.physicsBody?.collisionBitMask = UInt32(1)
            tempRed.physicsBody?.fieldBitMask = UInt32(1)
            tempRed.physicsBody?.contactTestBitMask = UInt32(1)
            
            tempRed.zPosition = 1.1
            tempRed.alpha = 0.333
            self.addChild(tempRed)
            redLayers.append(tempRed)
            
            for r in redLayers {
                r.position = CGPoint(x: r.position.x, y: r.position.y+(self.frame.height/2))
            }
            
            //green layer
            let tempGreen = SKSpriteNode(imageNamed: "ls-g-\(menuNumber)-\(i)-L")
            tempGreen.name = "ls-g-\(menuNumber)-\(i)-L"
            tempGreen.size = CGSize(width: self.frame.height/2, height: self.frame.width)
            tempGreen.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            tempGreen.zRotation = CGFloat(-Double.pi/2)
            tempGreen.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: tempGreen.name!), alphaThreshold: 0, size: tempGreen.size)
            
            tempGreen.physicsBody?.affectedByGravity = false
            tempGreen.physicsBody?.allowsRotation = false
            tempGreen.physicsBody?.isDynamic = false
            tempGreen.physicsBody?.pinned = false
            
            tempGreen.physicsBody?.friction = 0.2
            tempGreen.physicsBody?.restitution = 0.2
            tempGreen.physicsBody?.angularDamping = 0.1
            tempGreen.physicsBody?.linearDamping = 0.1
            
            tempGreen.physicsBody?.categoryBitMask = UInt32(1)
            tempGreen.physicsBody?.collisionBitMask = UInt32(1)
            tempGreen.physicsBody?.fieldBitMask = UInt32(1)
            tempGreen.physicsBody?.contactTestBitMask = UInt32(1)
            
            tempGreen.zPosition = 1.2
            tempGreen.alpha = 0.333
            self.addChild(tempGreen)
            greenLayers.append(tempGreen)
            
            for g in greenLayers {
                g.position = CGPoint(x: g.position.x, y: g.position.y+(self.frame.height/2))
            }
            
            //blue layer
            let tempBlue = SKSpriteNode(imageNamed: "ls-b-\(menuNumber)-\(i)-L")
            tempBlue.name = "ls-b-\(menuNumber)-\(i)-L"
            tempBlue.size = CGSize(width: self.frame.height/2, height: self.frame.width)
            tempBlue.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            tempBlue.zRotation = CGFloat(-Double.pi/2)
            tempBlue.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: tempBlue.name!), alphaThreshold: 0, size: tempBlue.size)
            
            tempBlue.physicsBody?.affectedByGravity = false
            tempBlue.physicsBody?.allowsRotation = false
            tempBlue.physicsBody?.isDynamic = false
            tempBlue.physicsBody?.pinned = false
            
            tempBlue.physicsBody?.friction = 0.2
            tempBlue.physicsBody?.restitution = 0.2
            tempBlue.physicsBody?.angularDamping = 0.1
            tempBlue.physicsBody?.linearDamping = 0.1
            
            tempBlue.physicsBody?.categoryBitMask = UInt32(1)
            tempBlue.physicsBody?.collisionBitMask = UInt32(1)
            tempBlue.physicsBody?.fieldBitMask = UInt32(1)
            tempBlue.physicsBody?.contactTestBitMask = UInt32(1)
            
            tempBlue.zPosition = 1.3
            tempBlue.alpha = 0.333
            self.addChild(tempBlue)
            blueLayers.append(tempBlue)
            
            for b in blueLayers {
                b.position = CGPoint(x: b.position.x, y: b.position.y+(self.frame.height/2))
            }
            
        }
        //slight ajust
        for r in redLayers {
            r.position = CGPoint(x: r.position.x, y: r.position.y-(self.frame.height/4))
        }
        for g in greenLayers {
            g.position = CGPoint(x: g.position.x, y: g.position.y-(self.frame.height/4))
        }
        for b in blueLayers {
            b.position = CGPoint(x: b.position.x, y: b.position.y-(self.frame.height/4))
        }
        
        //move layers back to 1st
        for _ in 1...redLayers.count-1 {
            for r in redLayers {
                r.position = CGPoint(x: r.position.x, y: r.position.y-(self.frame.height/2))
            }
            for b in blueLayers {
                b.position = CGPoint(x: b.position.x, y: b.position.y-(self.frame.height/2))
            }
            for g in greenLayers {
                g.position = CGPoint(x: g.position.x, y: g.position.y-(self.frame.height/2))
            }
        }
        
    }
    
    func setUpLevelMenu(){
        for i in 1...numberOfLevels {
            //git test
            let TempLevel = Level()
            
            //FutureTodo: optimize menu so that only next level is initalized so it doesn't take up memory
            TempLevel.size = self.size
            TempLevel.setUp(package: menuNumber, numberInPackage: i, locked: restricted, menu: self)
            TempLevel.name = "Package \(menuNumber), Level \(i)"
            TempLevel.scaleMode = .fill
            
            levels.append(TempLevel)
            
        }
        
        if restricted {
            //unlock levels
            
            //if first time
                //unlock first level
            //else
                //unlock levels from memory
            
            currentLevelNumber = 0
            currentLevel = levels[0]
            unlockLevel(levelNumber: currentLevelNumber)
            
        }else{
            //unlock all levels
            
            currentLevelNumber = 0
            currentLevel = levels[0]
            for x in 0...numberOfLevels-2{
                unlockNext(levelNumber: x)
            }
            unlockLevel(levelNumber: numberOfLevels-1)
            
            
        }
        

        
    }
    
    func unlockNextLevel(){
        
        if currentLevelNumber < levels.count {
            
            unlockNext(levelNumber: currentLevelNumber)
            unlockLevel(levelNumber: currentLevelNumber+1)
            
        }else{
            //last level in menu
        }
    }
    
    //unlocks level number in levels list
    private func unlockLevel(levelNumber: Int){
        if levelNumber < levels.count {
            
            levels[levelNumber].locked = false
            redLayers[levelNumber].texture = SKTexture(imageNamed: "ls-r-\(menuNumber)-\(levelNumber+1)-U")
            redLayers[levelNumber].name = "ls-r-\(menuNumber)-\(levelNumber+1)-U"
            greenLayers[levelNumber].texture = SKTexture(imageNamed: "ls-g-\(menuNumber)-\(levelNumber+1)-U")
            greenLayers[levelNumber].name = "ls-g-\(menuNumber)-\(levelNumber+1)-U"
            blueLayers[levelNumber].texture = SKTexture(imageNamed: "ls-b-\(menuNumber)-\(levelNumber+1)-U")
            blueLayers[levelNumber].name = "ls-b-\(menuNumber)-\(levelNumber+1)-U"
            
        }else{
            //out of range
        }
    }
    
    //unlocks level number in levels list
    private func unlockNext(levelNumber: Int){
        if levelNumber < levels.count {
            
            redLayers[levelNumber].texture = SKTexture(imageNamed: "ls-r-\(menuNumber)-\(levelNumber+1)-N")
            redLayers[levelNumber].name = "ls-r-\(menuNumber)-\(levelNumber+1)-N"
            greenLayers[levelNumber].texture = SKTexture(imageNamed: "ls-g-\(menuNumber)-\(levelNumber+1)-N")
            greenLayers[levelNumber].name = "ls-g-\(menuNumber)-\(levelNumber+1)-N"
            blueLayers[levelNumber].texture = SKTexture(imageNamed: "ls-b-\(menuNumber)-\(levelNumber+1)-N")
            blueLayers[levelNumber].name = "ls-b-\(menuNumber)-\(levelNumber+1)-N"
            
        }else{
            //out of range
        }
    }
    
    
    
    override func didMove(to view: SKView) {
        
        
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.up
        self.view?.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.down
        self.view?.addGestureRecognizer(rightSwipe)
        
    }
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer){
        
        if swipe.direction == UISwipeGestureRecognizer.Direction.up {
            //move to next level
            nextLevel()
        }else if swipe.direction == UISwipeGestureRecognizer.Direction.down {
            //go back a level
            previousLevel()
        }else {
            //impossible
        }
    }
    
    func nextLevel(){
        
        
        if currentLevelNumber == levels.count-1 { // last level
            //dont move
        }else{
            if levels[currentLevelNumber+1].locked { //next level locked
                //dont move
            }else{
                if playerLeft == false { //aka player right
                    //even
                    //move to next page
                    var x = 0
                    for _ in redLayers {
                        redLayers[x].run(SKAction.moveBy(x: 0, y: (self.frame.height/2), duration: 0.35))
                        greenLayers[x].run(SKAction.moveBy(x: 0, y: (self.frame.height/2), duration: 0.35))
                        blueLayers[x].run(SKAction.moveBy(x: 0, y: (self.frame.height/2), duration: 0.35))
                        x = x + 1
                    }
                    
                }else{
                    //just move ball over
                    playerLeft = false
                }
                currentLevelNumber += 1
                currentLevel = levels[currentLevelNumber]
                
                
            }
        }
    }
    
    func previousLevel(){
        if currentLevelNumber == 0 {
            
        }else{
            if playerLeft == false { //aka player right
                //just move ball back one
                playerLeft = true
            }else{
                //go back a page
                var x = 0
                for _ in redLayers {
                    redLayers[x].run(SKAction.moveBy(x: 0, y: -(self.frame.height/2), duration: 0.35))
                    greenLayers[x].run(SKAction.moveBy(x: 0, y: -(self.frame.height/2), duration: 0.35))
                    blueLayers[x].run(SKAction.moveBy(x: 0, y: -(self.frame.height/2), duration: 0.35))
                    x = x + 1
                }
                
            }
            currentLevelNumber -= 1
            currentLevel = levels[currentLevelNumber]
            
            
        }
    }
    
    
    //use taps for menu
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let view = self.view as SKView? {
            view.presentScene(currentLevel)
        }
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
}
