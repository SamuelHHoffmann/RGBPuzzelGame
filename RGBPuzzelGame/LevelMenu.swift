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
    
    var numbers : [SKNode] = []
    
    var leftMenuBlocker = SKSpriteNode()
    
    var middleMenuBlocker = SKSpriteNode()
    
    var rightMenuBlocker = SKSpriteNode()
    
    
    func initializeMenu(NumberOfLevels: Int, Restricted: Bool, MenuNumber: Int){
        
        
        menuNumber = MenuNumber
        restricted = Restricted
        numberOfLevels = NumberOfLevels
        
        setUpMenuGraphics()
        setUpLevelMenu()
    }
    
    func setUpMenuGraphics(){
        
        self.backgroundColor = UIColor.white
        
        setUpNumbers()
        setUpSecondaryGraphics()
        
        //set up menu buttons
    }
    
    func setUpSecondaryGraphics(){
        //set up background
        do {
            try menuSkin = SKSpriteNode(imageNamed: "menu\(menuNumber)Background")
        } catch {
            menuSkin = SKSpriteNode(imageNamed: "DefaultmenuBackground")
        }
        menuSkin.size = CGSize(width: self.frame.height, height: self.frame.width)
        menuSkin.zRotation = CGFloat(-Double.pi/2)
        menuSkin.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        menuSkin.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        menuSkin.zPosition = 1
        self.addChild(menuSkin)
        
        //set up pointer and blocker graphics
        
        leftMenuBlocker = SKSpriteNode(imageNamed: "leftMenuBlocker")
        leftMenuBlocker.size = CGSize(width: self.frame.height, height: self.frame.width)
        leftMenuBlocker.zRotation = CGFloat(-Double.pi/2)
        leftMenuBlocker.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leftMenuBlocker.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        leftMenuBlocker.zPosition = 2
        self.addChild(leftMenuBlocker)
        
        middleMenuBlocker = SKSpriteNode(imageNamed: "middleMenuBlocker")
        middleMenuBlocker.size = CGSize(width: self.frame.height, height: self.frame.width)
        middleMenuBlocker.zRotation = CGFloat(-Double.pi/2)
        middleMenuBlocker.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        middleMenuBlocker.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        middleMenuBlocker.zPosition = 2
        self.addChild(middleMenuBlocker)
        
        
        rightMenuBlocker = SKSpriteNode(imageNamed: "rightMenuBlocker")
        rightMenuBlocker.size = CGSize(width: self.frame.height, height: self.frame.width)
        rightMenuBlocker.zRotation = CGFloat(-Double.pi/2)
        rightMenuBlocker.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rightMenuBlocker.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        rightMenuBlocker.zPosition = 2
        self.addChild(rightMenuBlocker)
        
    }
    
    func setUpNumbers(){
        //set up numbers
        
        var numbers : [SKNode] = []
        
        for i in 1...numberOfLevels {
            let bob = SKSpriteNode(imageNamed: "\(i)")
            bob.setScale(0.4)
            bob.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            bob.zRotation = CGFloat(-Double.pi/2)
            bob.zPosition = 2
            bob.alpha = 1
            self.addChild(bob)
            numbers.append(bob)
            
            for number in numbers {
                number.position = CGPoint(x: number.position.x, y: number.position.y+(self.frame.height/2))
            }
            
        }
        
        for number in numbers {
            number.position = CGPoint(x: number.position.x, y: number.position.y-(self.frame.height/4))
        }
        
        for _ in 1...numbers.count-1 {
            for number in numbers {
                number.position = CGPoint(x: number.position.x, y: number.position.y-(self.frame.height/2))
            }
        }
        
        self.numbers = numbers
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
            
            leftMenuBlocker.alpha = 1
            middleMenuBlocker.alpha = 1
            rightMenuBlocker.alpha = 1
        }else{
            leftMenuBlocker.alpha = 1
            middleMenuBlocker.alpha = 0
            rightMenuBlocker.alpha = 0
        }
        
        currentLevelNumber = 0
        currentLevel = levels[0]
        
    }
    
    func unlockNextLevel(){
        
        if currentLevelNumber != levels.count-1 {
            
            levels[currentLevelNumber+1].locked = false
            
            if (currentLevelNumber % 2) != 0 {
                //unlock right
                rightMenuBlocker.alpha = 0
            }else{
                //unlock middle
                middleMenuBlocker.alpha = 0
            }
            
        }else{
            //last level in menu
        }
        
        
        
    }
    
    
    
    override func didMove(to view: SKView) {
        
        
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.up
        self.view?.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.down
        self.view?.addGestureRecognizer(rightSwipe)
        
    }
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer){
        
        if swipe.direction == UISwipeGestureRecognizerDirection.up {
            //move to next level
            nextLevel()
        }else if swipe.direction == UISwipeGestureRecognizerDirection.down {
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
                    leftMenuBlocker.alpha = 0
                    
                    middleMenuBlocker.alpha = 1
                    rightMenuBlocker.alpha = 1
                    if !levels[currentLevelNumber+2].locked {
                        middleMenuBlocker.alpha = 0
                    }
                    if currentLevelNumber+3 >= levels.count-1 {
                        //keep right on
                    }else{
                        //bug crash
                        if !levels[currentLevelNumber+3].locked {
                            rightMenuBlocker.alpha = 0
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
                leftMenuBlocker.alpha = 0
                middleMenuBlocker.alpha = 0
                rightMenuBlocker.alpha = 0
                
                if currentLevelNumber-2 == 0 {
                    //going to first page
                    leftMenuBlocker.alpha = 1
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
