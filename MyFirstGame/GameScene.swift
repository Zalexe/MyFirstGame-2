//
//  GameScene.swift
//  MyFirstGame
//
//  Created by Programacion Moviles on 15/02/2019.
//  Copyright © 2019 Programacion Moviles. All rights reserved.
//




import SpriteKit
import GameplayKit





class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var gameButton = Button(rect: CGRect(x: 0, y: 0, width: 50, height: 50),cornerRadius: 10)
    private var aboutButton = ClousureButton(rect: CGRect(x: 0, y: 0, width: 50, height: 150),cornerRadius: 10)
    private var settingsButton = ClousureButton(rect: CGRect(x: 0, y: 0, width: 100, height: 150),cornerRadius: 10)
    
    private var settingsButton2 = ClousureButton(rect: CGRect(x: 0, y: 0, width: 100, height: 150),cornerRadius: 10)
    
    
    private var playButton = ClousureButton(rect: CGRect(x: 0, y: 0, width: 100, height: 150),cornerRadius: 10)
    
    private var playButton2 = ClousureButton(rect: CGRect(x: 0, y: 0, width: 100, height: 150),cornerRadius: 10)
    
    override func didMove(to view: SKView) {
       
        //cambiar color fondo
        scene?.backgroundColor = SKColor(named: "Color")!
        
        //botton play 1
       /* gameButton.fillColor = .red
        gameButton.isUserInteractionEnabled = true
        //gameButton.delegate = self
        gameButton.position = CGPoint(x: view.frame.width / 2.0, y: view.frame.height * 0.33)
        addChild(gameButton)*/
        
        
        playButton.fillColor = .white
        playButton.isUserInteractionEnabled = true
        playButton.position = CGPoint(x: view.frame.width / 4.5, y: view.frame.height * 0.43)
        //playButton.fillColor = SKColor(named: "Color")!
        playButton.strokeColor = .darkGray
        playButton.setText(text: "Game")
        addChild(playButton)
        playButton.onTap = {
            print("por favor dejar de tocarme1")
            
            
        }
        //botton play 2
        playButton2.fillColor = .white
        playButton2.isUserInteractionEnabled = true
        playButton2.position = CGPoint(x: view.frame.width / 1.8, y: view.frame.height * 0.43)
        playButton2.setText(text: "Start")
        playButton2.strokeColor = .darkGray
        addChild(playButton2)
        playButton2.onTap = {
            print("por favor dejar de tocarme2")
        }
        
        //botton options 1
        settingsButton.fillColor = .white
        settingsButton.isUserInteractionEnabled = true
        settingsButton.position = CGPoint(x: view.frame.width / 4.5, y: view.frame.height * 0.13)
        settingsButton.setText(text: "menu")
        settingsButton.strokeColor = .darkGray
        addChild(settingsButton)
        settingsButton.onTap = {
            print("por favor dejar de tocarme3")
        }
        
        //botton options 2
        settingsButton2.fillColor = .white
        settingsButton2.isUserInteractionEnabled = true
        settingsButton2.position = CGPoint(x: view.frame.width / 1.8, y: view.frame.height * 0.13)
        settingsButton2.setText(text: "Options")
        settingsButton2.strokeColor = .darkGray
        addChild(settingsButton2)
        settingsButton2.onTap = {
            print("por favor dejar de tocarme4")
        }
        /*
        aboutButton.fillColor = .white
        aboutButton.isUserInteractionEnabled = true
        aboutButton.position = CGPoint(x: view.frame.width / 2.0, y: view.frame.height * 0.63)
        addChild(aboutButton)
        aboutButton.onTap = {
            [weak self] in self?.settingsButton.fillColor = .orange
            print("por favor dejar de tocarme")
        }
        */
        let logo = SKSpriteNode(imageNamed: "enti-png-2")
        addChild(logo)
        logo.position = CGPoint(x: view.frame.width / 2.0, y: view.frame.height * 0.86)
        logo.scale(to: CGSize(width: 200,height: 100))
        
        // Get label node from scene and store it for use later
      /*  self.label = SKLabelNode(text: "Hello, World")
        if let label = self.label {
            self.addChild(label)
            label.color = .red
            label.position = view.center
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }*/
        
        // Create shape node to use during mouse interaction
      /*  let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }*/
    
       
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            let pulse = SKAction.sequence([SKAction.scale(by: 0.5, duration: 0.25),SKAction.scale(by: 2.0, duration: 0.25)])
            label.run(pulse, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    //aplicando el onTap con closures
   /* func onTap(sender: Button){
        if(sender == gameButton){
            print("le han dado")
        } else if sender == settingButton{
            print("pos el otro")
        }
    }*/
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
