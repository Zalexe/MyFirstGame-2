//
//  SpriteButton.swift
//  MyFirstGame
//
//  Created by Programacion Moviles on 15/03/2019.
//  Copyright © 2019 Programacion Moviles. All rights reserved.
//

import UIKit
import SpriteKit
protocol SpriteDelegate: class {
    func onTap(sender: SpriteButton)
}
class SpriteButton: SKSpriteNode {
    var onTap: (() -> (Void))?
    var touched = false
     weak var delegate: SpriteDelegate?
    /*   required init?(coder aDecoder: NSCoder) {
     fatalError()
     }
     
     init(rect: CGRect, cornerRadius: CGFloat){
     super.init()
     super.init(rect: rect, cornerRadius: cornerRadius)
     }*/
    private var textNode = SKLabelNode()
   
    
    func setText(text: String){
        if textNode.parent == nil{
            addChild(textNode)
            textNode.verticalAlignmentMode = .center
            
            textNode.position = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)
            textNode.fontColor = .black
        }
        textNode.text = text
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let action = SKAction.scale(by: 0.9, duration: 0.2)
        run(action)
        
       // self.fillColor = .darkGray
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let action = SKAction.scale(by: 1.0/0.9, duration: 0.2)
        run(action)
       // self.fillColor = .white
        if let touch = touches.first, let parent = parent{
            
            if frame.contains(touch.location(in: parent)){
                if let onTap = onTap{
                    onTap()
                }
                
            }
            
        }
        
        
    }
    
}
