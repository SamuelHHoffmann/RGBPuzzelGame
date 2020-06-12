//
//  loadingScene.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 6/11/20.
//  Copyright © 2020 Samuel Hoffmann. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class LevelLoadingScene: RGBAScene {

    var nextScene = Level()
    var previousScene = LevelMenu()
    
    func setUp(){
        super.setUp(redLayerStr: "settingsRed", greenLayerStr: "settingsGreen", blueLayerStr: "settingsBlue", physics: false)
        super.cs.alpha = 0
        
        self.type = .none
        
        NotificationCenter.default.addObserver(self, selector: #selector(previousTransitionComplete), name: Notification.Name("Transition Complete:From:LevelMenu"), object: nil)
        
    }
    
    
    @objc func previousTransitionComplete(){
        let prevScene = previousScene
        run(
            SKAction.group([
                SKAction.run {
                    prevScene.currentLevel = prevScene.setUpLevel(levelNum: prevScene.currentLevelNumber)
                },
                SKAction.wait(forDuration: 0.5)
            ]),
        completion: {
                if let view = self.view as SKView? {
                    let transition = SKTransition.reveal(with: .left, duration: 0.65)
                    view.presentScene(self.nextScene, transition: transition)
                }
        })
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    

}
