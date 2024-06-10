//
//  MessageModel.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation

struct MessageResponseModel: Codable {
    let msgCode: String
    let msgContent: String
    let result: MessageResultModel?
}

struct MessageResultModel: Codable {
    let messages: [MessageModel]?
}

struct MessageModel: Codable {
    let status: Bool
    let updateDateTime: String
    let title: String
    let message: String
    
    private static var cachedUpdateDateTimeInterval: TimeInterval?
    var updateDateTimeInterval: TimeInterval? {
        if let cachedInterval = Self.cachedUpdateDateTimeInterval {
            return cachedInterval
        } else {
            if let interval = DateHelper.string2TimeInterval(updateDateTime) {
                Self.cachedUpdateDateTimeInterval = interval
                return interval
            } else {
                return nil
            }
        }
    }
}


