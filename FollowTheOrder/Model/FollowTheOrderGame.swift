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
    
    var numberOfSelectedItems: Int {
        selectionSequence.count
    }
    
    private(set) var status = Status.progressing
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
    
    mutating func tappedIcon(with id: GameIcon.ID) -> Bool {
        guard let index = icons.firstIndex(where: { $0.id == id }),
              !selectionSequence.contains(index) else { return false }
        selectionSequence.append(index)
        if icons.count == selectionSequence.count {
            checkResults()
        }
        return true
    }
    
    func isSelected(_ id: GameIcon.ID) -> Bool {
        selectionSequence.contains(where: { icons[$0].id == id })
    }
    
    private mutating func checkResults() {
        var index = -1
        let victory = selectionSequence.allSatisfy {
            index += 1
            return $0 == index
        }
        status = victory ? .won : .lost
    }
    
    enum Status {
        case won, lost, progressing
    }
}
