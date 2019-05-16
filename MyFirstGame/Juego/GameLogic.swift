//
//  GameLogic.swift
//  MyFirstGame
//
//  Created by Programacion Moviles on 21/03/2019.
//  Copyright © 2019 Programacion Moviles. All rights reserved.
//

import UIKit
import GameplayKit


enum Level: Int{
    case easy = 12
    case medium = 20
    case hard = 24

}

class GameLogic{
    
    var timer: Timer?

    var cards = [Card]()
    var points = 0
    var selectedCard: Card?
    var difficulty: Level
    
    var score = 0
    
    var secondCard:Bool = false
    var tempIdent:Int = 0
    var sizeCard:CGSize
    var canTap = true
    
    var textures:[CardSprite]
    
    init(dificulty: Int){
        
        if(dificulty == 1){
            difficulty = .easy
            sizeCard = CGSize(width: 70 , height: 100)

            textures = [CardSprite(cartas[0]),CardSprite(cartas[1]),CardSprite(cartas[2])
                ,CardSprite(cartas[3]),CardSprite(cartas[4]), CardSprite(cartas[5])    ,    CardSprite(cartas[0]),CardSprite(cartas[1]),CardSprite(cartas[2])
                ,CardSprite(cartas[3]),CardSprite(cartas[4]),CardSprite(cartas[5])]
            textures.shuffle()
            
            for _ in 0..<(difficulty.rawValue ){
                let card1 = Card()
                
                cards.append(card1)
                
            }
        }
        else if(dificulty == 2){
            difficulty = .medium
            sizeCard = CGSize(width: 60, height: 90)
            
           textures = [CardSprite("CardFront"),CardSprite("obelisk"),CardSprite("sliffer"),CardSprite("Chimeratech"),CardSprite("fusion"),CardSprite("mirror"),CardSprite("stardust"),CardSprite("firewall"),CardSprite("dhampir"),CardSprite("chaosmax")  ,   CardSprite("CardFront"),CardSprite("obelisk"),CardSprite("sliffer"),CardSprite("Chimeratech"),CardSprite("fusion"),CardSprite("mirror"),CardSprite("stardust"),CardSprite("firewall"),CardSprite("dhampir"),CardSprite("chaosmax")]
            textures.shuffle()
            for _ in 0..<(difficulty.rawValue ){
                let card1 = Card()
                
                cards.append(card1)
                
            }
        }
        else{
            difficulty = .hard
            sizeCard = CGSize(width: 50, height: 70)
            
           textures = [CardSprite("CardFront"),CardSprite("obelisk"),CardSprite("sliffer"),CardSprite("Chimeratech"),CardSprite("fusion"),CardSprite("mirror"),CardSprite("stardust"),CardSprite("firewall"),CardSprite("dhampir"),CardSprite("chaosmax"),CardSprite("pendulum"),CardSprite("supreme")   ,   CardSprite("CardFront"),CardSprite("obelisk"),CardSprite("sliffer"),CardSprite("Chimeratech"),CardSprite("fusion"),CardSprite("mirror"),CardSprite("stardust"),CardSprite("firewall"),CardSprite("dhampir"),CardSprite("chaosmax"),CardSprite("pendulum"),CardSprite("supreme") ]
            textures.shuffle()
            for _ in 0..<(difficulty.rawValue ){
                let card1 = Card()
                
                cards.append(card1)
                
            }
        }
    
        
 
    }
    
    //otra partida
    func reset(){
        
        textures.shuffle()
        cards.removeAll()
        for _ in 0..<(difficulty.rawValue ){
            let card1 = Card()
            
            cards.append(card1)
            
        }
        
        tempIdent = 0
        secondCard = false
        
        /*timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in self?.tick(timer: timer) }*/
    }
    
    func Win()->Bool{
        
        
        for i in 0..<difficulty.rawValue{
            if(cards[i].estado != Card.state.emparejado){
               
                return false
            }
        }
        
        return true
    
    }
    
    
    
            
        
    }
    
    func move(){
        
    }
    
    

