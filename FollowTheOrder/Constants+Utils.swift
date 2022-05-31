//
//  Constants.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 30.05.2022.
//

import SpriteKit

struct Constants {
    static let levelUserDefaultsKey = "maxLevel"
    // MARK: - Sounds.
    static let victorySound = SKAction.playSoundFileNamed("Victory", waitForCompletion: false)
    static let lossSound = SKAction.playSoundFileNamed("Loss", waitForCompletion: false)
    
    static let dealSound = SKAction.playSoundFileNamed("Deal", waitForCompletion: false)
    static let dealLastSound = SKAction.playSoundFileNamed("Deal_last", waitForCompletion: false)
    static let selectSound = SKAction.playSoundFileNamed("Select", waitForCompletion: false)
    
    
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
}

struct Utils {
    static func adjustLabelFontSize(label: SKLabelNode, in rect: CGRect) {
        let scalingFactor = min(rect.width / label.frame.width,
                                rect.height / label.frame.height)
        label.fontSize *= scalingFactor
    }
}
