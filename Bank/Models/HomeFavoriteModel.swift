//
//  HomeFavoriteModel.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/9.
//

import Foundation
import UIKit

struct HomeFavoriteModel: Codable {
    let transType: String
    let title: String
    
    var imageName: String {
        switch transType {
        case "CUBC": return "button00ElementScrollTree"
        case "Mobile": return "button00ElementScrollMobile"
        case "PMF": return "button00ElementScrollBuilding"
        case "CreditCard": return "button00ElementScrollCreditCard"
        default: return ""
        }
    }
}
