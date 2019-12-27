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
    
    var redCollision = SKSpriteNode()
    var greenCollision = SKSpriteNode()
    var blueCollision = SKSpriteNode()
    
    let cs = colorSwitch()
    
    var player = SKSpriteNode()
    
    var redButton = SKShapeNode()
    var greenButton = SKShapeNode()
    var blueButton = SKShapeNode()
    
    var backButton_img = SKSpriteNode()
    var backButton = SKShapeNode()
    
    var settingsButton_img = SKSpriteNode()
    var settingsButton = SKShapeNode()
    
    var settingsOverlay = SKShapeNode()
    var settingsShown = true
    var comingBackFromSettings = false
    
    
    var packageNumber = 0
    var levelNumber = 0
    
    var startingPoint = CGPoint(x: 0, y: 0)
    var endingPoint = CGPoint(x: 0, y: 0)
    
    var locked = false
    
    var menu = SKScene()
    var settingsScene = Settings()
    
    
    
    
    
    // categories:
    let playerCat: UInt32 = 0x1 << 1
    let endCat: UInt32 = 0x1 << 2
    let colliiderCat: UInt32 = 0x1 << 3 //all collision layers
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
    
    func setUp(package: Int, numberInPackage: Int, locked: Bool, menu: LevelMenu){
        //currently used level code
        
        self.packageNumber = package
        self.levelNumber = numberInPackage
        
        self.locked = locked
        
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
        
        
        //set up collision layers
        self.redCollision = SKSpriteNode(imageNamed: "\(package),\(numberInPackage)RC")
        self.redCollision.name = "\(package),\(numberInPackage)RC"
        self.redCollision.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "\(package),\(numberInPackage)RC"), size:CGSize(width: self.redCollision.size.width, height: self.redCollision.size.height))
        
        self.greenCollision = SKSpriteNode(imageNamed: "\(package),\(numberInPackage)GC")
        self.greenCollision.name = "\(package),\(numberInPackage)GC"
        self.greenCollision.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "\(package),\(numberInPackage)GC"), size:CGSize(width: self.greenCollision.size.width, height: self.greenCollision.size.height))
        
        self.blueCollision = SKSpriteNode(imageNamed: "\(package),\(numberInPackage)BC")
        self.blueCollision.name = "\(package),\(numberInPackage)BC"
        self.blueCollision.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "\(package),\(numberInPackage)BC"), size:CGSize(width: self.blueCollision.size.width, height: self.blueCollision.size.height))
        
        
        self.menu = menu
        
        
        //self.startingPoint = GlobalStaticLookup(package, numberinPackage)
        //self.endingPoint = GlobalStaticLookup(package, numberinPackage)
        
        //with multiple packages will use lookup scheme. currently hardwired
        self.startingPoint = CGPoint(x: 170, y: 607.49)
        self.endingPoint = CGPoint(x: 145, y: 37.0)
        
        setUpLayers()
        setUpButtons()
        setUpStartAndEnd()
        miscSetUp()
    }
    
    
    /*
     sets up the R,G,and B layers with their physics body and alpha values.
     Also sets up the collsion layers for each color giving them a physics body and attributes.
     
    */
    func setUpLayers(){
        
        //print(self.frame.width)
        //print(self.frame.height)
        
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
        //blueLayer.name = "blueLayer"
        
        //blueLayer.physicsBody
        
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
        
        ///////////////////////////////////////////////////////////////
        
        
        //set up collisions layers
        
        
        ///////////////////////////////////////////////////////////////
        
        redCollision.size = size
        greenCollision.size = size
        blueCollision.size = size
        
        //red
        redCollision.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: redCollision.name!), size: redCollision.size)
        redCollision.name = "redCollision"
        
        redCollision.physicsBody?.affectedByGravity = false
        redCollision.physicsBody?.allowsRotation = false
        redCollision.physicsBody?.isDynamic = false
        redCollision.physicsBody?.pinned = false
        
        redCollision.physicsBody?.friction = 0.2
        redCollision.physicsBody?.restitution = 0.2
        redCollision.physicsBody?.angularDamping = 0.1
        redCollision.physicsBody?.linearDamping = 0.1
        
        redCollision.physicsBody?.categoryBitMask = colliiderCat
        redCollision.physicsBody?.collisionBitMask = playerCat
        redCollision.physicsBody?.contactTestBitMask = playerCat
        
        redCollision.zPosition = 2.1
        
        //green
        greenCollision.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: greenCollision.name!), size: greenCollision.size)
        greenCollision.name = "greenCollision"
        
        greenCollision.physicsBody?.affectedByGravity = false
        greenCollision.physicsBody?.allowsRotation = false
        greenCollision.physicsBody?.isDynamic = false
        greenCollision.physicsBody?.pinned = false
        
        greenCollision.physicsBody?.friction = 0.2
        greenCollision.physicsBody?.restitution = 0.2
        greenCollision.physicsBody?.angularDamping = 0.1
        greenCollision.physicsBody?.linearDamping = 0.1
        
        greenCollision.physicsBody?.categoryBitMask = colliiderCat
        greenCollision.physicsBody?.collisionBitMask = playerCat
        greenCollision.physicsBody?.contactTestBitMask = playerCat
        
        greenCollision.zPosition = 2.2
        
        //blue
        blueCollision.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: blueCollision.name!), size: blueCollision.size)
        blueCollision.name = "blueCollision"
        
        blueCollision.physicsBody?.affectedByGravity = false
        blueCollision.physicsBody?.allowsRotation = false
        blueCollision.physicsBody?.isDynamic = false
        blueCollision.physicsBody?.pinned = false
        
        blueCollision.physicsBody?.friction = 0.2
        blueCollision.physicsBody?.restitution = 0.2
        blueCollision.physicsBody?.angularDamping = 0.1
        blueCollision.physicsBody?.linearDamping = 0.1
        
        blueCollision.physicsBody?.categoryBitMask = colliiderCat
        blueCollision.physicsBody?.collisionBitMask = playerCat
        blueCollision.physicsBody?.contactTestBitMask = playerCat
        
        blueCollision.zPosition = 2.3
        
        
        redCollision.zRotation = CGFloat(-Double.pi/2)
        redCollision.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        redCollision.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        greenCollision.zRotation = CGFloat(-Double.pi/2)
        greenCollision.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        greenCollision.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        blueCollision.zRotation = CGFloat(-Double.pi/2)
        blueCollision.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        blueCollision.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        
        redCollision.alpha = 0.5
        greenCollision.alpha = 0.5
        blueCollision.alpha = 0.5
        
        self.addChild(redCollision)
        self.addChild(greenCollision)
        self.addChild(blueCollision)
        
        
        
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
        
        
        
        backButton_img = SKSpriteNode(imageNamed: "back button")
        backButton_img.position = CGPoint(x: self.frame.minX+cs.width/2, y: self.frame.midY+(self.frame.height/2)-(self.frame.height/16))
        backButton_img.zPosition = 4
        backButton_img.zRotation = CGFloat(-1*(Double.pi/2))
        backButton_img.setScale(0.35)
        self.addChild(backButton_img)
        
        backButton = SKShapeNode(rectOf: CGSize(width: (backButton_img.frame.width)*2, height: (backButton_img.frame.height)*2))
        backButton.fillColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.001)
        backButton.position = backButton_img.position
        backButton.strokeColor = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 0.001)
        backButton.zPosition = 5
        self.addChild(backButton)
        
        
        
        settingsButton_img = SKSpriteNode(imageNamed: "settingsGear")
        settingsButton_img.position = CGPoint(x: self.frame.minX+cs.width/2, y: self.frame.midY-(self.frame.height/2)+(self.frame.height/16))
        settingsButton_img.zPosition = 4
        settingsButton_img.zRotation = CGFloat(-1*(Double.pi/2))
        settingsButton_img.setScale(0.35)
        self.addChild(settingsButton_img)
        
        settingsButton = SKShapeNode(rectOf: CGSize(width: (settingsButton_img.frame.width)*2, height: (settingsButton_img.frame.height)*2))
        settingsButton.fillColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.001)
        settingsButton.position = settingsButton_img.position
        settingsButton.strokeColor = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 0.001)
        settingsButton.zPosition = 5
        self.addChild(settingsButton)
        
        //settings overlay
        
        settingsOverlay = SKShapeNode(rectOf: size)
        settingsOverlay.fillColor = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 1)
        settingsOverlay.strokeColor = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 1)
        settingsOverlay.zPosition = 3.5
        settingsOverlay.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(settingsOverlay)
        hideSettingsMenu()
        
        
        settingsScene = Settings()
        settingsScene.size = self.size
        settingsScene.setUpSettings()
        settingsScene.previousScene = self
        settingsScene.previousSceneType = SceneType.Level
    }
    
    func setUpStartAndEnd(){
        
        
        player = SKSpriteNode(imageNamed: "player")
        player.size = CGSize(width: 45, height: 45)

        
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
        player.physicsBody?.collisionBitMask = wallCat | redCat | blueCat | greenCat | colliiderCat
        player.physicsBody?.contactTestBitMask = bottomCat | endCat | colliiderCat

        
        player.zPosition = 4

        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        player.position = startingPoint

        player.alpha = 1

        self.addChild(player)
        
        
        //set up end point
        let end = SKSpriteNode(imageNamed: "end")
        end.size = CGSize(width: 45, height: 45)
        
        end.physicsBody = SKPhysicsBody(circleOfRadius: 22.5)
        end.name = "end"
        
        
        end.physicsBody?.affectedByGravity = false
        end.physicsBody?.allowsRotation = false
        end.physicsBody?.isDynamic = false
        end.physicsBody?.pinned = false
        
        end.physicsBody?.categoryBitMask = endCat
        end.physicsBody?.contactTestBitMask = playerCat
        
        end.zPosition = 3
        
        end.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        end.position = endingPoint
        
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
            hideSettingsMenu()
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
        
        
        //debug
        //print("\(bodyA.node?.name), category mask \(bodyA.categoryBitMask) collided with \(bodyB.node?.name), category mask \(bodyB.categoryBitMask).")
        //print(player.position)
        //print(contact.contactPoint)
        
        //see if hits bottom wall
        if (bodyA.categoryBitMask == bottomCat && bodyB.categoryBitMask == playerCat) || (bodyB.categoryBitMask == bottomCat && bodyA.categoryBitMask == playerCat){
            
            
            
            resetLevel()
        }

        //see if hits collision layer
        if (bodyA.categoryBitMask == colliiderCat && bodyB.categoryBitMask == playerCat) || (bodyB.categoryBitMask == colliiderCat && bodyA.categoryBitMask == playerCat){
            //print("\(bodyA.node?.name ?? "BodyA"), category mask \(bodyA.categoryBitMask) collided with \(bodyB.node?.name ?? "BodyB"), category mask \(bodyB.categoryBitMask).")
            animateDeath()
            //resetLevel() moved into death sequence to require completion of animation
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
        
        if(settingsShown == true){
            hideSettingsMenu()
        }
        
        cs.reset()
        
        //turn on all layers again
        if redLayer.parent == nil {
            self.addChild(redLayer)
            self.addChild(redCollision)
        }
        if greenLayer.parent == nil {
            self.addChild(greenLayer)
            self.addChild(greenCollision)
        }
        if blueLayer.parent == nil {
            self.addChild(blueLayer)
            self.addChild(blueCollision)
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
        player.position = startingPoint
        
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
        
        settingsShown = true
        
        settingsOverlay.run(SKAction.sequence([SKAction.moveTo(x: (self.frame.midX), duration: 0.75), SKAction.run {
                if let view = self.view as SKView? {
                    view.presentScene(self.settingsScene)
                }
            }, SKAction.run {
                self.comingBackFromSettings = true
                self.isPaused = true
            }]))
        
    }
    
    func hideSettingsMenu(){
        
        settingsOverlay.run(SKAction.moveTo(x: -(self.frame.midX), duration: 0))
        settingsShown = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //print(nodes(at: (touches.first?.location(in: self))!))
        
        //audio setup
        
        
        
        for node in nodes(at: (touches.first?.location(in: self))!) {
            
            if node == redButton {
                
                playSwitchSound()
                
                cs.flipColor(color: COLOR.RED)
                self.run(SKAction.wait(forDuration: 0.025))
                toggleRedLayer(checkForCollision: false) //todo: should be 'true' in the future
                
            }else if node == blueButton {
                
                playSwitchSound()
                
                cs.flipColor(color: COLOR.BLUE)
                self.run(SKAction.wait(forDuration: 0.025))
                toggleBlueLayer(checkForCollision: false) //todo: should be 'true' in the future

                
            }else if node == greenButton {
                
                playSwitchSound()
                
                cs.flipColor(color: COLOR.GREEN)
                self.run(SKAction.wait(forDuration: 0.025))
                toggleGreenLayer(checkForCollision: false) //todo: should be 'true' in the future
                
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
    
    
    private func checkSwitchPosition(touch: UITouch){
        
    }
    
    private func playSwitchSound(){

        run(SKAction.playSoundFileNamed("switch.mp3", waitForCompletion: false))
        
    }
    
    private func playSquishedSound(){

        run(SKAction.playSoundFileNamed("squished.mp3", waitForCompletion: true))
        
    }
    
    func toggleRedLayer(checkForCollision: Bool){ //could be abstracted with the blue and green similar functions below
        if redLayer.parent != nil {
            redLayer.removeFromParent()
            redCollision.removeFromParent()
        }else{
            if checkForCollision {
                //grab position before and after and compare
            }else{
                self.addChild(redLayer)
                self.addChild(redCollision)
            }
            
        }
    }
    
    func toggleBlueLayer(checkForCollision: Bool){
        if blueLayer.parent != nil {
            blueLayer.removeFromParent()
            blueCollision.removeFromParent()
        }else{
            if checkForCollision {
                //collisions happens when the collision layer makes contact with the
            }else{
                self.addChild(blueLayer)
                self.addChild(blueCollision)
            }
        }
    }
    
    func toggleGreenLayer(checkForCollision: Bool){
        if greenLayer.parent != nil {
            greenLayer.removeFromParent()
            greenCollision.removeFromParent()
        }else{
            if checkForCollision {
                //grab position before and after and compare
            }else{
                self.addChild(greenLayer)
                self.addChild(greenCollision)
            }
        }
    }
    
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
