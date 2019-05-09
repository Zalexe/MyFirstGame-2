//
//  AboutScene.swift
//  MyFirstGame
//
//  Created by Programacion Moviles on 8/3/19.
//  Copyright © 2019 Programacion Moviles. All rights reserved.
//
import UIKit
import SpriteKit

protocol AboutSceneDelegate: class {
    func back(sender: AboutScene)
}

//opciones
class AboutScene: SKScene, ButtonDelegate {
    
    static let buttonWidth: CGFloat = 200.0
    static let buttonHeight: CGFloat = 50.0
    static let cardWidth: CGFloat = 100.0
    static let cardHeight: CGFloat = 150.0
    
    weak var aboutDelegate: AboutSceneDelegate?
    
    private var label : SKLabelNode?
    
    var cartas: [String] = ["CardFront","obelisk","sliffer","Chimeratech","fusion","mirror","stardust","firewall","dhampir","chaosmax","pendulum","supreme"]
    
    
    //botones cambiar imagen carta
    private var nextCard = ClousureButton(rect: CGRect(x: 0, y: 0, width: 50, height: 50),cornerRadius: 10)
    private var backCard = ClousureButton(rect: CGRect(x: 0, y: 0, width: 50, height: 50),cornerRadius: 10)
    private var selectImage = ClousureButton(rect: CGRect(x: 0, y: 0, width: 180, height: 50),cornerRadius: 40)
    
    
    
    private var backButton = Button(rect: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight), cornerRadius: 10)
    
    var swipeRightGesture = UISwipeGestureRecognizer()
    
    
    //para escribir texto
   // var text:UITextField
    
    
    
    override func didMove(to view: SKView) {
        
        backButton.setText(text: "BACK")
        backButton.fillColor = .red
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: (view.frame.width / 2.0) - (AboutScene.buttonWidth / 2 ), y: 100)
        addChild(backButton)
        
        //botones cambiar imagen carta
        nextCard.fillColor = .white
        nextCard.isUserInteractionEnabled = true
        nextCard.position = CGPoint(x: view.frame.width / 2 + (AboutScene.cardWidth / 2) + 25 /*mitad de su tamaño*/, y: view.frame.height * 0.63)
        //playButton.fillColor = SKColor(named: "Color")!
        nextCard.strokeColor = .darkGray
        nextCard.setText(text: ">")
        addChild(nextCard)
        
        let nombreArchivoCarta = "4corazones"
        let carta = SKSpriteNode(imageNamed: nombreArchivoCarta)
        addChild(carta)
        
        carta.scale(to: CGSize(width: AboutScene.cardWidth,height: AboutScene.cardHeight))
        carta.position = CGPoint(x: view.frame.width / 2.0, y: view.frame.height * 0.66)
        
        //swipe hacia la derecha, falta muchas cosas
        
        
        if view == nil{
            
            swipeRightGesture.view?.removeGestureRecognizer(swipeRightGesture)
        }
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(sender:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        backCard.fillColor = .white
        backCard.isUserInteractionEnabled = true
        backCard.position = CGPoint(x: view.frame.width / 4 - (AboutScene.cardWidth / 2) , y: view.frame.height * 0.63)
        //playButton.fillColor = SKColor(named: "Color")!
        backCard.strokeColor = .darkGray
        backCard.setText(text: "<")
        addChild(backCard)
        
        selectImage.fillColor = .green
        selectImage.isUserInteractionEnabled = true
        selectImage.position = CGPoint(x: view.frame.width / 2 - 160, y: view.frame.height * 0.33)
        //playButton.fillColor = SKColor(named: "Color")!
        selectImage.strokeColor = .cyan
        selectImage.setText(text: "Selec.Image")
        addChild(selectImage)
        
        //para escribir
        /*var textField = UITextField(frame: CGRect(x: 0,  y:-200, width: 10, height: 10))
        textField.delegate = self
        view.addSubview(scene: scene)*/
        
        scene?.backgroundColor = SKColor(named: "Color")!
        
    }

    override func willMove(from view: SKView){
        view.removeGestureRecognizer(swipeRightGesture)
    }
    
    
    func onTap(sender: Button) {
        if sender == backButton {
            aboutDelegate?.back(sender: self)
        }
    }
    
    @objc func swipeRight(sender: UISwipeGestureRecognizer){
        print("Swipe detectado")
    }
    
    
    
    
    //pa escribir
 /*   func onTap(sender: Button){
        textField.becomeFirstResponder()
    }
    override func touchesEnded(_ touches: set<UITouch>, with event: UIEvent?){
        textField.resignFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersInRange: NSRange, replacementString string:String) -> Bool{
        let newString =((textField.text ?? "")as NSString).replacingCharacters(in: range, with: string) as String
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }*/
    
}
