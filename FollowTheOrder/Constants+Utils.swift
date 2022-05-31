//
//  Constants.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 30.05.2022.
//

import SpriteKit

struct Constants {
    static let  levelUserDefaultsKey = "maxLevel"
    
    static let iconsNames = [
        "dh_icon", "dk_icon", "druid_icon",
        "hunter_icon", "mage_icon", "monk_icon",
        "pal_icon", "priest_icon", "rogue_icon",
        "sham_icon", "war_icon", "wl_icon"
    ]
}

struct Utils {
    static var randomCharSprite: SKSpriteNode? {
        SKSpriteNode(imageNamed: Constants.iconsNames.randomElement() ?? "")
    }
}
