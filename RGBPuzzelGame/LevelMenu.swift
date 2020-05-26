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
    
    var previousScene = SKScene()
    
    var menuSkin = SKSpriteNode()
    
    var numberOfLevels = 0
    
    var menuNumber = -1
    
    var restricted = false
    
//    var levels : [Level] = []
    var lockedLevelData : [Int : Bool] = [:]
    
    var currentLevel = Level()
    var currentLevelNumber = 1
    
    var numbers : [SKNode] = [] //useless (but use positioning for layers)
    
    
    var redLayers : [SKSpriteNode] = []
    var greenLayers : [SKSpriteNode] = []
    var blueLayers : [SKSpriteNode] = []
    
    
    private var playerLeft = true
    
    
    var pointer = SKSpriteNode()
    
    var isTopScene = false
    
    var back = backButton()
    
    
    
    
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
        
        let cs = colorSwitch()
        cs.setScale(0.35)
        cs.position = CGPoint(x: self.frame.minX+cs.width/2, y: self.frame.midY)
        //dont actually add, just use for back button spacing// self.addChild(cs)
        
        back.position = CGPoint(x: self.frame.minX+cs.width/2, y: self.frame.midY+(self.frame.height/2)-(self.frame.height/16))
        back.zRotation = CGFloat(-1*(Double.pi/2))
        self.addChild(back)
    }
    
    func setUpSecondaryGraphics(){
        //set up background

        pointer = SKSpriteNode(imageNamed: "player")
        
        pointer.name = "pointer"
        pointer.size = CGSize(width: 50, height: 50)
        pointer.zPosition = 4
        pointer.position = CGPoint(x: redLayers[0].position.x+(redLayers[0].frame.width/4), y: redLayers[0].position.y)
        pointer.alpha = 1

        self.addChild(pointer)
        
        
        
    }
    
    func setUpLayers(){
        //set up numbers
        
        
        for i in 1...(numberOfLevels) {
            //red layer
            let tempRed = SKSpriteNode(imageNamed: "ls-r-1-\(i)-L") //* find "-1-" replace "-1-"
            tempRed.name = "ls-r-1-\(i)-L" //*
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
            let tempGreen = SKSpriteNode(imageNamed: "ls-g-1-\(i)-L") //*
            tempGreen.name = "ls-g-1-\(i)-L" //*
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
            let tempBlue = SKSpriteNode(imageNamed: "ls-b-1-\(i)-L") //*
            tempBlue.name = "ls-b-1-\(i)-L"//*
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
    
    /*
     So we've got an issue...
     Loading all the levels and all the graphics in the game at once is not possible.
     There is just not enought RAMs.
     We have to modify the code to smartly load graphics and elements so it can load less.
     Think about it this way: Once you beat a level you are less likely to play it so it
     doesn't make sense to load beginner packages once you're at the end.
     
     */
    func setUpLevelMenu(){
        for x in 1...numberOfLevels {
            //placeholder levels
            lockedLevelData[x] = false
//            levels.append(Level())
        }
        
        currentLevelNumber = 1
        
        //setup level 0 and 1
//        levels[currentLevelNumber] = setUpLevel(levelNum: currentLevelNumber+1)
//        if currentLevelNumber+1 < levels.count-1{
//            levels[currentLevelNumber+1] = setUpLevel(levelNum: currentLevelNumber+2)
//        }
        
        //load other levels
        
        if restricted {
            loadMenuFromData()
        }else{
            loadMenuUnrestricted()
        }
        
    }
    
    
    private func setUpLevel(levelNum: Int) -> Level{
     
        let lastUnlocked = UserDefaults.standard.integer(forKey: "Saved_Level_Record:Unlocked:\(menuNumber)")
        
        var tempRestrict = true
        
        if restricted{ //questionable
            if lastUnlocked >= levelNum{
                tempRestrict = false
            }
        }else{
            tempRestrict = false
        }
        
        let TempLevel = currentLevel
        
        //FutureTodo: optimize menu so that only next level is initalized so it doesn't take up memory
        TempLevel.size = self.size
        TempLevel.setUp(package: menuNumber, numberInPackage: levelNum, locked: tempRestrict, menu: self)
        TempLevel.name = "Package \(menuNumber), Level \(levelNum)"
        TempLevel.scaleMode = .fill
        return TempLevel
    }
    
    
    //unlock levels from memory
    func loadMenuFromData(){
        
        let lastUnlocked = UserDefaults.standard.integer(forKey: "Saved_Level_Record:Unlocked:\(menuNumber)")
        let lastLevel = UserDefaults.standard.integer(forKey: "Saved_Level_Record:Last:\(menuNumber)")
        
        print("Last Unlocked:", lastUnlocked)
        print("Last Level:", lastLevel)
        
        if(lastUnlocked >= numberOfLevels || lastUnlocked == 0){ //error lastunlocked value is too large, or first time load and is 0
            print("error lastunlocked value is too large")
            currentLevelNumber = 1
            UserDefaults.standard.set(currentLevelNumber, forKey: "Saved_Level_Record:Unlocked:\(menuNumber)")
            UserDefaults.standard.set(currentLevelNumber, forKey: "Saved_Level_Record:Last:\(menuNumber)")
            
            setUnlockedGraphics(levelNumber: currentLevelNumber)
            unlockLevel(levelNumber: currentLevelNumber)
            
//            currentLevel = levels[currentLevelNumber]
            
        }else{
            
            if lastUnlocked > 1{
                for tempLevel in 1...lastUnlocked-1{
                    setNextGraphics(levelNumber: tempLevel)
                }
            }
            setUnlockedGraphics(levelNumber: lastUnlocked)
            
            for tempLevel in 1...lastUnlocked{
                unlockLevel(levelNumber: tempLevel)
            }
            
            currentLevelNumber = 1
//            currentLevel = levels[0]
            
            if lastLevel <= lastUnlocked{
                //lastUnlocked and lastLevel valid good data
                print("unlocking extra levels")
                if lastLevel > 1{
                    for _ in 1...lastLevel{
                        nextLevel()
                    }
                }
            }
            
        }
        
    }
    
    //Loads the Menu if the resitrcted value is false meaning all the levels should be unlocked without requiring progression
    private func loadMenuUnrestricted(){
        
        for tempLevel in 1...lockedLevelData.count-1{
            setNextGraphics(levelNumber: tempLevel)
        }
        setUnlockedGraphics(levelNumber: lockedLevelData.count)
        
        for tempLevel in 1...lockedLevelData.count{
            unlockLevel(levelNumber: tempLevel)
        }
        
        currentLevelNumber = 1
//        currentLevel = levels[0]
        
    }
    
    
    public func unlockNextLevel(){
        
        if UserDefaults.standard.integer(forKey: "Saved_Level_Record:Completed:\(menuNumber)") < currentLevelNumber{
            UserDefaults.standard.set(currentLevelNumber, forKey: "Saved_Level_Record:Completed:\(menuNumber)")
            Standards.lastCompletedLocal = currentLevelNumber
        }
        
        setNextGraphics(levelNumber: currentLevelNumber)
        
        if lockedLevelData[currentLevelNumber+1] == false{ //dont update graphics if levels are already unlocked
            setUnlockedGraphics(levelNumber: currentLevelNumber+1)
        }
        
        unlockLevel(levelNumber: currentLevelNumber+1)
        
    }
    
    //unlocks level number in levels list
    private func setUnlockedGraphics(levelNumber: Int){
        if lockedLevelData[currentLevelNumber] != nil {
            
            redLayers[levelNumber-1].texture = SKTexture(imageNamed: "ls-r-1-\(levelNumber)-U") //*
            redLayers[levelNumber-1].name = "ls-r-1-\(levelNumber)-U" //*
            greenLayers[levelNumber-1].texture = SKTexture(imageNamed: "ls-g-1-\(levelNumber)-U") //*
            greenLayers[levelNumber-1].name = "ls-g-1-\(levelNumber)-U" //*
            blueLayers[levelNumber-1].texture = SKTexture(imageNamed: "ls-b-1-\(levelNumber)-U") //*
            blueLayers[levelNumber-1].name = "ls-b-1-\(levelNumber)-U" //*
            
        }else{
            //out of range
        }
    }
    
    //unlocks level number in levels list
    private func setNextGraphics(levelNumber: Int){
        if lockedLevelData[currentLevelNumber+1] != nil {
            
            redLayers[levelNumber-1].texture = SKTexture(imageNamed: "ls-r-1-\(levelNumber)-N") //*
            redLayers[levelNumber-1].name = "ls-r-1-\(levelNumber)-N" //*
            greenLayers[levelNumber-1].texture = SKTexture(imageNamed: "ls-g-1-\(levelNumber)-N") //*
            greenLayers[levelNumber-1].name = "ls-g-1-\(levelNumber)-N" //*
            blueLayers[levelNumber-1].texture = SKTexture(imageNamed: "ls-b-1-\(levelNumber)-N") //*
            blueLayers[levelNumber-1].name = "ls-b-1-\(levelNumber)-N" //*
            
        }else{
            //out of range
        }
    }
    
    //actually unlocks the level variable in the levels array.
    private func unlockLevel(levelNumber: Int){
        if lockedLevelData[levelNumber] != nil{
            lockedLevelData[levelNumber] = true
            
            if UserDefaults.standard.integer(forKey: "Saved_Level_Record:Unlocked:\(menuNumber)") < levelNumber{
                UserDefaults.standard.set(levelNumber, forKey: "Saved_Level_Record:Unlocked:\(menuNumber)")
            }
        }
    }
    
    
    
    override func didMove(to view: SKView) {
        //first responder for negating swipes
        isTopScene = true
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.up
        self.view?.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.down
        self.view?.addGestureRecognizer(rightSwipe)
        
        
        //load levels
        
        
    }
    
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer){
        if(isTopScene){
            //print("swipe")
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
    }
    
    func nextLevel(){
        if currentLevelNumber == lockedLevelData.count { // last level
            //dont move
            print("last level")
        }else{
            if lockedLevelData[currentLevelNumber+1] == false { //next level locked
                //dont move
                print("level locked")
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
                    pointer.run(SKAction.moveBy(x: 0, y: -(self.frame.height/2), duration: 0.35))
                    playerLeft = false
                }
                currentLevelNumber += 1
//                currentLevel = levels[currentLevelNumber]
                
                //update current level
                UserDefaults.standard.set(currentLevelNumber, forKey: "Saved_Level_Record:Last:\(menuNumber)")
                
                
//                DispatchQueue.global(qos: .userInteractive).async { //Removed for lockedLevelData update setup of levels will happen when tapped
//                    //setup next level
//                    if self.currentLevelNumber+1 < self.levels.count {
//                        if self.levels[self.currentLevelNumber+1].setup == false{
//                            self.levels[self.currentLevelNumber+1] = self.setUpLevel(levelNum: self.currentLevelNumber+2)
//                        }
//                    }
//                    //break down 2 back levels
//                    if self.currentLevelNumber-2 >= 0{
//                        let tempLevel = Level()
//                        tempLevel.locked = false
//                        self.levels[self.currentLevelNumber-2].removeFromParent()
//                        self.levels[self.currentLevelNumber-2] = tempLevel
//                    }
//                }
                
                
            }
        }
    }
    
    func previousLevel(){
        if currentLevelNumber == 1 { //last level
            print("first level")
        }else{
            if playerLeft == false { //aka player right
                //just move ball back one
                pointer.run(SKAction.moveBy(x: 0, y: (self.frame.height/2), duration: 0.35))
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
//            currentLevel = levels[currentLevelNumber]
            
            //update current level
            UserDefaults.standard.set(currentLevelNumber, forKey: "Saved_Level_Record:Last:\(menuNumber)")
            
            
//            DispatchQueue.global(qos: .userInteractive).async {
//                //set up previous level
//                if self.currentLevelNumber-1 >= 0{
//                    self.levels[self.currentLevelNumber-1] = self.setUpLevel(levelNum: self.currentLevelNumber)
//                }
//
//                //break down 2 next levels
//                if self.currentLevelNumber+2 < self.levels.count{
//                    let tempLevel = Level()
//                    tempLevel.locked = false
//                    self.levels[self.currentLevelNumber+2].removeFromParent()
//                    self.levels[self.currentLevelNumber+2] = tempLevel
//                }
//            }
            
            
        }
    }
    
    
    //use taps for menu
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for node in nodes(at: (touches.first?.location(in: self))!) {

            if node == back {

                
                let menuCasted = previousScene as! MenuMenu
                if let view = self.view as SKView? {
                    
                    menuCasted.size = self.size
                    view.presentScene(menuCasted)
                    
                }
                
            }
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTopScene = false
        
        currentLevel = self.setUpLevel(levelNum: self.currentLevelNumber)
        
        if let view = self.view as SKView? {
            view.presentScene(currentLevel)
        }
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
}
