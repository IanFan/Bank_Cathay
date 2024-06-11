//
//  ColorFactory.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/9.
//

import Foundation
import UIKit

enum ColorEnum {
    case appleGreen
    case appleGreen40
    case booger
    case frogGreen
    case black10
    case brownGrey
    case greyishBrown
    case pinkishGrey
    case steel
    case steel12
    case white
    case white2
    case white3
    case softPink
    case hotpink

    var color: UIColor {
        switch self {
        case .appleGreen: return UIColor(red: 121, green: 196, blue: 27)
        case .appleGreen40: return UIColor(red: 121, green: 196, blue: 27, alpha: 0.4)
        case .booger: return UIColor(red: 166, green: 204, blue: 66)
        case .frogGreen: return UIColor(red: 86, green: 179, blue: 11)
        case .black10: return UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        case .brownGrey: return UIColor(red: 153, green: 153, blue: 153)
        case .greyishBrown: return UIColor(red: 71, green: 71, blue: 71)
        case .pinkishGrey: return UIColor(red: 201, green: 201, blue: 201)
        case .steel: return UIColor(red: 142, green: 142, blue: 147)
        case .steel12: return UIColor(red: 142, green: 142, blue: 147, alpha: 0.12)
        case .white: return UIColor(red: 245, green: 245, blue: 245)
        case .white2: return UIColor(red: 252, green: 252, blue: 252)
        case .white3: return UIColor(red: 255, green: 255, blue: 255)
        case .softPink: return UIColor(red: 249, green: 178, blue: 220)
        case .hotpink: return UIColor(red: 236, green: 0, blue: 140)
        }
    }
}
