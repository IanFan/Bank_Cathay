//
//  FreindTabModel.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/11.
//

import Foundation

struct FriendTabModel: Codable {
    let name: String
    var badgeCount: Int
    var isSelected: Bool = false
    
    mutating func updateBadgeCount(to newCount: Int) {
        badgeCount = newCount
    }
    mutating func updateIsSelected(to newIsSelected: Bool) {
        isSelected = newIsSelected
    }
}
