//
//  musicPlayer.swift
//  RGBPuzzelGame
//
//  Created by Samuel Hoffmann on 6/14/20.
//  Copyright © 2020 Samuel Hoffmann. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import AVFoundation

class MusicPlayer{

    static private let music = ["RGBA music - synth background.m4a", "background music piano,guitar.m4a"]
    
    static private let musicDurations = ["RGBA music - synth background.m4a":138, "background music piano,guitar.m4a":122]
    
    static private var musicNode = SKAudioNode()
    
    static func setUp(){
        
    }
    
    static func play(continuous: Bool){
        
        Standards.backgroundSKScene.removeAllChildren()
        
        let song = music[Int.random(in: 0...music.count-1)]
        
        musicNode = SKAudioNode(fileNamed: song)
        Standards.backgroundSKScene.addChild(musicNode)
        musicNode.run(SKAction.stop())
        musicNode.run(SKAction.play())
        
        if continuous{
            musicNode.run(SKAction.sequence([SKAction.wait(forDuration: Double(musicDurations[song] ?? 0)), SKAction.run {
                play(continuous: true)
            }]))
        }
    }
    
    static func pause(){
        musicNode.run(SKAction.pause())
    }
    
    static func stop(){
        musicNode.run(SKAction.stop())
    }
}
