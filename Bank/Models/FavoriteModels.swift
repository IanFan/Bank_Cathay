//
//  FavoriteModels.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation

struct FavoriteResponseModel: Codable {
    let msgCode: String
    let msgContent: String
    let result: FavoriteResultModel?
}

struct FavoriteResultModel: Codable {
    let favoriteList: [FavoriteModel]?
}

struct FavoriteModel: Codable {
    let nickname: String
    let transType: String
}
