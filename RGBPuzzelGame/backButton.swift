//
//  backButton.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 12/25/19.
//  Copyright © 2019 Samuel Hoffmann. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class backButton: SKNode {
    
    override init() {
        super.init()
        
        let backButton_img = SKSpriteNode(imageNamed: "back button")
        backButton_img.zPosition = 4
        backButton_img.setScale(0.35)
        self.addChild(backButton_img)
        
        let backButton = SKShapeNode(rectOf: CGSize(width: (backButton_img.frame.width)*2, height: (backButton_img.frame.height)*2))
        backButton.fillColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.001)
        backButton.position = backButton_img.position
        backButton.strokeColor = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.001)
        backButton.zPosition = 5
        self.addChild(backButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
