//
//  StartGameScene.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 30.05.2022.
//

import SpriteKit

class StartGameScene: SKScene {
    override func didMove(to view: SKView) {
        createTitleLabel()
        createHintLabel()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.crossFade(withDuration: Constants.standardTransitionDuration)
        let gameScene = GameScene(size: size)
        
        gameScene.scaleMode = .resizeFill
        gameScene.game = FollowTheOrderGame()
        
        view?.presentScene(gameScene, transition: transition)
    }
    
    private func createTitleLabel() {
        let titleLabel = SKLabelNode(fontNamed: Constants.titleFontName)
        titleLabel.text = Resources.titleText
        let titleRect = CGRect(
            x: size.width * (1 - DrawingConstatns.titleLabelWidthPercent) / 2.0,
            y: size.height,
            width: size.width * DrawingConstatns.titleLabelWidthPercent,
            height: size.height
        )
        Utils.adjustLabelFontSize(label: titleLabel, in: titleRect)
        titleLabel.position = CGPoint(
            x: frame.midX,
            y: frame.midY + frame.height * DrawingConstatns.titleYOffsetFromCenter
        )
        titleLabel.zRotation = DrawingConstatns.titleRotation
        addChild(titleLabel)
    }
    
    private func createHintLabel() {
        let hintLabel = SKLabelNode(fontNamed: Constants.hintFontName)
        hintLabel.text = Resources.startHintText
        let titleRect = CGRect(
            x: size.width * (1 - DrawingConstatns.hintLabelWidthPercent) / 2.0,
            y: size.height,
            width: size.width * DrawingConstatns.hintLabelWidthPercent,
            height: size.height
        )
        Utils.adjustLabelFontSize(label: hintLabel, in: titleRect)
        hintLabel.position = CGPoint(
            x: frame.midX,
            y: frame.height * DrawingConstatns.hintYOffsetFromBottom
        )
        addChild(hintLabel)
    }
    
    private struct DrawingConstatns {
        static let titleLabelWidthPercent = 0.8
        static let hintLabelWidthPercent = 0.6
        
        static let titleYOffsetFromCenter = 0.2
        static let hintYOffsetFromBottom = 0.2
        
        static let titleRotation = 0.03
    }
}
