//
//  JsonParserStrategy.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation

protocol JSONParserStrategy {
    associatedtype ParseResult
    
    func parse(data: Data) -> Result<ParseResult, Error>
}
