//
//  AboutScene.swift
//  MyFirstGame
//
//  Created by Programacion Moviles on 8/3/19.
//  Copyright © 2019 Programacion Moviles. All rights reserved.
//

import SpriteKit

protocol DifficultySceneDelegate: class {
    func back(sender: DifficultyScene)
     func goToEasy(sender: DifficultyScene)
     func goToMedium(sender: DifficultyScene)
     func goToHard(sender: DifficultyScene)
}

//opciones
class DifficultyScene: SKScene, ButtonDelegate {
    
    static let buttonWidth: CGFloat = 200.0
    static let buttonHeight: CGFloat = 50.0
    
    weak var DifficultyDelegate: DifficultySceneDelegate?
    
    private var label : SKLabelNode?
    
    //botones cambiar imagen carta
    private var EasyButton = ClousureButton(rect: CGRect(x: 0, y: 0, width: 100, height: 50),cornerRadius: 10)
    private var NormalButton = ClousureButton(rect: CGRect(x: 0, y: 0, width: 100, height: 50),cornerRadius: 10)
    private var HardButton = ClousureButton(rect: CGRect(x: 0, y: 0, width: 100, height: 50),cornerRadius: 10)
    
    
    
    private var backButton = Button(rect: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight), cornerRadius: 10)
    
    override func didMove(to view: SKView) {
        
        backButton.setText(text: "BACK")
        backButton.fillColor = .red
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: (view.frame.width / 2.0) - (AboutScene.buttonWidth / 2.0), y: 100)
        addChild(backButton)
        
        //probable que ponga el logo en una esquina en todos los menus
        /* let logo = SKSpriteNode(imageNamed: "logo_enti")
         logo.position = view.center
         addChild(logo)*/
        
  
        
        EasyButton.fillColor = .white
        EasyButton.isUserInteractionEnabled = true
        EasyButton.position = CGPoint(x: view.frame.width / 3, y: view.frame.height * 0.70)
        //playButton.fillColor = SKColor(named: "Color")!
        EasyButton.strokeColor = .darkGray
        EasyButton.setText(text: "Easy")
        addChild(EasyButton)
        EasyButton.onTap = {
            [weak self] in
            print("le han dado al opciones")
            if let scene = self, let DifficultyDelegate = self?.DifficultyDelegate {
                DifficultyDelegate.goToEasy(sender: scene)
            }
        }
        
        
        NormalButton.fillColor = .white
        NormalButton.isUserInteractionEnabled = true
        NormalButton.position = CGPoint(x: view.frame.width / 3, y: view.frame.height * 0.55)
        //playButton.fillColor = SKColor(named: "Color")!
        NormalButton.strokeColor = .darkGray
        NormalButton.setText(text: "Normal")
        addChild(NormalButton)
        NormalButton.onTap = {
            [weak self] in
            print("le han dado al opciones")
            if let scene = self, let DifficultyDelegate = self?.DifficultyDelegate {
                DifficultyDelegate.goToMedium(sender: scene)
            }
        }
        
        HardButton.fillColor = .white
        HardButton.isUserInteractionEnabled = true
        HardButton.position = CGPoint(x: view.frame.width / 3, y: view.frame.height * 0.40)
        //playButton.fillColor = SKColor(named: "Color")!
        HardButton.strokeColor = .darkGray
        HardButton.setText(text: "Hard")
        addChild(HardButton)
        HardButton.onTap = {
            [weak self] in
            print("le han dado al opciones")
            if let scene = self, let DifficultyDelegate = self?.DifficultyDelegate {
                DifficultyDelegate.goToHard(sender: scene)
            }
        }
        scene?.backgroundColor = SKColor(named: "Color")!
        
        // Get label node from scene and store it for use later
        self.label = SKLabelNode(text: "Hello, World")
        if let label = self.label {
            addChild(label)
            label.color = .red
            //  label.position = logo.position.applying(CGAffineTransform(translationX: 0, y: -100))
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
    }
    
    func onTap(sender: Button) {
        if sender == backButton {
            DifficultyDelegate?.back(sender: self)
        }
    }
    
}
