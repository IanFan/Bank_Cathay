//
//  UserModel.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/10.
//

import Foundation

struct UserModel: Codable {
    let name: String
    let kokoid: String
}

struct UserResponseModel: Codable {
    let response: [UserModel]?
}
