//
//  EasyScene.swift
//  MyFirstGame
//
//  Created by Programacion Moviles on 25/03/2019.
//  Copyright © 2019 Programacion Moviles. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
protocol MediumSceneDelegate: class {
    func back(sender: MediumScene)
    func goToEasy(sender: MediumScene)
    func goToMedium(sender: MediumScene)
    func goToHard(sender: MediumScene)
}
class MediumScene: SKScene {
    
    private var label : SKLabelNode?
    public var Logic = GameLogic(dificulty: 2)
    public var BackButton: SpriteButton?
    var timer:Timer?
    var time = 100
    let audio = AudioController.shared
    
    weak var MediumDelegate: MediumSceneDelegate?
    
    override func didMove(to view: SKView) {
        
        
        
        label = SKLabelNode(text: "")
        label?.fontColor = .black
        label?.fontSize = 15.0
        label?.fontName = "AvenirNext-Bold"
        label?.position = CGPoint(x: (view.frame.width - 100 ) , y: (view.frame.height - 30))
        addChild(label!)
        
        scene?.backgroundColor = SKColor(named: "Color")!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,      selector: #selector(timerRunning), userInfo: nil, repeats: true)
        if(Preferences.isSoundOn() == true){
            audio.play()
            
        }
        
        
        var enseñado = false
        
        scene?.backgroundColor = SKColor(named: "Color")!
        for i in 0..<(Logic.difficulty.rawValue ){
            
            
            let offsety = CGFloat(i)
            if(i < 5){
                Logic.textures[i].position = CGPoint(x: (view.frame.width / 2.0 - (view.frame.width/3)) , y: (view.frame.height - view.frame.height / 8 - ((view.frame.height / 5) * offsety )))
            }
            else if(i < 10){
                Logic.textures[i].position = CGPoint(x: (view.frame.width / 2.0 - (view.frame.width/8) ) , y: (view.frame.height - view.frame.height / 8 - ((view.frame.height / 5) * (offsety - 5))))
            }
            else if( i < 15){
                Logic.textures[i].position = CGPoint(x: (view.frame.width / 2.0 + (view.frame.width/8)) , y: (view.frame.height - view.frame.height / 8 - ((view.frame.height / 5) * (offsety - 10))))
            }
            else if( i < 20){
                Logic.textures[i].position = CGPoint(x: (view.frame.width / 2.0 + (view.frame.width/3)) , y: (view.frame.height - view.frame.height / 8 - ((view.frame.height / 5) * (offsety - 15))))
            }
            Logic.textures[i].scale(to: CGSize(width: (view.frame.width / 20.0) + view.frame.width / 10, height: (view.frame.height / 20.0) + view.frame.height / 10))
            Logic.sizeCard = CGSize(width: (view.frame.width / 20.0) + view.frame.width / 10, height: (view.frame.height / 20.0) + view.frame.height / 10)
            Logic.textures[i].isUserInteractionEnabled = true
            
            addChild(Logic.textures[i])
            Logic.textures[i].onTap = {
                [weak self] in
                if(self!.Logic.canTap && self!.Logic.Win() != true && self!.time != 0 && enseñado){
                self!.tapOnCard(identifier: i)
                }

            }
            
 
            BackButton = SpriteButton(texture: SKTexture(imageNamed: "back"),size: CGSize(width: 50, height: 50))
            BackButton!.position = CGPoint(x: 25 , y: (view.frame.height) - 25)
            BackButton!.isUserInteractionEnabled = true
            
            BackButton!.onTap = {
                self.timer?.invalidate()
                self.audio.stop()
                self.MediumDelegate?.back(sender: self)
                
            }
            addChild(BackButton!)
            
            // if()
        }
        
        
        //enseñar cartas
        let actionInicial1 = SKAction.run{
            //voltear y enseñar todas las cartas
            for i in 0..<self.Logic.difficulty.rawValue{
                //animacion voltear
                let action = SKAction.scaleX(to: 0.0, duration: 0.3)
                self.Logic.textures[i].run(action)
                //esperar x segundos
                //let action1 = SKAction.wait(forDuration: 0.3)
                //self.textures[i].run(action1)
                //resize new texture
                
                let action2 = SKAction.setTexture(self.Logic.textures[i].TextureFront, resize: true)
                let actionScale = SKAction.scale(to: CGSize(width:0.0,height:self.Logic.sizeCard.height), duration: 0.0)
                //animacion voltear inversa
                let action3 = SKAction.scale(to: CGSize(width:self.Logic.sizeCard.width,height:self.Logic.sizeCard.height), duration: 0.3)
                let sequence = SKAction.sequence([action, action2,actionScale, action3])
                self.Logic.textures[i].run(sequence)
                
            }
        }
        let actionInicial2 = SKAction.wait(forDuration: 2.0)
        let actionInicial3 = SKAction.run{
            //volver a tapar las cartas
            for i in 0..<self.Logic.difficulty.rawValue{
                let action = SKAction.scaleX(to: 0.0, duration: 0.3)
                let action1 = SKAction.wait(forDuration: 0.3)
                let actionScaleY = SKAction.scale(to: CGSize(width:0.0,height:self.Logic.sizeCard.height), duration: 0.0)
                let action3 = SKAction.scale(to: CGSize(width:self.Logic.sizeCard.width,height:self.Logic.sizeCard.height), duration: 0.3)
                let action2 = SKAction.setTexture(self.Logic.textures[i].TextureBack, resize: true)
                let sequence = SKAction.sequence([action,action1, action2,actionScaleY, action3])
                self.Logic.textures[i].run(sequence)
            }
        }
        let actionInicial4 = SKAction.wait(forDuration: 0.5)
        let actionInicial5 = SKAction.run{
            enseñado = true
        }
        
        let sequence = SKAction.sequence([actionInicial1, actionInicial2, actionInicial3, actionInicial4, actionInicial5])
        Logic.textures[1].run(sequence)
        
        
        
    }
    func tapOnCard(identifier: Int){
        
        
        
        
        
        if(Logic.secondCard){
            //si esta tapada
            if(Logic.cards[identifier].estado == Card.state.tapado){
                Logic.secondCard = false
                self.Logic.canTap = false
                Logic.cards[identifier].estado = Card.state.destapado
                
                
                
                //animacion voltear
                let action = SKAction.scaleX(to: 0.0, duration: 0.3)
                Logic.textures[identifier].run(action)
                //esperar x segundos
                let action1 = SKAction.wait(forDuration: 0.3)
                Logic.textures[identifier].run(action1)
                //resize new texture
                
                var action2 = SKAction.setTexture(Logic.textures[identifier].TextureFront, resize: true)
                
                //animacion voltear inversa
                let action33 = SKAction.scale(to: CGSize(width:0.0,height:Logic.sizeCard.height), duration: 0.0)
                var action3 = SKAction.scale(to: CGSize(width:Logic.sizeCard.width,height:Logic.sizeCard.height), duration: 0.3)
                
                var sequence = SKAction.sequence([action,action1, action2, action3])
                
                //comprobar las dos cartas volteadas
                let action4 = SKAction.run{
                    //emparejadas
                    if(self.Logic.textures[identifier].imageName == self.Logic.textures[self.Logic.tempIdent].imageName){
                        self.Logic.cards[identifier].estado = Card.state.emparejado
                        self.Logic.cards[self.Logic.tempIdent].estado = Card.state.emparejado
                        self.Logic.score += self.Logic.points
                        
                        
                        //Comprobar si se ha acabado la partida
                        
                        //acabar la partida si true
                        
                    }else{//son dife-rentes
                        
                        
                        //cambiar estado de las dos y animar volteo de vuelta
                        self.Logic.cards[identifier].estado = Card.state.tapado
                        self.Logic.cards[self.Logic.tempIdent].estado = Card.state.tapado
                        
                        let actionScaleY = SKAction.scale(to: CGSize(width:0.0,height:self.Logic.sizeCard.height), duration: 0.0)
                        action3 = SKAction.scale(to: CGSize(width:self.Logic.sizeCard.width,height:self.Logic.sizeCard.height), duration: 0.3)
                        action2 = SKAction.setTexture(self.Logic.textures[identifier].TextureBack, resize: true)
                        sequence = SKAction.sequence([action,action1, action2,actionScaleY,action33, action3])
                        self.Logic.textures[identifier].run(sequence)
                        
                        
                        action2 = SKAction.setTexture(self.Logic.textures[self.Logic.tempIdent].TextureBack, resize: true)
                        sequence = SKAction.sequence([action,action1, action2,actionScaleY,action33, action3])
                        self.Logic.textures[self.Logic.tempIdent].run(sequence)
                        
                    }
                    self.Logic.canTap = true
                }
                let actionScale = SKAction.scale(to: CGSize(width:self.Logic.sizeCard.width,height:self.Logic.sizeCard.height), duration: 0.0)
                sequence = SKAction.sequence([action,action1, action2,action33, action3,actionScale, action4])
                self.Logic.textures[identifier].run(sequence)
                
            }
        }
        else{
            //puesto en publico porque no consegui lo que queria
            if(self.Logic.cards[identifier].estado == Card.state.tapado){
                self.Logic.secondCard = true
                self.Logic.cards[identifier].estado = Card.state.destapado
                self.Logic.tempIdent = identifier
                
                
                //animacion voltear
                let action = SKAction.scaleX(to: 0.0, duration: 0.3)
                self.Logic.textures[identifier].run(action)
                //esperar x segundos
                let action1 = SKAction.wait(forDuration: 0.3)
                self.Logic.textures[identifier].run(action1)
                //resize new texture
                
                let action2 = SKAction.setTexture(self.Logic.textures[identifier].TextureFront, resize: true)
                let actionScale = SKAction.scale(to: CGSize(width:0.0,height:self.Logic.sizeCard.height), duration: 0.0)
                
                //animacion voltear inversa
                let action3 = SKAction.scale(to: CGSize(width:self.Logic.sizeCard.width,height:self.Logic.sizeCard.height), duration: 0.3)
                let sequence = SKAction.sequence([action,action1, action2,actionScale, action3])
                self.Logic.textures[identifier].run(sequence)
                
            }
            
            
            
        }
    }
    
    @objc func timerRunning() {
        time = time - 1
        
        if(Logic.Win()){
            let victory = SKSpriteNode.init(texture: SKTexture(imageNamed: "victory"),size: CGSize(width: 350, height: 300))
            victory.position = CGPoint(x: (view!.frame.width / 2 ) , y: (view!.frame.height / 2))
            addChild(victory)
            timer?.invalidate()
        }
        
        if let label = label {
            label.text = "\(time)"
            
            if time == 0{
                
                timer?.invalidate()
                let defeat = SKSpriteNode.init(texture: SKTexture(imageNamed: "defeat"),size: CGSize(width: 350, height: 300))
                defeat.position = CGPoint(x: (view!.frame.width / 2 ) , y: (view!.frame.height / 2))
                self.addChild(defeat)
            }
        }
    }
}
