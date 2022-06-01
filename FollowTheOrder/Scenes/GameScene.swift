//
//  GameScene.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 30.05.2022.
//

import SpriteKit

class GameScene: SKScene {
    private var iconsNodes = [GameIconNode]()
    private var selectionIndicators = [SelectionSignNode]()
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
                let scale = SKAction.scale(
                    by: DrawingConst.scaleOnTapValue,
                    duration: DrawingConst.scaleOnTapDuration
                )
                tappedIcon.run(scale)
                run(Resources.selectSound)
                addSelectionSign(
                    with: DrawingConst.selectionSignRadius,
                    at: touch.location(in: self)
                )
                if let status = game?.status, status != .progressing {
                    finishGame(with: status)
                }
            }
        }
    }
    
    private func addSelectionSign(with radius: CGFloat, at location: CGPoint) {
        let node = SelectionSignNode(
            at: location,
            radius: radius,
            value: "\(game?.numberOfSelectedItems ?? -1)"
        )
        selectionIndicators.append(node)
        addChild(node)
    }
    
    // MARK: - Creating icons.
    
    private func createIcons(in view: SKView) {
        guard let game = game else { return }
        dealingIcons = true
        
        let iconSide = Int(size.width * DrawingConst.iconSideFactor)
        let iconSize = CGSize(width: iconSide, height: iconSide)
        
        let rows = min((game.numberOfItems - 1) >> 1, DrawingConst.maxIconsRows)
        let containerSize = Int(size.width) / rows
        let scatteringRange = (DrawingConst.minIconsScattering)...(containerSize - iconSide)
        let positions = game.icons.indices.map { index -> CGPoint in
            let xPos = Int.random(in: scatteringRange) + (index % rows) * containerSize
            let yPos = Int(size.height) - (index / rows) * containerSize -
                Int.random(in: scatteringRange) - DrawingConst.iconsTopOffset
            return CGPoint(x: xPos, y: yPos)
        }
        dealIcons(with: iconSize, at: positions.shuffled())
    }

    private func dealIcons(with iconSize: CGSize, at positions: [CGPoint]) {
        guard let game = game else { return }
        positions.indices.forEach { [weak self] index in
            DispatchQueue.main.asyncAfter(deadline: .now() +
                                          DrawingConst.dealAnimationDelay * Double(index + 1)) {
                let icon = GameIconNode(using: game.icons[index])
                self?.iconsNodes.append(icon)
                icon.position = positions[index]
                icon.size = iconSize
                self?.addChild(icon)
                // Check if dealt last icon.
                if index == game.numberOfItems - 1 {
                    self?.dealingIcons = false
                    self?.run(Resources.dealLastSound)
                } else {
                    self?.run(Resources.dealSound)
                }
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
        removeWithParticles(named: Constants.victoryExplosionFileName)
        FortuneProvider.requestFortune { [weak self] result in
            var fortune = ""
            switch result {
            case .failure(let error):
                print("Something went wrong getting fortune: \(error)")
                fortune = Resources.failedFetchWinText
            case .success(let data):
                fortune = data
            }
            DispatchQueue.main.async {
                guard let self = self else { return }
                let transition = SKTransition.doorsOpenHorizontal(
                    withDuration: Constants.standardTransitionDuration
                )

                let endGameScene = EndGameScene(size: self.size)
                endGameScene.text = fortune
                endGameScene.game = self.game
                endGameScene.scaleMode = .resizeFill
                
                self.view?.presentScene(endGameScene, transition: transition)
            }
        }
    }
    
    private func lose() {
        removeWithParticles(named: Constants.loseExplosionFileName)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            let transition = SKTransition.doorsCloseHorizontal(
                withDuration: Constants.standardTransitionDuration
            )
            
            let endGameScene = EndGameScene(size: self.size)
            endGameScene.text = Resources.loseText
            endGameScene.game = self.game
            endGameScene.scaleMode = .resizeFill
            
            self.view?.presentScene(endGameScene, transition: transition)
        }
    }
        
    private func removeWithParticles(named name: String) {
        selectionIndicators.forEach { $0.removeFromParent() }
        iconsNodes.forEach { icon in
            if let particles = SKEmitterNode(fileNamed: name) {
                particles.position = CGPoint(x: icon.frame.midX, y: icon.frame.midY)
                
                addChild(particles)
                
                let removeAfterFire = SKAction.sequence([
                    SKAction.wait(forDuration: 1),
                    SKAction.removeFromParent()
                ])
                
                particles.run(removeAfterFire)
            }
            icon.removeFromParent()
        }
    }
    
    // MARK: - Constants.

    private struct DrawingConst {
        static let scaleOnTapValue = 0.9
        static let scaleOnTapDuration = 0.15
        
        static let selectionSignRadius = 20.0
        
        static let iconSideFactor = 0.2
        static let maxIconsRows = 3
        
        static let minIconsScattering = 20
        
        static let iconsTopOffset = 150
        static let dealAnimationDelay = 0.8
    }
}
