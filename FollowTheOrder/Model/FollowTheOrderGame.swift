//
//  FollowTheOrderGame.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 31.05.2022.
//

import Foundation

struct FollowTheOrderGame {
    var level: Int = 1 {
        didSet {
            UserDefaults.standard.set(level, forKey: Constants.levelUserDefaultsKey)
        }
    }
    
    var numberOfItems: Int {
        level + 4
    }
    
    private(set) var icons = [GameIcon]()
    private var selectionSequence = [Int]()
    
    init() {
        var savedLevel = UserDefaults.standard.integer(forKey: Constants.levelUserDefaultsKey)
        if savedLevel == 0 {
            savedLevel += 1
            UserDefaults.standard.set(savedLevel, forKey: Constants.levelUserDefaultsKey)
        }
        level = savedLevel
        fillIcons()
    }
    
    mutating func fillIcons() {
        icons = (0..<numberOfItems).map { _ in GameIcon(type: Constants.IconType.randomIcon) }
    }
    
    mutating func tappedIcon(with id: GameIcon.ID) {
        
    }
}
