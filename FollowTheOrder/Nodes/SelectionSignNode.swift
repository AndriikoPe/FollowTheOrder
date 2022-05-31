//
//  SelectionSignNode.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 31.05.2022.
//

import SpriteKit

class SelectionSignNode: SKNode {
    init(at location: CGPoint, radius: CGFloat, value: String) {
        super.init()
        
        let circle = SKShapeNode(circleOfRadius: radius)
        circle.position = location
        circle.strokeColor = .red
        circle.glowWidth = 3.0
        circle.fillColor = .white
        circle.zPosition = 10
        
        let label = SKLabelNode(fontNamed: "Helvetica")
        label.fontSize = 20
        label.position = location
        label.verticalAlignmentMode = .center
        label.fontColor = .red
        label.text = value
        label.zPosition = 20
        
        addChild(circle)
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
