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
        let transition = SKTransition.reveal(
            with: .down,
            duration: Constants.standardTransitionDuration * 2
        )
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
        let label = SKLabelNode(fontNamed: Constants.resultsLabelFontName)
        label.text = text ?? Resources.resultsDefaultText
        label.numberOfLines = 0
        Utils.adjustLabelFontSize(label: label, in: CGRect(
            x: frame.width * (1 - DrawingConst.resultsLabelWidthPercent) / 2.0,
            y: frame.height,
            width: frame.width * DrawingConst.resultsLabelWidthPercent,
            height: frame.height
        ))
        label.position = CGPoint(x: frame.midX, y: frame.midY -
                                 label.frame.height / 2.0)
        addChild(label)
    }
 
    private func createPlayAgainLabel() {
        let label = SKLabelNode(fontNamed: Constants.hintFontName)
        label.text = Resources.playAgainHintText
        Utils.adjustLabelFontSize(label: label, in: CGRect(
            x: frame.width * (1 - DrawingConst.hintLabelWidthPercent) / 2.0,
            y: frame.height,
            width: frame.width * DrawingConst.hintLabelWidthPercent,
            height: frame.height
        ))
        label.position = CGPoint(
            x: frame.midX,
            y: frame.height * DrawingConst.hintLabelYBottomOffset
        )
        addChild(label)
    }
    
    private func victory() {
        run(Resources.victorySound)
    }
    
    private func loss() {
        run(Resources.lossSound)
    }
    
    private struct DrawingConst {
        static let resultsLabelWidthPercent = 0.8
        static let hintLabelWidthPercent = 0.6
        
        static let hintLabelYBottomOffset = 0.3
    }
}
