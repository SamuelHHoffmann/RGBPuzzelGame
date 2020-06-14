//
//  settingsButton.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 6/8/20.
//  Copyright © 2020 Samuel Hoffmann. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

enum SWITCH_STATE {
    case ON
    case OFF
}

class SettingsSwitch: SKNode {

    private var switchBackground : SKSpriteNode
    
    private var switchOverlay : SKSpriteNode
    
    private var label : SKLabelNode
    
    private var state : SWITCH_STATE = SWITCH_STATE.ON
    
    override init(){
        self.switchBackground = SKSpriteNode()
        self.switchOverlay = SKSpriteNode()
        self.label = SKLabelNode()
        super.init()
    }
    
    init(name: String = "", initState: SWITCH_STATE?) {
        self.switchBackground = SKSpriteNode()
        self.switchOverlay = SKSpriteNode()
        self.label = SKLabelNode()
        super.init()
        
        self.switchBackground = SKSpriteNode(imageNamed: "onofff_switch")
        self.switchBackground.zPosition = 1
        self.addChild(self.switchBackground)
        self.switchBackground.position = CGPoint(x: 0, y: 0)
        
        self.switchOverlay = SKSpriteNode(imageNamed: "switch_overlay")
        self.switchOverlay.zPosition = 2
        self.addChild(self.switchOverlay)
        self.switchOverlay.position = CGPoint(x: self.switchBackground.position.x - (self.switchOverlay.frame.width/2), y: self.switchBackground.position.y)
        
        self.label = SKLabelNode(text: name)
        self.label.zPosition = 2
        self.label.preferredMaxLayoutWidth = self.switchBackground.frame.width + 100
        self.label.fontSize = 64
        self.label.fontName = "AvenirNext-Bold"
        self.label.fontColor = UIColor.white
        self.label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.addChild(self.label)
        self.label.position = CGPoint(x: self.switchBackground.position.x, y: self.switchBackground.position.y + self.switchBackground.frame.height)
        
        self.state = initState ?? SWITCH_STATE.ON
    }
    
    public func flip() -> SWITCH_STATE{
        return self.state == SWITCH_STATE.ON ? turnOff() : turnOn()
    }
    
    public func turnOn() -> SWITCH_STATE{
        self.state = SWITCH_STATE.ON
        let slide = SKAction.move(to: CGPoint(x: self.switchBackground.position.x - (self.switchOverlay.frame.width/2), y: self.switchBackground.position.y), duration: 0.025)
        switchOverlay.run(slide)
        return self.state
    }
    
    public func turnOff() -> SWITCH_STATE{
        self.state = SWITCH_STATE.OFF
        let slide = SKAction.move(to: CGPoint(x: self.switchBackground.position.x + (self.switchOverlay.frame.width/2), y: self.switchBackground.position.y), duration: 0.025)
        switchOverlay.run(slide)
        return self.state
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
