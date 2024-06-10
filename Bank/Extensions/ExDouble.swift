//
//  ExDouble.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/9.
//

import Foundation

extension Double {
    func formattedBalance() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
