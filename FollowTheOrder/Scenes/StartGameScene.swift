//
//  StartGameScene.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 30.05.2022.
//

import SpriteKit

class StartGameScene: SKScene {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let gameScene = GameScene(size: size)
        
        gameScene.scaleMode = .resizeFill
        gameScene.game = FollowTheOrderGame()
        
        view?.presentScene(gameScene, transition: transition)
    }
}
