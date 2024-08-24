//
//  Paths.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/24/24.
//

import Foundation

struct Paths {

    private init() {}
    
    static let AlchemyAPIKEY = "6xw9VRfg0oDcxD3bWoe6fJF3pehFWqYy"
    
    static let Ethereum = "https://eth-mainnet.alchemyapi.io/v2/\(AlchemyAPIKEY)"
    static let Sepolia = "https://eth-sepolia.g.alchemy.com/v2/\(AlchemyAPIKEY)"
    
    static let NFT = "https://eth-mainnet.alchemyapi.io/v2/\(AlchemyAPIKEY)/getNFTsForOwner"
    
}
