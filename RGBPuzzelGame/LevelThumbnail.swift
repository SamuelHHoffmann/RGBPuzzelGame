//
//  LevelThumbnail.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 12/23/19.
//  Copyright © 2019 Samuel Hoffmann. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit



class levelThumbnail: SKNode {

    let totalPerLevel = [0 : 2, 1 : 3, 2 : 0, 3 : 0]
    
    private var backgroundImage = SKSpriteNode()
    private var completePercentOverlay = SKShapeNode()
    private var percentOverlay = SKLabelNode()
    private var redLayer = SKSpriteNode(imageNamed: "redTumbnailOverlay")
    private var greenLayer = SKSpriteNode(imageNamed: "greenTumbnailOverlay")
    private var blueLayer = SKSpriteNode(imageNamed: "blueTumbnailOverlay")
    
    private var level = -1
    var percentComplete = 0.0
    var disabled = false
    
    func setUp(level: Int, width: Double, height: Double){
        let lastUnlocked = UserDefaults.standard.integer(forKey: "Saved_Level_Record:Unlocked:\(level)")
        
        if (totalPerLevel[level] ?? 0) == 0 {
            disabled = true
        }else{
            disabled = false
            percentComplete = Double(lastUnlocked)/Double((totalPerLevel[level] ?? 0))
        }
        
        //150 969696
        //196 c4c4c4
        
        backgroundImage = SKSpriteNode(imageNamed: "LevelThumbnail\(level)")
        backgroundImage.size = CGSize(width: width, height: height)
        backgroundImage.zPosition = 0
        self.addChild(backgroundImage)
        
        //completePercentOverlay = SKShapeNode(rectOf: CGSize(width: width/2, height: 80*height/290)) //Testing width
        completePercentOverlay = SKShapeNode(rectOf: CGSize(width: percentComplete*width, height: 80*height/260)) //actual width
        completePercentOverlay.fillColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        completePercentOverlay.strokeColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        completePercentOverlay.zPosition = 1
        completePercentOverlay.position = CGPoint(x: backgroundImage.frame.minX + completePercentOverlay.frame.width/2, y: backgroundImage.frame.minY + completePercentOverlay.frame.height/2)
        self.addChild(completePercentOverlay)
        
        percentOverlay.text = "\(Int(percentComplete*100))%"
        percentOverlay.fontName = "AvenirNext-Bold"
        percentOverlay.fontSize = CGFloat(80*height/290)
        percentOverlay.color = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        percentOverlay.zPosition = 1.5
        percentOverlay.position = CGPoint(x: backgroundImage.frame.minX + 50, y: backgroundImage.frame.minY + percentOverlay.frame.height/4)
        self.addChild(percentOverlay)
        
        
        redLayer.size = backgroundImage.size
        redLayer.alpha = 0.333
        redLayer.zPosition = 2.1
        //self.addChild(redLayer)
        
        greenLayer.size = backgroundImage.size
        greenLayer.alpha = 0.333
        greenLayer.zPosition = 2.2
        //self.addChild(greenLayer)
        
        blueLayer.size = backgroundImage.size
        blueLayer.alpha = 0.333
        blueLayer.zPosition = 2.3
        //self.addChild(blueLayer)
        
        if level == 0{
            self.addChild(redLayer)
            self.addChild(blueLayer)
        }else if level == 1{
            self.addChild(blueLayer)
        }else if level == 2{
            self.addChild(greenLayer)
        }else if level == 3{
            self.addChild(greenLayer)
            self.addChild(blueLayer)
        }else{
            
        }
        
        
        
        
    }
    
    func update(){
        
        let lastUnlocked = UserDefaults.standard.integer(forKey: "Saved_Level_Record:Unlocked:\(level)")
        
        if (totalPerLevel[level] ?? 0) == 0 {
            disabled = true
        }else{
            disabled = false
            percentComplete = Double(lastUnlocked)/Double((totalPerLevel[level] ?? 0))
        }
        
        //completePercentOverlay.removeFromParent()
        
        let newcompletePercentOverlay = SKShapeNode(rectOf: CGSize(width: CGFloat(percentComplete)*self.frame.width, height: 80*self.frame.height/260)) //actual width
        newcompletePercentOverlay.fillColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        newcompletePercentOverlay.strokeColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        newcompletePercentOverlay.zPosition = 1
        newcompletePercentOverlay.position = CGPoint(x: backgroundImage.frame.minX + newcompletePercentOverlay.frame.width/2, y: backgroundImage.frame.minY + newcompletePercentOverlay.frame.height/2)
        self.addChild(newcompletePercentOverlay)
     
        
    }
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
