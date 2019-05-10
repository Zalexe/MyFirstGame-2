//
//  GameViewController.swift
//  MyFirstGame
//
//  Created by Programacion Moviles on 15/02/2019.
//  Copyright © 2019 Programacion Moviles. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, MenuSceneDelegate, AboutSceneDelegate, DifficultySceneDelegate, EasySceneDelegate, MediumSceneDelegate, HardSceneDelegate {


    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as? SKView {
            // Load the SKScene from 'GameScene.sks'
            let scene = MenuScene(size: view.frame.size)
            scene.menuDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            //            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func goToAbout(sender: MenuScene) {
        if let view = self.view as? SKView {
            let scene = AboutScene(size: view.frame.size)
            scene.aboutDelegate = self
            scene.viewController = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    
    func goToGame(sender: MenuScene) {
        if let view = self.view as? SKView {
            let scene = DifficultyScene(size: view.frame.size)
            scene.DifficultyDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    func goToEasy(sender: DifficultyScene) {
        if let view = self.view as? SKView {
            let scene = EasyScene(size: view.frame.size)
            scene.EasyDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    func goToMedium(sender: DifficultyScene) {
        if let view = self.view as? SKView {
            let scene = MediumScene(size: view.frame.size)
            scene.MediumDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    func goToHard(sender: DifficultyScene) {
        if let view = self.view as? SKView {
            let scene = HardScene(size: view.frame.size)
            scene.HardDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    func goToSettings(sender: MenuScene) {
        
    }
    
    func back(sender: AboutScene) {
        if let view = self.view as? SKView {
            let scene = MenuScene(size: view.frame.size)
            scene.menuDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    func back(sender: DifficultyScene) {
        if let view = self.view as? SKView {
            let scene = MenuScene(size: view.frame.size)
            scene.menuDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    func back(sender: EasyScene) {
        if let view = self.view as? SKView {
            let scene = DifficultyScene(size: view.frame.size)
            scene.DifficultyDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    
    func goToEasy(sender: EasyScene) {
        
    }
    
    func goToMedium(sender: EasyScene) {
        
    }
    
    func goToHard(sender: EasyScene) {
        
    }
    
    
    func back(sender: MediumScene) {
        if let view = self.view as? SKView {
            let scene = DifficultyScene(size: view.frame.size)
            scene.DifficultyDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    
    func goToEasy(sender: MediumScene) {
        
    }
    
    func goToMedium(sender: MediumScene) {
        
    }
    
    func goToHard(sender: MediumScene) {
        
    }
    func back(sender: HardScene) {
        if let view = self.view as? SKView {
            let scene = DifficultyScene(size: view.frame.size)
            scene.DifficultyDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    
    func goToEasy(sender: HardScene) {
        
    }
    
    func goToMedium(sender: HardScene) {
        
    }
    
    func goToHard(sender: HardScene) {
        
    }
    
    
    

}
