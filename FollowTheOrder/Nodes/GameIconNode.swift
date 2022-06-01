//
//  GameIconNode.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 31.05.2022.
//

import SpriteKit

class GameIconNode: SKSpriteNode {
    let gameIcon: GameIcon
    
    init(using gameIcon: GameIcon) {
        self.gameIcon = gameIcon
        let texture = SKTexture(imageNamed: gameIcon.type.rawValue)
        super.init(texture: texture, color: .clear, size: texture.size())
        anchorPoint = .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
