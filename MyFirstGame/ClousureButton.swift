//
//  Button.swift
//  MyFirstGame
//
//  Created by Programacion Moviles on 07/03/2019.
//  Copyright © 2019 Programacion Moviles. All rights reserved.
//

import SpriteKit


class ClousureButton: SKShapeNode {
    
    
    var onTap: (() -> (Void))?
    var touched = false
 /*   required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init(rect: CGRect, cornerRadius: CGFloat){
        super.init()
        super.init(rect: rect, cornerRadius: cornerRadius)
    }*/
    private var textNode = SKLabelNode()
    private var Sprite = SKSpriteNode()
    
    func setText(text: String){
        if textNode.parent == nil{
            addChild(textNode)
            textNode.verticalAlignmentMode = .center
            
            textNode.position = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)
            textNode.fontColor = .black
        }
        textNode.text = text
    }
    func setSprite(text: String){
        if Sprite.parent == nil{
            addChild(Sprite)
            
            
            Sprite.position = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)
           
        }
        Sprite = SKSpriteNode(imageNamed: text)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let action = SKAction.scale(by: 0.9, duration: 0.2)
        run(action)
        
        self.fillColor = .darkGray
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let action = SKAction.scale(by: 1.0/0.9, duration: 0.2)
        run(action)
        self.fillColor = .white
        if let touch = touches.first, let parent = parent{
            
            if frame.contains(touch.location(in: parent)){
                if let onTap = onTap{
                    onTap()
                }
             
            }
            
        }
        
        
    }
    
}
