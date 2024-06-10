//
//  AmountDigitalParser.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation

class AmountDigitalParser: JSONParserStrategy {
    typealias ParseResult = AmountDigitalResponseModel
    
    func parse(data: Data) -> Result<ParseResult, Error> {
        do {
            let decoder = JSONDecoder()
            let responseModel = try decoder.decode(AmountDigitalResponseModel.self, from: data)
            return .success(responseModel)
        } catch {
            print("Parser Failed to load data: \(error.localizedDescription)")
            return .failure(ParseError.parseError)
        }
    }
}
