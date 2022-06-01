//
//  Constants.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 30.05.2022.
//

import SpriteKit

struct Constants {
    // MARK: - User defaults keys.
    
    static let levelUserDefaultsKey = "maxLevel"
    
    // MARK: - Names.
    // Files.
    static let victoryExplosionFileName = "VictoryExplosion"
    static let loseExplosionFileName = "LoseExplosion"
    // Fonts.
    static let hintFontName = "Helvetica Neue UltraLight Italic"
    static let titleFontName = "Gill Sans SemiBold"
    static let resultsLabelFontName = "Gill Sans"
  
    // MARK: - Icon types.
    
    enum IconType: String, CaseIterable {
        case dh = "dh_icon"
        case dk = "dk_icon"
        case druid = "druid_icon"
        case hunter = "hunter_icon"
        case mage = "mage_icon"
        case monk = "monk_icon"
        case pal = "pal_icon"
        case priest = "priest_icon"
        case rogue = "rogue_icon"
        case sham = "sham_icon"
        case war = "war_icon"
        case wl = "wl_icon"
        
        static var randomIcon: Self {
            Self.allCases.randomElement()!
        }
    }
    
    // MARK: - Animation.
    
    static let standardTransitionDuration = 0.5
}

struct Resources {
    // MARK: - Texts.
  
    static let titleText = "Follow the Order"
    static let startHintText = "Tap anywhere to start..."
    static let playAgainHintText = "Tap anywhere to play again..."
    static let failedFetchWinText = "You rule!"
    static let loseText = "Oooops"
    static let resultsDefaultText = "Lorem ipsum, dolor sit amet."
    
    // MARK: - Sounds.
    
    static let victorySound = SKAction.playSoundFileNamed("Victory", waitForCompletion: false)
    static let lossSound = SKAction.playSoundFileNamed("Loss", waitForCompletion: false)
    
    static let dealSound = SKAction.playSoundFileNamed("Deal", waitForCompletion: false)
    static let dealLastSound = SKAction.playSoundFileNamed("Deal_last", waitForCompletion: false)
    static let selectSound = SKAction.playSoundFileNamed("Select", waitForCompletion: false)
}

struct Utils {
    static func adjustLabelFontSize(label: SKLabelNode, in rect: CGRect) {
        let scalingFactor = min(rect.width / label.frame.width,
                                rect.height / label.frame.height)
        label.fontSize *= scalingFactor
    }
}
