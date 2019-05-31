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
    
//    var leftMenuBlocker = SKSpriteNode()
//    var middleMenuBlocker = SKSpriteNode()
//    var rightMenuBlocker = SKSpriteNode()
    
    
    var redLayers : [SKSpriteNode] = []
    var greenLayers : [SKSpriteNode] = []
    var blueLayers : [SKSpriteNode] = []
    
    
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
        
        
        for i in 1...numberOfLevels {
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
            levels.first?.locked = false
            
//            leftMenuBlocker.alpha = 1
//            middleMenuBlocker.alpha = 1
//            rightMenuBlocker.alpha = 1
            
            redLayers[0] = SKSpriteNode(imageNamed: "ls-r-\(menuNumber)-\(1)-U")
            redLayers[0].name = "ls-r-\(menuNumber)-\(1)-U"
            redLayers[0].physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: redLayers[0].name!), alphaThreshold: 0, size: redLayers[0].size)
            
            greenLayers[0] = SKSpriteNode(imageNamed: "ls-g-\(menuNumber)-\(1)-U")
            greenLayers[0].name = "ls-g-\(menuNumber)-\(1)-U"
            greenLayers[0].physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: greenLayers[0].name!), alphaThreshold: 0, size: greenLayers[0].size)
            
            blueLayers[0] = SKSpriteNode(imageNamed: "ls-b-\(menuNumber)-\(1)-U")
            blueLayers[0].name = "ls-b-\(menuNumber)-\(1)-U"
            blueLayers[0].physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: blueLayers[0].name!), alphaThreshold: 0, size: blueLayers[0].size)
        }else{
//            leftMenuBlocker.alpha = 1
//            middleMenuBlocker.alpha = 0
//            rightMenuBlocker.alpha = 0
        }
        
        currentLevelNumber = 0
        currentLevel = levels[0]
        
    }
    
    func unlockNextLevel(){
        
        if currentLevelNumber != levels.count-1 {
            
            levels[currentLevelNumber+1].locked = false
            
            if (currentLevelNumber % 2) != 0 {
                //unlock right
                //rightMenuBlocker.alpha = 0
            }else{
                //unlock middle
                //middleMenuBlocker.alpha = 0
            }
            
        }else{
            //last level in menu
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
        
        if currentLevelNumber == levels.count-1 {
            //dont move
        }else{
            if levels[currentLevelNumber+1].locked {
                //dont move
            }else{
                if (currentLevelNumber % 2) != 0 {
                    //even
                    //move to next page
                    for _ in 1...2{
                        for number in numbers {
                            //number.position = CGPoint(x: number.position.x, y: number.position.y+(self.frame.height/2))
                            number.run(SKAction.moveBy(x: 0, y: (self.frame.height/2), duration: 0.75))
                        }
                    }
                
                    //update menu blockers
                    //leftMenuBlocker.alpha = 0
                    
                    //middleMenuBlocker.alpha = 1
                    //rightMenuBlocker.alpha = 1
                    if !levels[currentLevelNumber+2].locked {
                        //middleMenuBlocker.alpha = 0
                    }
                    if currentLevelNumber+3 >= levels.count-1 {
                        //keep right on
                    }else{
                        //bug crash
                        if !levels[currentLevelNumber+3].locked {
                            //rightMenuBlocker.alpha = 0
                        }
                    }
                    
                }else{
                    //just move ball over
                }
                currentLevelNumber += 1
                currentLevel = levels[currentLevelNumber]
                
                
            }
        }
    }
    
    func previousLevel(){
        if currentLevelNumber == 0 {
            
        }else{
            if (currentLevelNumber % 2) != 0 {
                //just move ball back one
            }else{
                //go back a page
                for _ in 1...2{
                    for number in numbers {
                        number.run(SKAction.moveBy(x: 0, y: -(self.frame.height/2), duration: 0.75))
                    }
                }
                //leftMenuBlocker.alpha = 0
                //middleMenuBlocker.alpha = 0
                //rightMenuBlocker.alpha = 0
                
                if currentLevelNumber-2 == 0 {
                    //going to first page
                    //leftMenuBlocker.alpha = 1
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
