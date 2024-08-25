//
//  AlchemyResponse.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/25.
//

import Foundation

struct AlchemyResponse: Codable {
    let jsonrpc: String
    let id: Int
    let result: String?     // The balance in Wei, represented as a hexadecimal string.
    let error: AlchemyError?
}

struct AlchemyError: Codable {
    let code: Int
    let message: String
}
