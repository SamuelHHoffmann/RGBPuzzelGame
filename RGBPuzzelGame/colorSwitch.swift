//
//  colorSwitch.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 5/24/19.
//  Copyright © 2019 Samuel Hoffmann. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

enum COLOR {
    case RED
    case GREEN
    case BLUE
}

enum COLOR_STATE {
    case ON
    case OFF
}

class colorSwitch: SKNode {
    
    private var state : Int = 5 //the state represents an easy way to get which switches are on or off R:G:B is the bit representation where each                                is a single bit on or off (1 on, 0 off)
    
    private var redSwitchBackground : SKSpriteNode
    private var greenSwitchBackground : SKSpriteNode
    private var blueSwitchBackground : SKSpriteNode
    
    private var redSwitchOverlay : SKSpriteNode
    private var greenSwitchOverlay : SKSpriteNode
    private var blueSwitchOverlay : SKSpriteNode
    
    private var redSwitch = SKNode()
    private var greenSwitch = SKNode()
    private var blueSwitch = SKNode()
    
    let width : CGFloat
    let height : CGFloat
    
    private var spacing : Double = 0 //spacing between switches
    private var origin : CGFloat = 0
    private var offset : CGFloat = 0
    
    private var red : COLOR_STATE = .ON
    private var green : COLOR_STATE = .ON
    private var blue : COLOR_STATE = .ON
    
    override init() {
        
        redSwitchBackground = SKSpriteNode(imageNamed: "red_switch")
        greenSwitchBackground = SKSpriteNode(imageNamed: "green_switch")
        blueSwitchBackground = SKSpriteNode(imageNamed: "blue_switch")
        
        redSwitchOverlay = SKSpriteNode(imageNamed: "switch_overlay")
        greenSwitchOverlay = SKSpriteNode(imageNamed: "switch_overlay")
        blueSwitchOverlay = SKSpriteNode(imageNamed: "switch_overlay")
        
        width = redSwitchBackground.frame.height
        height = (redSwitchBackground.frame.width*3)+(redSwitchOverlay.frame.width/2)*2
        
        super.init()
        
        //red
        redSwitchBackground.position = CGPoint(x: 0, y: 0)
        redSwitchBackground.zRotation = CGFloat(Double.pi/2)
        redSwitchBackground.zPosition = 0
        
        redSwitchOverlay.position = CGPoint(x: redSwitchBackground.position.x, y: redSwitchBackground.position.y+(redSwitchOverlay.frame.height/2))
        
        print(redSwitchBackground.frame)
        print(redSwitchOverlay.frame)
        
        redSwitchOverlay.zRotation = CGFloat(Double.pi/2)
        redSwitchOverlay.zPosition = 1
        //green
        greenSwitchBackground.position = CGPoint(x: 0, y: 0)
        greenSwitchBackground.zRotation = CGFloat(Double.pi/2)
        greenSwitchBackground.zPosition = 0
        
        greenSwitchOverlay.position = CGPoint(x: greenSwitchBackground.position.x, y: greenSwitchBackground.position.y+(greenSwitchOverlay.frame.height/2))
        greenSwitchOverlay.zRotation = CGFloat(Double.pi/2)
        greenSwitchOverlay.zPosition = 1
        //blue
        blueSwitchBackground.position = CGPoint(x: 0, y: 0)
        blueSwitchBackground.zRotation = CGFloat(Double.pi/2)
        blueSwitchBackground.zPosition = 0
        
        blueSwitchOverlay.position = CGPoint(x: blueSwitchBackground.position.x, y: blueSwitchBackground.position.y+(blueSwitchOverlay.frame.height/2))
        blueSwitchOverlay.zRotation = CGFloat(Double.pi/2)
        blueSwitchOverlay.zPosition = 1
        
        spacing = Double(redSwitchOverlay.frame.width/2) //set sapcing for switches
        
        redSwitch.addChild(redSwitchBackground)
        redSwitch.addChild(redSwitchOverlay)
        redSwitch.position = CGPoint(x: 0, y: Double(redSwitchBackground.frame.height)+spacing)
        
        greenSwitch.addChild(greenSwitchBackground)
        greenSwitch.addChild(greenSwitchOverlay)
        greenSwitch.position = CGPoint(x: 0, y: 0)
        
        blueSwitch.addChild(blueSwitchBackground)
        blueSwitch.addChild(blueSwitchOverlay)
        blueSwitch.position = CGPoint(x: 0, y: -Double(redSwitchBackground.frame.height)-spacing)
        
        self.addChild(redSwitch)
        self.addChild(greenSwitch)
        self.addChild(blueSwitch)
        
        offset = (redSwitchOverlay.frame.height)+((redSwitchOverlay.frame.width/2)-(redSwitchOverlay.frame.height/2))
        origin = (redSwitchOverlay.frame.height/2)
        
        //flip twice to fix kink
        flipColor(color: .RED)
        flipColor(color: .GREEN)
        flipColor(color: .BLUE)
        flipColor(color: .RED)
        flipColor(color: .GREEN)
        flipColor(color: .BLUE)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func flipColor(color: COLOR){
        
        if(color == COLOR.RED){
            if red == .ON {
                let slide = SKAction.move(to: CGPoint(x: redSwitchBackground.position.x, y: redSwitchBackground.position.y+redSwitchOverlay.frame.width/2-offset), duration: 0.025)
                redSwitchOverlay.run(slide)
                red = .OFF
            }else{
                let slide_back = SKAction.move(to: CGPoint(x: redSwitchBackground.position.x, y: redSwitchBackground.position.y+origin), duration: 0.025)
                redSwitchOverlay.run(slide_back)
                red = .ON
            }
        }else if(color == COLOR.GREEN){
            if green == .ON {
                greenSwitchOverlay.position = CGPoint(x: greenSwitchBackground.position.x, y: greenSwitchBackground.position.y+greenSwitchOverlay.frame.width/2-offset)
                green = .OFF
            }else{
                greenSwitchOverlay.position = CGPoint(x: greenSwitchBackground.position.x, y: greenSwitchBackground.position.y+origin)
                green = .ON
            }
        }else if(color == COLOR.BLUE){
            if blue == .ON {
                blueSwitchOverlay.position = CGPoint(x: blueSwitchBackground.position.x, y: blueSwitchBackground.position.y+blueSwitchOverlay.frame.width/2-offset)
                blue = .OFF
            }else{
                blueSwitchOverlay.position = CGPoint(x: blueSwitchBackground.position.x, y: blueSwitchBackground.position.y+origin)
                blue = .ON
            }
        }else{
            //impossible
        }
    }
    
    
    
    
    
    
}


