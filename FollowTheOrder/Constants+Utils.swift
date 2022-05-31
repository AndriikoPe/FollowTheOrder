//
//  Constants.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 30.05.2022.
//

import SpriteKit

struct Constants {
    static let  levelUserDefaultsKey = "maxLevel"
    
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
