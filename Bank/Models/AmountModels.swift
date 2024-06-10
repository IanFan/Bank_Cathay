//
//  AmountModel.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation

// MARK: Saving
struct AmountSavingResponseModel: Codable {
    let msgCode: String
    let msgContent: String
    let result: AmountSavingResultModel?
}
struct AmountSavingResultModel: Codable {
    let savingsList: [AmountSavingModel]
}
struct AmountSavingModel: Codable {
    let account: String
    let curr: String
    let balance: Double
    
    var formattedBalance: String {
        return balance.formattedBalance()
    }
}

// MARK: Fixed Deposit
struct AmountFixedDepositResponseModel: Codable {
    let msgCode: String
    let msgContent: String
    let result: AmountFixedDepositResultModel?
}
struct AmountFixedDepositResultModel: Codable {
    let fixedDepositList: [AmountFixedDepositModel]
}
struct AmountFixedDepositModel: Codable {
    let account: String
    let curr: String
    let balance: Double
}

// MARK: Digital
struct AmountDigitalResponseModel: Codable {
    let msgCode: String
    let msgContent: String
    let result: AmountDigitalResultModel?
}
struct AmountDigitalResultModel: Codable {
    let digitalList: [AmountDigitalModel]
}
struct AmountDigitalModel: Codable {
    let account: String
    let curr: String
    let balance: Double
}
