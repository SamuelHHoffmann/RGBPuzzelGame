//
//  settings.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 8/7/19.
//  Copyright © 2019 Samuel Hoffmann. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

enum SceneType {
    case Level
    case MainMenu
    case LevelSelect
    case none
}


class Settings: SKScene {

    var previousScene = SKScene()
    var previousSceneType = SceneType.none
    
    
    func setUpSettings(){
        
    }
    
    
    override func didMove(to view: SKView) {
        //
    }
    
    
    func goBack(){
        //go back to previous scene
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //what was clicked
    }
    
    override func update(_ currentTime: TimeInterval) {
        //
    }
    

}
