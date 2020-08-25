//
//  level.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 5/24/18.
//  Copyright © 2018 Samuel Hoffmann. All rights reserved.
//
import SpriteKit
import GameplayKit
import CoreMotion

class Level: SKScene, SKPhysicsContactDelegate {
    
    let manager = CMMotionManager()
    
    var redLayer = SKSpriteNode()
    var greenLayer = SKSpriteNode()
    var blueLayer = SKSpriteNode()
    
    let cs = colorSwitch()
    
    var player = SKSpriteNode()
    var end = SKSpriteNode()
    
    var redButton = SKShapeNode()
    var greenButton = SKShapeNode()
    var blueButton = SKShapeNode()
    var backButton = BackButton()
    var settingsButton = SettingsButton()
    
    var comingBackFromSettings = false
    var settingsScene = Settings()
    
    var packageNumber = 0
    var levelNumber = 0
    var startingPointOffset = CGPoint(x: 0, y: 0)
    var endingPointOffset = CGPoint(x: 0, y: 0)
    
    var locked = true
    var setup = false
    
    var menu : SKScene? = nil
    
    // categories:
    let playerCat: UInt32 = 0x1 << 1
    let endCat: UInt32 = 0x1 << 2
    let redCat : UInt32 = 0x1 << 4
    let blueCat : UInt32 = 0x1 << 5
    let greenCat : UInt32 = 0x1 << 6
    let wallCat : UInt32 = 0x1 << 7
    let bottomCat : UInt32 = 0x1 << 8
    
    override init() {
        super.init()
    }
    override init(size: CGSize) {
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUp(package: Int, numberInPackage: Int, locked: Bool, menu: LevelMenu?){
        //currently used level code
        
        self.packageNumber = package
        self.levelNumber = numberInPackage
        
        self.locked = locked
        
        if !self.setup {
            self.removeAllChildren()
        }else{
            return
        }
        
        if UIImage(named: "\(package),\(numberInPackage)Background") != nil{ //check if background art exists
            let background = SKSpriteNode(imageNamed: "\(package),\(numberInPackage)Background")
            background.zPosition = 0
            background.size = CGSize(width: self.frame.height, height: self.frame.width)
            background.zRotation = CGFloat(-Double.pi/2)
            background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            self.addChild(background)
        }
        
        self.redLayer = SKSpriteNode(imageNamed: "\(package),\(numberInPackage)R")
        self.redLayer.name = "\(package),\(numberInPackage)R"
        self.redLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "\(package),\(numberInPackage)R"), size:CGSize(width: self.redLayer.size.width, height: self.redLayer.size.height))
        
        self.greenLayer = SKSpriteNode(imageNamed: "\(package),\(numberInPackage)G")
        self.greenLayer.name = "\(package),\(numberInPackage)G"
        self.greenLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "\(package),\(numberInPackage)G"), size:CGSize(width: self.greenLayer.size.width, height: self.greenLayer.size.height))
        
        self.blueLayer = SKSpriteNode(imageNamed: "\(package),\(numberInPackage)B")
        self.blueLayer.name = "\(package),\(numberInPackage)B"
        self.blueLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "\(package),\(numberInPackage)B"), size:CGSize(width: self.blueLayer.size.width, height: self.blueLayer.size.height))
        
        self.menu = menu
        
        //with multiple packages will use lookup scheme. currently hardwired
        self.startingPointOffset = (Standards.startPositions["\(package),\(numberInPackage)"] ?? CGPoint(x: 300, y: -35))
        self.endingPointOffset = (Standards.endPositions["\(package),\(numberInPackage)"] ?? CGPoint(x: -290, y: -35))
        
        setUpLayers()
        setUpButtons()
        setUpStartAndEnd()
        miscSetUp()
        setup = true
    }
    
    /*
     sets up the R,G,and B layers with their physics body and alpha values.
     Also sets up the collsion layers for each color giving them a physics body and attributes.
     
    */
    func setUpLayers(){
        
        print(self.frame.width)
        print(self.frame.height)
        
        let size = CGSize(width: self.frame.width*667/375, height: self.frame.width)
        
        //scale start and end positions//
        var temp = CGPoint(x: startingPointOffset.x*size.width/667, y: startingPointOffset.y*size.height/375)
        startingPointOffset = CGPoint(x: temp.x, y: temp.y)
        temp = CGPoint(x: endingPointOffset.x*size.width/667, y: endingPointOffset.y*size.height/375)
        endingPointOffset = CGPoint(x: temp.x, y: temp.y)
        
        redLayer.size = size
        greenLayer.size = size
        blueLayer.size = size
        
        //red
        redLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: redLayer.name!), size: redLayer.size)
        redLayer.name = "redLayer"
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
        redLayer.zPosition = 1.1
        
        //green
        greenLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: greenLayer.name!), size: greenLayer.size)
        greenLayer.name = "greenLayer"
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
        greenLayer.zPosition = 1.2
        
        //blue
        blueLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: blueLayer.name!), size: blueLayer.size)
        blueLayer.name = "blueLayer"
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
    
    func setUpButtons(){
        
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
        
        
        backButton.position = CGPoint(x: self.frame.minX+cs.width/2, y: self.frame.midY+(self.frame.height/2)-(self.frame.height/16))
        backButton.zRotation = CGFloat(-1*(Double.pi/2))
        self.addChild(backButton)
        
        settingsButton.position = CGPoint(x: self.frame.minX+cs.width/2, y: self.frame.midY-(self.frame.height/2)+(self.frame.height/16))
        settingsButton.zRotation = CGFloat(-1*(Double.pi/2))
        self.addChild(settingsButton)
        
        settingsScene = Standards.settingsScene
        
    }
    
    func setUpStartAndEnd(){
        
        
        player = SKSpriteNode(imageNamed: "player")
        player.size = CGSize(width: 45, height: 45) //TODO: Scale issue

        
        player.physicsBody = SKPhysicsBody(circleOfRadius: 22.5)
        player.name = "player"

        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.allowsRotation = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.pinned = false

        player.physicsBody?.friction = 1
        player.physicsBody?.restitution = 0.05
        player.physicsBody?.angularDamping = 0.1
        player.physicsBody?.linearDamping = 0.1

        player.physicsBody?.categoryBitMask = playerCat
        player.physicsBody?.collisionBitMask = wallCat | redCat | blueCat | greenCat
        player.physicsBody?.contactTestBitMask = bottomCat | endCat

        
        player.zPosition = 4

        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        player.position = CGPoint(x: self.frame.midX + startingPointOffset.y, y: self.frame.midY + startingPointOffset.x)
        //player.position = CGPoint(x: 170, y: 607.49)
        
//        print(player.position)
        player.alpha = 1

        self.addChild(player)
        
        
        //set up end point
        end = SKSpriteNode(imageNamed: "end")
        end.size = CGSize(width: 45, height: 45)
        end.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        end.name = "end"
        end.physicsBody?.affectedByGravity = false
        end.physicsBody?.allowsRotation = false
        end.physicsBody?.isDynamic = false
        end.physicsBody?.pinned = false
        end.physicsBody?.categoryBitMask = endCat
        end.physicsBody?.contactTestBitMask = playerCat
        end.zPosition = 3
        end.zRotation = CGFloat(-1*(Double.pi/2))
        end.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        end.position = CGPoint(x: self.frame.midX + endingPointOffset.y, y: self.frame.midY + endingPointOffset.x) //***
        //end.position = CGPoint(x: self.frame.midX + startingPointOffset.y, y: self.frame.midY + startingPointOffset.x)
        end.alpha = 1
        
        self.addChild(end)
    }
    
    func miscSetUp(){
        //set up bounding walls
        
        let leftWall = SKSpriteNode()
        leftWall.size = CGSize(width: self.frame.width, height: 1)
        leftWall.color = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 1)
        leftWall.position = CGPoint(x: self.frame.midX, y: self.frame.maxY)
        leftWall.physicsBody = SKPhysicsBody(rectangleOf: leftWall.size)
        leftWall.physicsBody?.affectedByGravity = false
        leftWall.physicsBody?.allowsRotation = false
        leftWall.physicsBody?.isDynamic = false
        leftWall.physicsBody?.pinned = false
        leftWall.physicsBody?.categoryBitMask = wallCat
        leftWall.physicsBody?.collisionBitMask = playerCat
        leftWall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leftWall.zPosition = 5
        
        self.addChild(leftWall)
        
        let rightWall = SKSpriteNode()
        rightWall.size = CGSize(width: self.frame.width, height: 1)
        rightWall.color = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 1)
        rightWall.position = CGPoint(x: self.frame.midX, y: self.frame.minY)
        rightWall.physicsBody = SKPhysicsBody(rectangleOf: rightWall.size)
        rightWall.physicsBody?.affectedByGravity = false
        rightWall.physicsBody?.allowsRotation = false
        rightWall.physicsBody?.isDynamic = false
        rightWall.physicsBody?.pinned = false
        rightWall.physicsBody?.categoryBitMask = wallCat
        rightWall.physicsBody?.collisionBitMask = playerCat
        rightWall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rightWall.zPosition = 5
        
        self.addChild(rightWall)
                
        let topWall = SKSpriteNode()
        topWall.size = CGSize(width: 1, height: self.frame.height)
        topWall.color = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 1)
        topWall.position = CGPoint(x: self.frame.maxX, y: self.frame.midY)
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        topWall.physicsBody?.affectedByGravity = false
        topWall.physicsBody?.allowsRotation = false
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.pinned = false
        topWall.physicsBody?.categoryBitMask = wallCat
        topWall.physicsBody?.collisionBitMask = playerCat
        topWall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        topWall.zPosition = 5
        
        self.addChild(topWall)
        
        let bottomWall = SKSpriteNode()
        bottomWall.name = "bottomWall"
        bottomWall.size = CGSize(width: 1, height: self.frame.height)
        bottomWall.color = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 1)
        bottomWall.position = CGPoint(x: self.frame.minX, y: self.frame.midY)
        bottomWall.physicsBody = SKPhysicsBody(rectangleOf: bottomWall.size)
        bottomWall.physicsBody?.affectedByGravity = false
        bottomWall.physicsBody?.allowsRotation = false
        bottomWall.physicsBody?.isDynamic = false
        bottomWall.physicsBody?.pinned = false
        bottomWall.physicsBody?.categoryBitMask = bottomCat
        bottomWall.physicsBody?.contactTestBitMask = playerCat
        bottomWall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        bottomWall.zPosition = 5
        
        self.addChild(bottomWall)
        self.backgroundColor = UIColor.white
    }
    
    override func didMove(to view: SKView) {
        //music should be playing from the main menu
        if(comingBackFromSettings){
            comingBackFromSettings = false
        }else{
            self.physicsWorld.contactDelegate = self
            
            resetLevel() //clean things when starting
            
            manager.startAccelerometerUpdates()
            manager.accelerometerUpdateInterval = 0.1
            manager.startAccelerometerUpdates(to: OperationQueue.main){
                (data, error) in
                self.physicsWorld.gravity = CGVector(dx: CGFloat(-7), dy: CGFloat((data?.acceleration.y)! * 10))
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        //see if hits bottom wall
        if (bodyA.categoryBitMask == bottomCat && bodyB.categoryBitMask == playerCat) || (bodyB.categoryBitMask == bottomCat && bodyA.categoryBitMask == playerCat){
            resetLevel()
        }
        //see if hits end marker
        if (bodyA.categoryBitMask == endCat && bodyB.categoryBitMask == playerCat) || (bodyA.categoryBitMask == playerCat && bodyB.categoryBitMask == endCat){
            levelComplete()
        }
    }
    
    
    //animation time for being smushed by layer
    func animateDeath(){
        playSquishedSound()
        //freeze player
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.isDynamic = false
        player.physicsBody?.pinned = true
        
        let deathSequence = SKAction.sequence([SKAction.run{self.player.texture = SKTexture(imageNamed: "death")},SKAction.wait(forDuration: 1), SKAction.run{self.resetLevel()}])
        player.run(deathSequence)
    }
    
    func resetLevel(){
        //notes: reseting is a little jaring and fast. Maybe add an artificial delay to make things seem slower
        cs.reset()
        
        //turn on all layers again
        if redLayer.parent == nil {
            self.addChild(redLayer)
        }
        if greenLayer.parent == nil {
            self.addChild(greenLayer)
        }
        if blueLayer.parent == nil {
            self.addChild(blueLayer)
        }
        
        //reset player location
        player.removeFromParent()
        
        player = SKSpriteNode(imageNamed: "player")
        player.size = CGSize(width: 50, height: 50)
        player.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        player.name = "player"
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.allowsRotation = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.pinned = false
        player.physicsBody?.friction = 1
        player.physicsBody?.restitution = 0.05
        player.physicsBody?.angularDamping = 0.1
        player.physicsBody?.linearDamping = 0.1
        player.physicsBody?.categoryBitMask = playerCat
        player.physicsBody?.collisionBitMask = wallCat | redCat | blueCat | greenCat
        player.physicsBody?.contactTestBitMask = bottomCat | endCat
        player.zPosition = 3
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        player.position = CGPoint(x: self.frame.midX + startingPointOffset.y, y: self.frame.midY + startingPointOffset.x)
        player.alpha = 1
        
        self.addChild(player)
    }
    
    func levelComplete(){
        if(menu == nil){ //if level has no menu then just reset
            resetLevel()
            return
        }
        let menuCasted = menu as! LevelMenu
        menuCasted.isTopScene = true
        menuCasted.unlockNextLevel()
        if let view = self.view as SKView? {
            menuCasted.size = self.size
            view.presentScene(menuCasted)
        }
    }
    
    func quitLevel(){
        if(menu == nil){ //if level has no menu then just reset
            resetLevel()
            return
        }
        let menuCasted = menu as! LevelMenu
        menuCasted.isTopScene = true
        if let view = self.view as SKView? {
            menuCasted.size = self.size
            view.presentScene(menuCasted)
        }
    }
    
    func showSettingsMenu(){
        //pause scene so ball doesnt move
        settingsScene.previousScene = self
        settingsScene.previousSceneType = SceneType.Level

        self.comingBackFromSettings = true
        
        if let view = self.view as SKView? {
            view.presentScene(self.settingsScene, transition: SKTransition.fade(with: UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 1), duration: 0.75))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for node in nodes(at: (touches.first?.location(in: self))!) {
            if node == redButton {
                playSwitchSound()
                cs.flipColor(color: .RED)
                self.run(SKAction.wait(forDuration: 0.025))
                toggleLayer(checkForCollision: true, layer: self.redLayer)
            }else if node == blueButton {
                playSwitchSound()
                cs.flipColor(color: .BLUE)
                self.run(SKAction.wait(forDuration: 0.025))
                toggleLayer(checkForCollision: true, layer: self.blueLayer)
            }else if node == greenButton {
                playSwitchSound()
                cs.flipColor(color: .GREEN)
                self.run(SKAction.wait(forDuration: 0.025))
                toggleLayer(checkForCollision: true, layer: self.greenLayer)
            }else if node == backButton {
                playSquishedSound()
                quitLevel()
            }else if node == settingsButton {
                playSwitchSound()
                showSettingsMenu()
            }else{
                if Standards.editmode{
                    //debug
                    print(self.player.position)
                    print(self.frame.size)
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
            run(SKAction.playSoundFileNamed("squished.mp3", waitForCompletion: true))
        }
    }
    
    func toggleLayer(checkForCollision: Bool, layer: SKNode){
        if layer.parent != nil {
            layer.removeFromParent()
        }else{
            if checkForCollision {
                //grab position before and after and compare
                let playerPos = player.position
                self.addChild(layer)
                
                let collided = checkCollisionPoints(layer: layer, playerPos: playerPos)
                if collided {
                    animateDeath()
                }
            }else{
                self.addChild(layer)
            }
        }
    }
    
    func checkCollisionPoints(layer: SKNode, playerPos: CGPoint) -> Bool{
        let buffer = 20
        var testPoints : [CGPoint] = []
        testPoints.append(CGPoint(x: playerPos.x + CGFloat(buffer), y: playerPos.y))
        testPoints.append(CGPoint(x: playerPos.x + CGFloat(buffer), y: playerPos.y + CGFloat(buffer)))
        testPoints.append(CGPoint(x: playerPos.x, y: playerPos.y - CGFloat(buffer)))
        testPoints.append(CGPoint(x: playerPos.x - CGFloat(buffer), y: playerPos.y - CGFloat(buffer)))
        testPoints.append(CGPoint(x: playerPos.x + cos(45)*CGFloat(buffer), y: playerPos.y + sin(45)*CGFloat(buffer)))
        testPoints.append(CGPoint(x: playerPos.x - cos(45)*CGFloat(buffer), y: playerPos.y + sin(45)*CGFloat(buffer)))
        testPoints.append(CGPoint(x: playerPos.x - cos(45)*CGFloat(buffer), y: playerPos.y - sin(45)*CGFloat(buffer)))
        testPoints.append(CGPoint(x: playerPos.x + cos(45)*CGFloat(buffer), y: playerPos.y - sin(45)*CGFloat(buffer)))
        
        var collided = false
        for touchCase in testPoints{
            self.physicsWorld.enumerateBodies(at: touchCase, using: { (body, _) -> Void in
                if body.node == layer{
                    collided = true
                    return
                }
            })
        }
        return collided
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
