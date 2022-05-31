//
//  GameScene.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 30.05.2022.
//

import SpriteKit

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
    private var icons = [SKSpriteNode]()
    
    var game: FollowTheOrderGame?
    
    override func didMove(to view: SKView) {
        createIcons(in: view)
    }
    
    private func createIcons(in view: SKView) {
        guard let game = game else { return }
        dealingIcons = true
        let rows = min((game.numberOfItems - 1) / 2, 3)
        let containerSize = Int(size.width) / rows
        let scatteringRange = DrawingConstants.minIconScattering...(containerSize - DrawingConstants.iconSide)
        icons = (0..<game.numberOfItems).compactMap { index in
            guard let icon = Utils.randomCharSprite else { return nil }
            icon.size = DrawingConstants.iconSize
            let xPos = Int.random(in: scatteringRange) + (index % rows) * containerSize
            let yPos = Int(size.height) - (index / rows) * containerSize -
                Int.random(in: scatteringRange) - DrawingConstants.iconsTopOffset
            icon.position = CGPoint(x: xPos, y: yPos)
            return icon
        }.shuffled()
        dealIcons()
    }
    
    private func dealIcons() {
        icons.indices.forEach { [weak self] index in
            DispatchQueue.main.asyncAfter(deadline: .now() + DrawingConstants.dealAnimationDelay * Double(index)) {
                guard let icon = self?.icons[index] else { return }
                self?.addChild(icon)
                // Check if dealt last icon.
                if index == self?.icons.count ?? 0 - 1 { self?.dealingIcons = false }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !dealingIcons else { return }
    }
    
    private struct DrawingConstants {
        static let iconsTopOffset = 150
        static let iconSide = 80
        static let minIconScattering = 50
        static let dealAnimationDelay = 0.5
        static let iconSize = CGSize(width: iconSide, height: iconSide)
    }
}
