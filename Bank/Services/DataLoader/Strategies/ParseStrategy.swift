//
//  ParseStrategy.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation

protocol DataParseParams {
    var data: Data { get }
}

protocol ParseStrategy {
    associatedtype ResultType
    associatedtype DataParseParams
    func parseParams(params: DataParseParams) -> ResultType?
}

// MARK: - PARSER User
struct DataParseParams_user: DataParseParams {
    var data: Data
}

class ParseStrategy_user: ParseStrategy {
    typealias DataParseParams = DataParseParams_user
    typealias ResultType = UserResponseModel
    
    func parseParams(params: DataParseParams_user) -> UserResponseModel? {
        let data = params.data
        
        let parser = UserParser()
        let result = parser.parse(data: data)
        
        switch result {
        case .success(let response):
            return response
        case .failure(let failure):
            return nil
        }
    }
}

// MARK: - PARSER Friend
struct DataParseParams_friend: DataParseParams {
    var data: Data
}

class ParseStrategy_friend: ParseStrategy {
    typealias DataParseParams = DataParseParams_friend
    typealias ResultType = FriendResponseModel
    
    func parseParams(params: DataParseParams_friend) -> FriendResponseModel? {
        let data = params.data
        
        let parser = FriendParser()
        let result = parser.parse(data: data)
        
        switch result {
        case .success(let response):
            return response
        case .failure(let failure):
            return nil
        }
    }
}
