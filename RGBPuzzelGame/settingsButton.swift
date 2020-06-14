//
//  settingsButton.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 6/14/20.
//  Copyright © 2020 Samuel Hoffmann. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class SettingsButton: SKNode {
    
    var settingsButton_img = SKSpriteNode()
    var settingsButton = SKShapeNode()
    
    override init() {
        super.init()
        
        settingsButton_img = SKSpriteNode(imageNamed: "settingsGear")
        settingsButton_img.zPosition = 4
        settingsButton_img.setScale(0.35)
        self.addChild(settingsButton_img)
        
        settingsButton = SKShapeNode(rectOf: CGSize(width: (settingsButton_img.frame.width)*2, height: (settingsButton_img.frame.height)*2))
        settingsButton.fillColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.001)
        settingsButton.position = settingsButton_img.position
        settingsButton.strokeColor = UIColor(displayP3Red: 116/255, green: 133/255, blue: 160/255, alpha: 0.001)
        settingsButton.zPosition = 5
        self.addChild(settingsButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
