//
//  AmountFixedDepositParser.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation

class AmountFixedDepositParser: JSONParserStrategy {
    typealias ParseResult = AmountFixedDepositResponseModel
    
    func parse(data: Data) -> Result<ParseResult, Error> {
        do {
            let decoder = JSONDecoder()
            let responseModel = try decoder.decode(AmountFixedDepositResponseModel.self, from: data)
            return .success(responseModel)
        } catch {
            print("Parser Failed to load data: \(error.localizedDescription)")
            return .failure(ParseError.parseError)
        }
    }
}
