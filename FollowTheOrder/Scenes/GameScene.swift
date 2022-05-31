//
//  GameScene.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 30.05.2022.
//

import SpriteKit

class GameScene: SKScene {
    private var selectionIndicators = [SKLabelNode]()
    private var dealingIcons = false
    
    var game: FollowTheOrderGame?
    
    override func didMove(to view: SKView) {
        createIcons(in: view)
    }
    
    override var isUserInteractionEnabled: Bool {
        get { !dealingIcons }
        set { dealingIcons = !newValue }
    }
    
    // MARK: - Selecting icons.
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            guard let tappedIcon = nodes(at: touch.location(in: self))
                    .first(where: { $0 is GameIconNode }) as? GameIconNode
            else { continue }
            if game?.tappedIcon(with: tappedIcon.gameIcon.id) ?? false {
                let scale = SKAction.scale(by: 0.9, duration: 0.15)
                tappedIcon.run(scale)
                addSelectionSign(at: touch.location(in: self))
                if let status = game?.status, status != .progressing {
                    finishGame(with: status)
                }
            }
        }
    }
    
    private func addSelectionSign(at location: CGPoint) {
        let node = SelectionSignNode(
            at: location,
            radius: CGFloat(DrawingConst.iconSide) / 4.0,
            value: "\(game?.numberOfSelectedItems ?? -1)"
        )
        addChild(node)
    }
    
    // MARK: - Creating icons.
    
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
    
    // MARK: - Game ending.
    
    private func finishGame(with status: FollowTheOrderGame.Status) {
        switch status {
        case .won:
            win()
        case .lost:
            lose()
        default:
            break
        }
    }
    
    private func win() {
        print("You won")
    }
    
    private func lose() {
        print("You lost LOL")
    }
    
    // MARK: - Constants.

    private struct DrawingConst {
        static let iconsTopOffset = 150
        static let iconSide = 80
        static let minIconScattering = 50
        static let dealAnimationDelay = 0.5
        static let iconSize = CGSize(width: iconSide, height: iconSide)
    }
}
