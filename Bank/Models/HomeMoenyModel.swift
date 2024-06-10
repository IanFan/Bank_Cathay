//
//  HomeMoenyModel.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/9.
//

import Foundation
import UIKit

struct HomeMoenyModel: Codable {
    let curr: String
    let balance: Double?
    
    var formattedBalance: String? {
        return balance?.formattedBalance()
    }
}
