//
//  ColorFactory.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/9.
//

import Foundation
import UIKit

enum ColorEnum {
    case localGray500
    case localWhite1
    case localWhite2
    case localWhite3
    case localWhite4
    case localBattleshipGrey
    case localOrange1
    case systemGray4
    case systemGray5
    case systemGray6
    case systemGray7
    case systemGray8
    case systemGray10

    var color: UIColor {
        switch self {
        case .localGray500: return UIColor(red: 136, green: 136, blue: 136)
        case .localWhite1: return UIColor(red: 251, green: 251, blue: 251)
        case .localWhite2: return UIColor(red: 250, green: 250, blue: 250)
        case .localWhite3: return UIColor(red: 240, green: 240, blue: 240)
        case .localWhite4: return UIColor(red: 220, green: 220, blue: 220)
        case .localBattleshipGrey: return UIColor(red: 115, green: 116, blue: 126)
        case .localOrange1: return UIColor(red: 255, green: 136, blue: 97)
        case .systemGray4: return UIColor(red: 190, green: 190, blue: 190)
        case .systemGray5: return UIColor(red: 136, green: 136, blue: 136)
        case .systemGray6: return UIColor(red: 111, green: 111, blue: 111)
        case .systemGray7: return UIColor(red: 85, green: 85, blue: 85)
        case .systemGray8: return UIColor(red: 68, green: 68, blue: 68)
        case .systemGray10: return UIColor(red: 26, green: 26, blue: 26)
        }
    }
}
