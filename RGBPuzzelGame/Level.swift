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
    
    var redButton = SKShapeNode()
    var greenButton = SKShapeNode()
    var blueButton = SKShapeNode()
    
    var packageNumber = 0
    var levelNumber = 0
    
    var startingPoint = CGPoint(x: 0, y: 0)
    var endingPoint = CGPoint(x: 0, y: 0)
    
    var locked = false
    
    var menu = SKScene()
    
    //variable for editing and moving around level items
    let editMode = false
    
    override init() {
        super.init()
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUp(package: Int, numberInPackage: Int, redLayer: String, greenLayer: String, blueLayer: String, startingPos: CGPoint, endingPos: CGPoint){
        self.packageNumber = package
        self.levelNumber = numberInPackage
        
        self.locked = false
        
        self.redLayer = SKSpriteNode(imageNamed: redLayer)
        self.redLayer.name = redLayer
        self.redLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: redLayer), size:CGSize(width: self.redLayer.size.width, height: self.redLayer.size.height))
        
        self.greenLayer = SKSpriteNode(imageNamed: greenLayer)
        self.greenLayer.name = greenLayer
        self.greenLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: greenLayer), size:CGSize(width: self.greenLayer.size.width, height: self.greenLayer.size.height))
        
        self.blueLayer = SKSpriteNode(imageNamed: blueLayer)
        self.blueLayer.name = blueLayer
        self.blueLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: blueLayer), size:CGSize(width: self.blueLayer.size.width, height: self.blueLayer.size.height))
        
        self.startingPoint = startingPos
        self.endingPoint = endingPos
        
        
        setUpLayers()
        setUpButtons()
        setUpStartAndEnd()
        miscSetUp()
    }
    
    func setUp(package: Int, numberInPackage: Int, startingPos: CGPoint, endingPos: CGPoint){
        self.packageNumber = package
        self.levelNumber = numberInPackage
        
        locked = false
        
        self.redLayer = SKSpriteNode(imageNamed: "\(package),\(numberInPackage)R")
        self.redLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "\(package),\(numberInPackage)R"), size:CGSize(width: self.redLayer.size.width, height: self.redLayer.size.height))
        
        self.greenLayer = SKSpriteNode(imageNamed: "\(package),\(numberInPackage)G")
        self.greenLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "\(package),\(numberInPackage)G"), size:CGSize(width: self.greenLayer.size.width, height: self.greenLayer.size.height))
        
        self.blueLayer = SKSpriteNode(imageNamed: "\(package),\(numberInPackage)B")
        self.blueLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "\(package),\(numberInPackage)B"), size:CGSize(width: self.blueLayer.size.width, height: self.blueLayer.size.height))
        
        
        self.startingPoint = startingPos
        self.endingPoint = endingPos
        
        
        setUpLayers()
        setUpButtons()
        setUpStartAndEnd()
        miscSetUp()
    }
    
    
    func setUp(package: Int, numberInPackage: Int, locked: Bool, menu: LevelMenu){
        //currently used level code
        
        self.packageNumber = package
        self.levelNumber = numberInPackage
        
        self.locked = locked
        
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
        
        
        //self.startingPoint = GlobalStaticLookup(package, numberinPackage)
        //self.endingPoint = GlobalStaticLookup(package, numberinPackage)
        
        self.startingPoint = CGPoint(x: 172.49, y: 607.49)
        self.endingPoint = CGPoint(x: 157.99, y: 37.0)
        
        setUpLayers()
        setUpButtons()
        setUpStartAndEnd()
        miscSetUp()
        
        
        
    }
    
    
    /*
     sets up the R,G,and B layers with their physics body and alpha values.
     
    */
    func setUpLayers(){
        
        //self.redLayer.scale(to: CGSize()
        
        print(self.frame.width)
        print(self.frame.height)
        
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
        
        
        redLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: redLayer.name!), alphaThreshold: 0, size: redLayer.size)
        
        redLayer.name = "redLayer"
        
        redLayer.physicsBody?.affectedByGravity = false
        redLayer.physicsBody?.allowsRotation = false
        redLayer.physicsBody?.isDynamic = false
        redLayer.physicsBody?.pinned = false
        
        redLayer.physicsBody?.friction = 0.2
        redLayer.physicsBody?.restitution = 0.2
        redLayer.physicsBody?.angularDamping = 0.1
        redLayer.physicsBody?.linearDamping = 0.1
        
        redLayer.physicsBody?.categoryBitMask = UInt32(1)
        redLayer.physicsBody?.collisionBitMask = UInt32(1)
        redLayer.physicsBody?.fieldBitMask = UInt32(1)
        redLayer.physicsBody?.contactTestBitMask = UInt32(1)
        
        redLayer.zPosition = 1.1
        
        
        greenLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: greenLayer.name!), alphaThreshold: 0, size: greenLayer.size)
        
        greenLayer.name = "greenLayer"
        
        greenLayer.physicsBody?.affectedByGravity = false
        greenLayer.physicsBody?.allowsRotation = false
        greenLayer.physicsBody?.isDynamic = false
        greenLayer.physicsBody?.pinned = false
        
        greenLayer.physicsBody?.friction = 0.2
        greenLayer.physicsBody?.restitution = 0.2
        greenLayer.physicsBody?.angularDamping = 0.1
        greenLayer.physicsBody?.linearDamping = 0.1
        
        greenLayer.physicsBody?.categoryBitMask = UInt32(1)
        greenLayer.physicsBody?.collisionBitMask = UInt32(1)
        greenLayer.physicsBody?.fieldBitMask = UInt32(1)
        greenLayer.physicsBody?.contactTestBitMask = UInt32(1)
        
        greenLayer.zPosition = 1.2
        
        
        blueLayer.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: blueLayer.name!), alphaThreshold: 0, size: blueLayer.size)
        
        blueLayer.name = "blueLayer"
        
        blueLayer.physicsBody?.affectedByGravity = false
        blueLayer.physicsBody?.allowsRotation = false
        blueLayer.physicsBody?.isDynamic = false
        blueLayer.physicsBody?.pinned = false
        
        blueLayer.physicsBody?.friction = 0.2
        blueLayer.physicsBody?.restitution = 0.2
        blueLayer.physicsBody?.angularDamping = 0.1
        blueLayer.physicsBody?.linearDamping = 0.1
        
        blueLayer.physicsBody?.categoryBitMask = UInt32(1)
        blueLayer.physicsBody?.collisionBitMask = UInt32(1)
        blueLayer.physicsBody?.fieldBitMask = UInt32(1)
        blueLayer.physicsBody?.contactTestBitMask = UInt32(1)
        
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
        
        redButton = SKShapeNode(rectOf: CGSize(width: (cs.width/3), height: (cs.height/3)/3))
        redButton.fillColor = UIColor(red: 255/255, green: 154/255, blue: 154/255, alpha: 0.001)
        redButton.position = CGPoint(x: cs.position.x, y: cs.position.y+redButton.frame.height)
        redButton.strokeColor = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 0.001)
        redButton.zPosition = 5
        self.addChild(redButton)


        greenButton = SKShapeNode(rectOf: CGSize(width: (cs.width/3), height: (cs.height/3)/3))
        greenButton.fillColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.001)
        greenButton.position = CGPoint(x: cs.position.x, y: cs.position.y)
        greenButton.strokeColor = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 0.001)
        greenButton.zPosition = 5
        self.addChild(greenButton)


        blueButton = SKShapeNode(rectOf: CGSize(width: (cs.width/3), height: (cs.height/3)/3))
        blueButton.fillColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.001)
        blueButton.position = CGPoint(x: cs.position.x, y: cs.position.y-redButton.frame.height)
        blueButton.strokeColor = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 0.001)
        blueButton.zPosition = 5
        self.addChild(blueButton)
        
        
        
        
        
        
        
        
    }
    
    func setUpStartAndEnd(){
        
        
        player = SKSpriteNode(imageNamed: "player")
        player.size = CGSize(width: 50, height: 50)


        player.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        player.name = "player"

        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.allowsRotation = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.pinned = false

        player.physicsBody?.friction = 1
        player.physicsBody?.restitution = 0.2
        player.physicsBody?.angularDamping = 0.1
        player.physicsBody?.linearDamping = 0.1

        player.physicsBody?.categoryBitMask = UInt32(0) //the player is level 0
        player.physicsBody?.collisionBitMask = UInt32(1)
        player.physicsBody?.fieldBitMask = UInt32(1)
        player.physicsBody?.contactTestBitMask = UInt32(1)

        player.zPosition = 4

        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        player.position = startingPoint

        player.alpha = 1

        self.addChild(player)
        
        //let bodies = player.physicsBody?.allContactedBodies() code for later
        
        
        
        
        var end = SKSpriteNode(imageNamed: "player")
        end.size = CGSize(width: 50, height: 50)
        
        
        end.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        end.name = "end"
        
        end.physicsBody?.affectedByGravity = false
        end.physicsBody?.allowsRotation = false
        end.physicsBody?.isDynamic = false
        end.physicsBody?.pinned = false
        
        end.physicsBody?.categoryBitMask = UInt32(3) //the end is level 3
        end.physicsBody?.collisionBitMask = UInt32(3)
        end.physicsBody?.fieldBitMask = UInt32(3)
        end.physicsBody?.contactTestBitMask = UInt32(3)
        
        end.zPosition = 4
        
        end.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        end.position = endingPoint
        
        end.alpha = 0.5
        
        self.addChild(end)
        
        
        
        //set up end point
        
    }
    
    func miscSetUp(){
        
        //set up bounding walls
        
        var leftWall = SKSpriteNode()
        leftWall.size = CGSize(width: self.frame.width, height: 1)
        leftWall.color = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 1)
        leftWall.position = CGPoint(x: self.frame.midX, y: self.frame.maxY)
        
        leftWall.physicsBody = SKPhysicsBody(rectangleOf: leftWall.size)
        
        leftWall.physicsBody?.affectedByGravity = false
        leftWall.physicsBody?.allowsRotation = false
        leftWall.physicsBody?.isDynamic = false
        leftWall.physicsBody?.pinned = false
        
        leftWall.physicsBody?.categoryBitMask = UInt32(1)
        leftWall.physicsBody?.collisionBitMask = UInt32(1)
        leftWall.physicsBody?.fieldBitMask = UInt32(1)
        leftWall.physicsBody?.contactTestBitMask = UInt32(1)
        
        
        leftWall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leftWall.zPosition = 5
        
        
        self.addChild(leftWall)
        
        
        var rightWall = SKSpriteNode()
        rightWall.size = CGSize(width: self.frame.width, height: 1)
        rightWall.color = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 1)
        rightWall.position = CGPoint(x: self.frame.midX, y: self.frame.minY)
        
        rightWall.physicsBody = SKPhysicsBody(rectangleOf: rightWall.size)
        
        rightWall.physicsBody?.affectedByGravity = false
        rightWall.physicsBody?.allowsRotation = false
        rightWall.physicsBody?.isDynamic = false
        rightWall.physicsBody?.pinned = false
        
        rightWall.physicsBody?.categoryBitMask = UInt32(1)
        rightWall.physicsBody?.collisionBitMask = UInt32(1)
        rightWall.physicsBody?.fieldBitMask = UInt32(1)
        rightWall.physicsBody?.contactTestBitMask = UInt32(1)
        
        
        rightWall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rightWall.zPosition = 5
        
        
        self.addChild(rightWall)
        
        
        
        var topWall = SKSpriteNode()
        topWall.size = CGSize(width: 1, height: self.frame.height)
        topWall.color = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 1)
        topWall.position = CGPoint(x: self.frame.maxX, y: self.frame.midY)
        
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        
        topWall.physicsBody?.affectedByGravity = false
        topWall.physicsBody?.allowsRotation = false
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.pinned = false
        
        topWall.physicsBody?.categoryBitMask = UInt32(1)
        topWall.physicsBody?.collisionBitMask = UInt32(1) //level 1 means normal blocking wall
        topWall.physicsBody?.fieldBitMask = UInt32(1)
        topWall.physicsBody?.contactTestBitMask = UInt32(1)
        
        
        topWall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        topWall.zPosition = 5
        
        
        self.addChild(topWall)
        
        
        
        var bottomWall = SKSpriteNode()
        bottomWall.name = "bottomWall"
        bottomWall.size = CGSize(width: 1, height: self.frame.height)
        bottomWall.color = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 1)
        bottomWall.position = CGPoint(x: self.frame.minX, y: self.frame.midY)
        
        bottomWall.physicsBody = SKPhysicsBody(rectangleOf: bottomWall.size)
        
        bottomWall.physicsBody?.affectedByGravity = false
        bottomWall.physicsBody?.allowsRotation = false
        bottomWall.physicsBody?.isDynamic = false
        bottomWall.physicsBody?.pinned = false
        
        bottomWall.physicsBody?.categoryBitMask = UInt32(1) //level 2 means deadly
        bottomWall.physicsBody?.collisionBitMask = UInt32(1)
        bottomWall.physicsBody?.fieldBitMask = UInt32(1)
        bottomWall.physicsBody?.contactTestBitMask = UInt32(1)
        
        
        bottomWall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        bottomWall.zPosition = 5
        
        
        self.addChild(bottomWall)
        
        
        //todo: walls are buggy invesitage
        //note. player will not bounce on bottom wall becuase it is a deadly wall.
        //cont. add colision checking and death
        
        
        
        self.backgroundColor = UIColor.white
        
    }
    
    override func didMove(to view: SKView) {
        
        //music should be playing from the main menu
        
        
        self.physicsWorld.contactDelegate = self
        
        
        
        
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx: CGFloat(-5), dy: CGFloat((data?.acceleration.y)! * 10))
            
        }
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        
        //debug
        //print("\(bodyA.node?.name), category mask \(bodyA.categoryBitMask) collided with \(bodyB.node?.name), category mask \(bodyB.categoryBitMask).")
        
        //see if hits bottom wall
        if (bodyA.categoryBitMask == 0 && bodyB.node?.name == "bottomWall") || (bodyA.node?.name == "bottomWall" && bodyB.categoryBitMask == 0){
            resetLevel()
        }
        
        //see if hits end marker
        if (bodyA.categoryBitMask == 0 && bodyB.categoryBitMask == 3) || (bodyA.categoryBitMask == 3 && bodyB.categoryBitMask == 0){
            levelComplete()
        }
        
        //check if a layer is turned on a kills a player
        
        
    }
    
    func resetLevel(){
        
        
        
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
        player.position = startingPoint
        
        
    }
    
    func levelComplete(){
        var menuCasted = menu as! LevelMenu
        menuCasted.unlockNextLevel()
        
        if let view = self.view as SKView? {
           
            menuCasted.size = self.size
            
            view.presentScene(menuCasted)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        for node in nodes(at: (touches.first?.location(in: self))!) {
            if node == redButton {
                cs.flipColor(color: COLOR.RED)
                self.run(SKAction.wait(forDuration: 0.025))
                toggleRedLayer(checkForCollision: false) //todo: should be 'true' in the future
            }else if node == blueButton {
                cs.flipColor(color: COLOR.BLUE)
                self.run(SKAction.wait(forDuration: 0.025))
                toggleBlueLayer(checkForCollision: false) //todo: should be 'true' in the future
            }else if node == greenButton {
                cs.flipColor(color: COLOR.GREEN)
                self.run(SKAction.wait(forDuration: 0.025))
                toggleGreenLayer(checkForCollision: false) //todo: should be 'true' in the future
            }else{
                if editMode{
                    self.player.position = (touches.first?.location(in: self))!
                    //debug
                    print((touches.first?.location(in: self))!)
                    
                }
            }
        }
    }
    
    private func checkSwitchPosition(touch: UITouch){
        
    }
    
    
    func toggleRedLayer(checkForCollision: Bool){ //could be abstracted with the blue and green similar functions below
        if redLayer.parent != nil {
            redLayer.removeFromParent()
        }else{
            if checkForCollision {
                //grab position before and after and compare
            }else{
                self.addChild(redLayer)
            }
        }
    }
    
    func toggleBlueLayer(checkForCollision: Bool){
        if blueLayer.parent != nil {
            blueLayer.removeFromParent()
        }else{
            if checkForCollision {
                //grab position before and after and compare
            }else{
                self.addChild(blueLayer)
            }
        }
    }
    
    func toggleGreenLayer(checkForCollision: Bool){
        if greenLayer.parent != nil {
            greenLayer.removeFromParent()
        }else{
            if checkForCollision {
                //grab position before and after and compare
            }else{
                self.addChild(greenLayer)
            }
        }
    }
    
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
