//
//  EndGameScene.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 31.05.2022.
//

import SpriteKit

class EndGameScene: SKScene {
    var text: String?
    var game: FollowTheOrderGame?
    
    override func didMove(to view: SKView) {
        createResultsLabel()
        createPlayAgainLabel()
        
        if game?.status == .won {
            victory()
        } else if game?.status == .lost {
            loss()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.reveal(with: .down, duration: 1)
        let gameScene = GameScene(size: size)

        gameScene.scaleMode = .resizeFill
        if var game = game {
            game.playAgain()
            gameScene.game = game
        } else {
            gameScene.game = FollowTheOrderGame()
        }
       
        view?.presentScene(gameScene, transition: transition)
    }
    
    private func createResultsLabel() {
        let label = SKLabelNode(fontNamed: "Gill Sans")
        label.text = text ?? "Lorem ipsum, dolor sit amet."
        label.numberOfLines = 0
        Utils.adjustLabelFontSize(label: label, in: CGRect(
            x: frame.width * 0.1,
            y: frame.height,
            width: frame.width * 0.8,
            height: frame.height
        ))
        label.position = CGPoint(x: frame.midX, y: frame.midY -
                                 label.frame.height / 2.0)
        addChild(label)
    }
 
    private func createPlayAgainLabel() {
        let label = SKLabelNode(fontNamed: "Helvetica Neue UltraLight Italic")
        label.text = "Tap anywhere to play again..."
        Utils.adjustLabelFontSize(label: label, in: CGRect(
            x: frame.width * 0.2,
            y: frame.height,
            width: frame.width * 0.6,
            height: frame.height
        ))
        label.position = CGPoint(x: frame.midX, y: frame.height * 0.3 -
                                 label.frame.height / 2.0)
        addChild(label)
    }
    
    private func victory() {
        run(Constants.victorySound)
    }
    
    private func loss() {
        run(Constants.lossSound)
    }
}
