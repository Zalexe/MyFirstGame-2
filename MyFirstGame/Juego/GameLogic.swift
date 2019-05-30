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
    var multiplier = 1
    var secondCard:Bool = false
    var tempIdent:Int = 0
    var sizeCard:CGSize
    var canTap = true
    
    var textures:[CardSprite]
    
    init(dificulty: Int){
        
        Preferences.getCards()
        
        if(dificulty == 1){
            difficulty = .easy
            sizeCard = CGSize(width: 50 , height: 80)

            textures = [CardSprite(cartas[0]),CardSprite(cartas[1]),CardSprite(cartas[2])
                ,CardSprite(cartas[3]),CardSprite(cartas[4]), CardSprite(cartas[5])    ,    CardSprite(cartas[0]),CardSprite(cartas[1]),CardSprite(cartas[2])
                ,CardSprite(cartas[3]),CardSprite(cartas[4]),CardSprite(cartas[5])]
            textures.shuffle()
            
            for _ in 0..<(difficulty.rawValue ){
                let card1 = Card()
                
                cards.append(card1)
                
            }
            points = 20
        }
        else if(dificulty == 2){
            difficulty = .medium
            sizeCard = CGSize(width: 40, height: 70)
            
           textures = [CardSprite(cartas[0]),CardSprite(cartas[1]),CardSprite(cartas[2]), CardSprite(cartas[3]),CardSprite(cartas[4]), CardSprite(cartas[5]),CardSprite(cartas[6]),CardSprite(cartas[7]),CardSprite(cartas[8]),CardSprite(cartas[9]),CardSprite(cartas[9]) ,                                                            CardSprite(cartas[0]),CardSprite(cartas[1]),CardSprite(cartas[2]), CardSprite(cartas[3]),CardSprite(cartas[4]), CardSprite(cartas[5]),CardSprite(cartas[6]),CardSprite(cartas[7]),CardSprite(cartas[8]),CardSprite(cartas[9]),CardSprite(cartas[9])]
            textures.shuffle()
            for _ in 0..<(difficulty.rawValue ){
                let card1 = Card()
                
                cards.append(card1)
                
            }
            points = 40
        }
        else{
            difficulty = .hard
            sizeCard = CGSize(width: 30, height: 60)
            
           textures = [CardSprite(cartas[0]),CardSprite(cartas[1]),CardSprite(cartas[2]), CardSprite(cartas[3]),CardSprite(cartas[4]), CardSprite(cartas[5]),CardSprite(cartas[6]),CardSprite(cartas[7]),CardSprite(cartas[8]),CardSprite(cartas[9]),CardSprite(cartas[9]),CardSprite(cartas[10]), CardSprite(cartas[11]), CardSprite(cartas[0]),CardSprite(cartas[1]),CardSprite(cartas[2]) ,CardSprite(cartas[3]),CardSprite(cartas[4]), CardSprite(cartas[5]),CardSprite(cartas[6]),CardSprite(cartas[7]),CardSprite(cartas[8]),CardSprite(cartas[9]),CardSprite(cartas[9]),CardSprite(cartas[10]),CardSprite(cartas[11])]
            textures.shuffle()
            for _ in 0..<(difficulty.rawValue ){
                let card1 = Card()
                
                cards.append(card1)
                
            }
            
            points = 60
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
    
    
    func loadImage(imageName: String) -> UIImage? {
        let documentsDirectoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
        if let documentsDirectoryURL = documentsDirectoryURL {
            do {
                let data = try Data(contentsOf: documentsDirectoryURL.appendingPathComponent(imageName))
                if let image = UIImage(data: data) {
                    return image
                }
            } catch {
                print(error)
            }
            
        }
        return nil
    }
            
        
    }


    func move(){
        
    }
    
    

