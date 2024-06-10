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

// MARK: - PARSER Message
struct DataParseParams_message: DataParseParams {
    var data: Data
}

class ParseStrategy_message: ParseStrategy {
    typealias DataParseParams = DataParseParams_message
    typealias ResultType = MessageResponseModel
    
    func parseParams(params: DataParseParams_message) -> MessageResponseModel? {
        let data = params.data
        
        let parser = MessageParser()
        let result = parser.parse(data: data)
        
        switch result {
        case .success(let response):
            return response
        case .failure(let failure):
            return nil
        }
    }
}

// MARK: - PARSER Amount Saving
struct DataParseParams_amountSaving: DataParseParams {
    var data: Data
}

class ParseStrategy_amountSaving: ParseStrategy {
    typealias DataParseParams = DataParseParams_amountSaving
    typealias ResultType = AmountSavingResponseModel
    
    func parseParams(params: DataParseParams_amountSaving) -> AmountSavingResponseModel? {
        let data = params.data
        
        let parser = AmountSavingParser()
        let result = parser.parse(data: data)
        
        switch result {
        case .success(let response):
            return response
        case .failure(let failure):
            return nil
        }
    }
}

// MARK: - PARSER Amount Fixed Deposit
struct DataParseParams_amountFixedDeposit: DataParseParams {
    var data: Data
}

class ParseStrategy_amountFixedDeposit: ParseStrategy {
    typealias DataParseParams = DataParseParams_amountFixedDeposit
    typealias ResultType = AmountFixedDepositResponseModel
    
    func parseParams(params: DataParseParams_amountFixedDeposit) -> AmountFixedDepositResponseModel? {
        let data = params.data
        
        let parser = AmountFixedDepositParser()
        let result = parser.parse(data: data)
        
        switch result {
        case .success(let response):
            return response
        case .failure(let failure):
            return nil
        }
    }
}

// MARK: - PARSER Amount Digital
struct DataParseParams_amountDigital: DataParseParams {
    var data: Data
}

class ParseStrategy_amountDigital: ParseStrategy {
    typealias DataParseParams = DataParseParams_amountDigital
    typealias ResultType = AmountDigitalResponseModel
    
    func parseParams(params: DataParseParams_amountDigital) -> AmountDigitalResponseModel? {
        let data = params.data
        
        let parser = AmountDigitalParser()
        let result = parser.parse(data: data)
        
        switch result {
        case .success(let response):
            return response
        case .failure(let failure):
            return nil
        }
    }
}

// MARK: - PARSER Favorite
struct DataParseParams_favorite: DataParseParams {
    var data: Data
}

class ParseStrategy_favorite: ParseStrategy {
    typealias DataParseParams = DataParseParams_favorite
    typealias ResultType = FavoriteResponseModel
    
    func parseParams(params: DataParseParams_favorite) -> FavoriteResponseModel? {
        let data = params.data
        
        let parser = FavoriteParser()
        let result = parser.parse(data: data)
        
        switch result {
        case .success(let response):
            return response
        case .failure(let failure):
            return nil
        }
    }
}

// MARK: - PARSER Ad Banner
struct DataParseParams_adBanner: DataParseParams {
    var data: Data
}

class ParseStrategy_adBanner: ParseStrategy {
    typealias DataParseParams = DataParseParams_adBanner
    typealias ResultType = AdBannerResponseModel
    
    func parseParams(params: DataParseParams_adBanner) -> AdBannerResponseModel? {
        let data = params.data
        
        let parser = AdBannerParser()
        let result = parser.parse(data: data)
        
        switch result {
        case .success(let response):
            return response
        case .failure(let failure):
            return nil
        }
    }
}
