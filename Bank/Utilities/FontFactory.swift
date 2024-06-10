//
//  ExStaticFunctions.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation
import UIKit

enum FontEnum: String {
    case DEFAULT
    case Helvetica
    case HelveticaBold
    case HelveticaNeue
    case HelveticaNeueMedium
    case HelveticaNeueBold
    case HelveticaNeueBoldItalic
    case SFProTextBold
    case SFProTextHeavy
    case SFProTextMedium
    case SFProTextRegular
    case SFProTextSemibold
    
    init?(rawValue _: String) {
        return nil
    }

    var rawValue: String {
        switch self {
        case .DEFAULT: return "DEFAULT"
        case .Helvetica: return "Helvetica"
        case .HelveticaBold: return "Helvetica-Bold"
        case .HelveticaNeue: return "HelveticaNeue"
        case .HelveticaNeueMedium: return "HelveticaNeue-Medium"
        case .HelveticaNeueBold: return "HelveticaNeue-Bold"
        case .HelveticaNeueBoldItalic: return "HelveticaNeue-BoldItalic"
        case .SFProTextBold: return "SFProText-Bold"
        case .SFProTextHeavy: return "SFProText-Heavy"
        case .SFProTextMedium: return "SFProText-Medium"
        case .SFProTextRegular: return "SFProText-Regular"
        case .SFProTextSemibold: return "SFProText-Semibold"
        }
    }
}
