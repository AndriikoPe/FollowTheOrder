//
//  FollowTheOrderGame.swift
//  FollowTheOrder
//
//  Created by Пермяков Андрей on 31.05.2022.
//

import Foundation

struct FollowTheOrderGame {
    var level: Int = {
        // Returns 0 if no value for that key.
        var savedLevel = UserDefaults.standard.integer(forKey: Constants.levelUserDefaultsKey)
        if savedLevel == 0 {
            savedLevel += 1
            UserDefaults.standard.set(savedLevel, forKey: Constants.levelUserDefaultsKey)
        }
        return savedLevel
    }() {
        didSet {
            UserDefaults.standard.set(level, forKey: Constants.levelUserDefaultsKey)
        }
    }
    
    var numberOfItems: Int {
        level + 4
    }
}
