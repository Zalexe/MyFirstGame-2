//
//  CardSprite.swift
//  MyFirstGame
//
//  Created by Programacion Moviles on 21/03/2019.
//  Copyright © 2019 Programacion Moviles. All rights reserved.
//

import UIKit
import GameplayKit


protocol CardDelegate: class {
    func onTap(sender: CardSprite)
}


class CardSprite: SKSpriteNode {
    
    weak var delegate: CardDelegate?
    var onTap: (() -> (Void))?
    
    var card = [Card]()
    var TextureFront = SKTexture(imageNamed: "CardFront")
    public let imageName:String
    let TextureBack = SKTexture(imageNamed: "CardBack")
    public var beingTouched = false
    
    init(_ texturas: String){
        imageName = texturas
        TextureFront = SKTexture(imageNamed: texturas)
        
        
        let texture = SKTexture(imageNamed: texturas)
        super.init(texture: TextureBack, color: .black, size: texture.size())
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let action = SKAction.scale(by: 0.9, duration: 0.1)
        run(action)
        beingTouched = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let action = SKAction.scale(by: 1.0/0.9, duration: 0.1)
        run(action)

        if let touch = touches.first, let parent = parent {
            
            if frame.contains(touch.location(in: parent)){
                if let onTap = onTap{
                    onTap()
                }
                
            }
            
        }
    }
    

}
