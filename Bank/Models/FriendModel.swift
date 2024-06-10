//
//  FriendModel.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/10.
//

import Foundation

struct FriendModel: Codable {
    let name: String
    let status: Int
    let isTop: String
    let fid: String
    let updateDate: String
    
    var updateDateTime: Double? {
        if let double = DateHelper.string2TimeDouble(updateDate, dateFormat: "yyyy/MM/dd") {
            return double
        } else if let double = DateHelper.string2TimeDouble(updateDate, dateFormat: "yyyyMMdd") {
            return double
        } else {
            return nil
        }
    }
    
    var isTopInt: Int {
        if let isTopInt = Int(isTop) {
            return isTopInt
        } else {
            return 0
        }
    }
}

struct FriendResponseModel: Codable {
    let response: [FriendModel]?
}
