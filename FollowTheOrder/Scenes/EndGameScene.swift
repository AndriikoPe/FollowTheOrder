//
//  EndGameScene.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 31.05.2022.
//

import SpriteKit

class EndGameScene: SKScene {
    var text: String?
    var status: FollowTheOrderGame.Status?
    
    override func didMove(to view: SKView) {
        let label = SKLabelNode(fontNamed: "Gill Sans")
        label.text = text ?? "O"
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
        
        if status == .won {
            victory()
        } else if status == .lost {
            loss()
        }
    }
    
    private func victory() {
        run(Constants.victorySound)
    }
    
    private func loss() {
        run(Constants.lossSound)
    }
}
