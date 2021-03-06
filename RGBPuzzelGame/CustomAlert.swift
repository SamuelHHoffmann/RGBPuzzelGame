//
//  CustomAlert.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 8/2/20.
//  Copyright © 2020 Samuel Hoffmann. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class CustomAlert: SKNode {

    var button1 : (String, () -> Void)
    var button1Label = SKLabelNode()
    
    var button2 : (String, () -> Void)
    var button2Label = SKLabelNode()
    
    var textBody = SKLabelNode()
    
    init(text: String, buttonCount: Int, button1: (String, () -> Void), button2: (String, () -> Void)?) {
        
        self.button1 = button1
        self.button2 = button2 ?? ("", {})
        
        super.init()
        
        textBody.text = text
        textBody.zPosition = 21
        textBody.preferredMaxLayoutWidth = 800
        textBody.numberOfLines = 4
        textBody.fontSize = 64
        textBody.fontName = "AvenirNext-Bold"
        textBody.fontColor = UIColor.white
        textBody.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        textBody.setScale(0.35)
        self.addChild(textBody)
        textBody.position = CGPoint(x: textBody.position.x, y: textBody.position.y)
        
        
        
        
        let spacer = 50
        
        self.button1Label.text = self.button1.0
        self.button1Label.zPosition = 21
        self.button1Label.preferredMaxLayoutWidth = 50
        self.button1Label.fontSize = 64
        self.button1Label.fontName = "AvenirNext-Bold"
        self.button1Label.fontColor = UIColor(displayP3Red: 171/255, green: 255/255, blue: 171/255, alpha: 1)
        self.button1Label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.button1Label.setScale(0.35)
        self.addChild(button1Label)
        self.button1Label.position = buttonCount == 2 ? CGPoint(x: self.button1Label.position.x - self.button1Label.frame.width - CGFloat(spacer), y: self.button1Label.position.y) : self.button1Label.position
        
        
        if buttonCount == 2{
            self.button2Label.text = self.button2.0
            self.button2Label.zPosition = 21
            self.button2Label.preferredMaxLayoutWidth = 50
            self.button2Label.fontSize = 64
            self.button2Label.fontName = "AvenirNext-Bold"
            self.button2Label.fontColor = UIColor(displayP3Red: 255/255, green: 171/255, blue: 171/255, alpha: 1)
            self.button2Label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            self.button2Label.setScale(0.35)
            self.addChild(button2Label)
            self.button2Label.position = CGPoint(x: self.button2Label.position.x + self.button2Label.frame.width + CGFloat(spacer), y: self.button2Label.position.y)
        }
        
        let background = SKShapeNode(rect: CGRect(x: -350/2, y: 0, width: 350, height: 200), cornerRadius: 30)
        background.fillColor = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 1)
        background.zPosition = 20
        self.addChild(background)
        
        self.button1Label.position = CGPoint(x: self.button1Label.position.x, y: self.button1Label.position.y + self.button1Label.frame.height)
        self.button2Label.position = CGPoint(x: self.button2Label.position.x, y: self.button2Label.position.y + self.button2Label.frame.height)
        textBody.position = CGPoint(x: textBody.position.x, y: background.frame.maxY - textBody.frame.height - CGFloat(spacer/2))
        
        
        self.name = "alert"
        self.zRotation = CGFloat(-Double.pi/2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func reset(text: String, buttonCount: Int, button1: (String, () -> Void), button2: (String, () -> Void)?) {
        
        self.button1 = button1
        self.button2 = button2 ?? ("", {})
        
        self.textBody.text = text
        
        self.button1Label.removeFromParent()
        self.button2Label.removeFromParent()
        
        let spacer = 50
        
        self.button1Label.text = self.button1.0
        self.button1Label.zPosition = 21
        self.button1Label.preferredMaxLayoutWidth = 50
        self.button1Label.fontSize = 64
        self.button1Label.fontName = "AvenirNext-Bold"
        self.button1Label.fontColor = UIColor(displayP3Red: 171/255, green: 255/255, blue: 171/255, alpha: 1)
        self.button1Label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        self.button1Label.setScale(0.35)
        self.addChild(button1Label)
        self.button1Label.position = buttonCount == 2 ? CGPoint(x: self.button1Label.position.x - self.button1Label.frame.width - CGFloat(spacer), y: self.button1Label.position.y) : self.button1Label.position
        
        
        if buttonCount == 2{
            self.button2Label.text = self.button2.0
            self.button2Label.zPosition = 21
            self.button2Label.preferredMaxLayoutWidth = 50
            self.button2Label.fontSize = 64
            self.button2Label.fontName = "AvenirNext-Bold"
            self.button2Label.fontColor = UIColor(displayP3Red: 255/255, green: 171/255, blue: 171/255, alpha: 1)
            self.button2Label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            self.button2Label.setScale(0.35)
            self.addChild(button2Label)
            self.button2Label.position = CGPoint(x: self.button2Label.position.x + self.button2Label.frame.width + CGFloat(spacer), y: self.button2Label.position.y)
        }
        
        self.button1Label.position = CGPoint(x: self.button1Label.position.x, y: self.button1Label.position.y + self.button1Label.frame.height)
        self.button2Label.position = CGPoint(x: self.button2Label.position.x, y: self.button2Label.position.y + self.button2Label.frame.height)
    }
    
    
    func alertTouchHandler(touch: UITouch, successHandler: () -> Void){
        if self.nodes(at: touch.location(in: self)).contains(button1Label) {
            self.removeFromParent()
            successHandler()
            button1.1()
        }else if self.nodes(at: touch.location(in: self)).contains(button2Label) {
            self.removeFromParent()
            successHandler()
            button2.1()
        }
    }
    
}
