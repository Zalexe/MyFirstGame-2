//
//  GameScene.swift
//  MyFirstGame
//
//  Created by Programacion Moviles on 15/02/2019.
//  Copyright © 2019 Programacion Moviles. All rights reserved.
//




import SpriteKit
import GameplayKit



protocol MenuSceneDelegate: class {
    func goToGame(sender: MenuScene)
    func goToAbout(sender: MenuScene)
    func goToSettings(sender: MenuScene)
}

class MenuScene: SKScene/*, ButtonDelegate*/ {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    weak var menuDelegate: MenuSceneDelegate?
    
    
    private var gameButton = Button(rect: CGRect(x: 0, y: 0, width: 50, height: 50),cornerRadius: 10)
    private var aboutButton = ClousureButton(rect: CGRect(x: 0, y: 0, width: 50, height: 150),cornerRadius: 40)
    private var settingsButton = ClousureButton(rect: CGRect(x: 0, y: 0, width: 200, height: 80),cornerRadius: 40)

    private var playButton = ClousureButton(rect: CGRect(x: 0, y: 0, width: 200, height: 80),cornerRadius: 40)
    
    
    override func didMove(to view: SKView) {
        
        //cambiar color fondo
        scene?.backgroundColor = SKColor(named: "Color")!
        
        
        
        playButton.fillColor = .green
        playButton.isUserInteractionEnabled = true
        playButton.position = CGPoint(x: view.frame.width / 2 -  100, y: view.frame.height * 0.40)
        //playButton.fillColor = SKColor(named: "Color")!
        playButton.strokeColor = .cyan
        playButton.setText(text: "Game Start")
        addChild(playButton)
        playButton.onTap = {
            [weak self] in
            print("le han dado al opciones")
            if let scene = self, let menuDelegate = self?.menuDelegate {
                menuDelegate.goToGame(sender: scene)
            }
        }
        

        
        //botton options 1
        settingsButton.fillColor = .yellow
        settingsButton.isUserInteractionEnabled = true
        settingsButton.position = CGPoint(x: view.frame.width / 2 - 100, y: view.frame.height * 0.20)
        settingsButton.setText(text: "Settings")
        settingsButton.strokeColor = .cyan
        addChild(settingsButton)

        settingsButton.onTap = {
            [weak self] in
            print("le han dado al opciones")
            if let scene = self, let menuDelegate = self?.menuDelegate {
                menuDelegate.goToAbout(sender: scene)
            }
        }
        
        

        
        
        let logo = SKSpriteNode(imageNamed: "enti-png-2")
        addChild(logo)
        logo.position = CGPoint(x: view.frame.width / 2.0 , y: view.frame.height * 0.86)
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
