//
//  AudioController.swift
//  MyFirstGame
//
//  Created by Programacion Moviles on 11/04/2019.
//  Copyright © 2019 Programacion Moviles. All rights reserved.
//

import AVFoundation

class AudioController{

    let player = AVPlayer(url: Bundle.main.url(forResource: "bgm.mp3",withExtension: nil)!)
    
    private static let sharedAudioController = AudioController()
    
    static var shared: AudioController{
        return sharedAudioController
    }
    
    func play(){
        player.play()
    }
    
    func pause(){
        player.pause()
    }
    
    func stop(){
        player.pause()
        player.seek(to: CMTime.zero)
        
    }
    func on(){
        player.volume = 1.0
    }
    func off(){
        player.volume = 0.0
    }
}
