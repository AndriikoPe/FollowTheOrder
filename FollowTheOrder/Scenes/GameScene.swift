//
//  GameScene.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 30.05.2022.
//

import SpriteKit

class GameIconNode: SKSpriteNode {
    let gameIcon: GameIcon
    
    init(using gameIcon: GameIcon) {
        self.gameIcon = gameIcon
        let texture = SKTexture(imageNamed: gameIcon.type.rawValue)
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GameScene: SKScene {
    private var level: Int = {
        // Returns 0 if no value for that key.
        UserDefaults.standard.integer(forKey: Constants.levelUserDefaultsKey)
    }() {
        didSet {
            UserDefaults.standard.set(level, forKey: Constants.levelUserDefaultsKey)
        }
    }
    
    private var dealingIcons = false
    
    var game: FollowTheOrderGame?
    
    override func didMove(to view: SKView) {
        createIcons(in: view)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !dealingIcons else { return }
        for touch in touches {
            guard let tappedIcon = nodes(at: touch.location(in: self))
                    .first(where: { $0 is GameIconNode }) as? GameIconNode
            else { continue }
            game?.tappedIcon(with: tappedIcon.gameIcon.id)
        }
    }
    
    private func createIcons(in view: SKView) {
        guard let game = game else { return }
        dealingIcons = true
        let rows = min((game.numberOfItems - 1) >> 1, 3)
        let containerSize = Int(size.width) / rows
        let scatteringRange = DrawingConst.minIconScattering...(containerSize - DrawingConst.iconSide)
        let positions = game.icons.indices.map { index -> CGPoint in
            let xPos = Int.random(in: scatteringRange) + (index % rows) * containerSize
            let yPos = Int(size.height) - (index / rows) * containerSize -
                Int.random(in: scatteringRange) - DrawingConst.iconsTopOffset
            return CGPoint(x: xPos, y: yPos)
        }
        dealIcons(at: positions.shuffled())
    }
    
    private func dealIcons(at positions: [CGPoint]) {
        guard let game = game else { return }
        positions.indices.forEach { [weak self] index in
            DispatchQueue.main.asyncAfter(deadline: .now() +
                                          DrawingConst.dealAnimationDelay * Double(index + 1)) {
                let icon = GameIconNode(using: game.icons[index])
                icon.position = positions[index]
                icon.size = DrawingConst.iconSize
                self?.addChild(icon)
                // Check if dealt last icon.
                if index == game.numberOfItems - 1 { self?.dealingIcons = false }
            }
        }
    }
    
    private struct DrawingConst {
        static let iconsTopOffset = 150
        static let iconSide = 80
        static let minIconScattering = 50
        static let dealAnimationDelay = 0.5
        static let iconSize = CGSize(width: iconSide, height: iconSide)
    }
}
