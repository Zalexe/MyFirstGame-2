//
//  Card.swift
//  MyFirstGame
//
//  Created by Programacion Moviles on 21/03/2019.
//  Copyright © 2019 Programacion Moviles. All rights reserved.
//

import UIKit
import GameplayKit
import AVFoundation

class Card{
    //var id = 0
    enum state{
        case tapado
        case destapado
        case emparejado
        
    }
    let player = AVPlayer(url: Bundle.main.url(forResource: "cardFlip.wav",withExtension: nil)!)
    
    private let sharedAudioController = AudioController()
    
    public var estado = state.tapado
    
    init(/*identifier: Int*/){
        /*id = identifier*/
    }

    func destapar(){
        estado = state.destapado
    }
    func emparejar(){
        estado = state.emparejado
    }
    func tapar(){
        estado = state.tapado
    }
    
    func stop(){
        player.pause()
        player.seek(to: CMTime.zero)
        
    }
}
