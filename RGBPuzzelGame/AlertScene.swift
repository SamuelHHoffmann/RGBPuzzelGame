//
//  AlertScene.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 8/11/20.
//  Copyright © 2020 Samuel Hoffmann. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class AlertScene: SKScene {

    private let alertNode = CustomAlert(text: "", buttonCount: 1, button1: ("", {}), button2: ("", {}))
    private var background = SKShapeNode()
    
    
    func setUp(){
        self.background = SKShapeNode(rect: self.frame, cornerRadius: 0)
        self.background.fillColor = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 0.2)
        self.background.zPosition = 19
        self.addChild(background)
        
        alertNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(alertNode)
        
        self.alertNode.alpha = 0
        self.alertNode.setScale(0)
        self.background.alpha = 0
    }
    
    func showAlert(text: String, buttonCount: Int, button1: (String, () -> Void), button2: (String, () -> Void)?){
        self.run(SKAction.sequence([
            SKAction.run {
                self.alertNode.reset(text: text, buttonCount: buttonCount, button1: button1, button2: button2)
            },
            SKAction.group([
                SKAction.run {
                    self.background.run(SKAction.fadeAlpha(to: 0.2, duration: 0.65))
                },
                SKAction.run {
                    self.alertNode.run(SKAction.scale(to: 0.35, duration: 0.65))
                },
                SKAction.run {
                    self.alertNode.run(SKAction.fadeAlpha(to: 1, duration: 0.65))
                }
            ])
        ]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for node in nodes(at: (touches.first?.location(in: self))!) {
            if node == alertNode{
                alertNode.alertTouchHandler(touch: touches.first!, successHandler: {() in self.alertNode.alpha = 0; self.background.alpha = 0; self.alertNode.setScale(0)})
            }
        }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

}
