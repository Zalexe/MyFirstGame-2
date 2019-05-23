//
//  Preferences.swift
//  MyFirstGame
//
//  Created by Programacion Moviles on 29/03/2019.
//  Copyright © 2019 Programacion Moviles. All rights reserved.
//

import Foundation

class Preferences {
    
    static let k_SOUND_ON = "SOUND_ON"
    static let K_DECK = "K_DECK"
    static func isSoundOn() -> Bool{
        
        if let _ = UserDefaults.standard.object(forKey: k_SOUND_ON){
            let soundOn = UserDefaults.standard.bool(forKey: k_SOUND_ON)
            return soundOn
        }
        return true
    }
    
    
    
   static func toggleSound(){
        let soundOn = isSoundOn()
        UserDefaults.standard.set(!soundOn, forKey: k_SOUND_ON)
        
    }
    
    static func saveCards(){
        
       //UserDefaults.standard.set(cartas, forKey: K_DECK)
    }
    static func getCards(){
       /* if let savedCards = UserDefaults.standard.object(forKey: K_DECK) as? [String] {
            
            //cartas = savedCards
        }*/
    }
    
    
}
