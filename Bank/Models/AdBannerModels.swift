//
//  AdBannerModels.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation

struct AdBannerResponseModel: Codable {
    let msgCode: String
    let msgContent: String
    let result: AdBannerResultModel?
}

struct AdBannerResultModel: Codable {
    let bannerList: [AdBannerModel]
}

struct AdBannerModel: Codable {
    let adSeqNo: Int
    let linkUrl: String
}
