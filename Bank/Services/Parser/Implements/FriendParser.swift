//
//  FriendParser.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/10.
//

import Foundation

class FriendParser: JSONParserStrategy {
    typealias ParseResult = FriendResponseModel
    
    func parse(data: Data) -> Result<ParseResult, Error> {
        do {
            let decoder = JSONDecoder()
            let responseModel = try decoder.decode(FriendResponseModel.self, from: data)
            return .success(responseModel)
        } catch {
            print("Parser Failed to load data: \(error.localizedDescription)")
            return .failure(ParseError.parseError)
        }
    }
}
