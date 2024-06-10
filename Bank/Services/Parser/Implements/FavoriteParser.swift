//
//  FavoriteParser.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation

class FavoriteParser: JSONParserStrategy {
    typealias ParseResult = FavoriteResponseModel
    
    func parse(data: Data) -> Result<ParseResult, Error> {
        do {
            let jsonDic = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            print(jsonDic)
            let decoder = JSONDecoder()
            let responseModel = try decoder.decode(FavoriteResponseModel.self, from: data)
            return .success(responseModel)
        } catch {
            print("Parser Failed to load data: \(error.localizedDescription)")
            return .failure(ParseError.parseError)
        }
    }
}
