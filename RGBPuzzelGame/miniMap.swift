//
//  miniMap.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 6/24/20.
//  Copyright © 2020 Samuel Hoffmann. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class MiniMap: SKNode {
    
    private var data : [Int : Bool] = [:]
    
    private var slot0 = SKSpriteNode()
    //////////////////////////////////
    private var slot1 = SKSpriteNode()
    private var slot2 = SKSpriteNode()
    private var slot3 = SKSpriteNode()
    private var slot4 = SKSpriteNode()
    private var slot5 = SKSpriteNode()
    private var slot6 = SKSpriteNode()
    //////////////////////////////////
    private var slot7 = SKSpriteNode()
    
    private var levelNumber = 1
    
    init(data: [Int : Bool]) {
     
        self.data = data
        
        super.init()
        
        
        
    }
    
    func unlockLevel(num: Int){
        
    }
    
    func slideLeft(){
        
    }
    
    func slideRight(){
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
