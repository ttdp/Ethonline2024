//
//  CoinPaprikaResponse.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/25.
//

import Foundation

struct CoinPaprikaResponse: Codable {
    let id: String
    let name: String
    let symbol: String
    let rank: Int
    let first_data_at: String
    let last_updated: String
    let quotes: Quotes
}

struct Quotes: Codable {
    let USD: QuoteDetails
}

struct QuoteDetails: Codable {
    let price: Double
    let volume_24h: Double
    let market_cap: Double
    let percent_change_15m: Double
    let percent_change_30m: Double
    let percent_change_1h: Double
    let percent_change_6h: Double
    let percent_change_12h: Double
    let percent_change_24h: Double
}

struct TokenQuota {
    let name: String
    let price: Double
    let change_15m: Double
}
