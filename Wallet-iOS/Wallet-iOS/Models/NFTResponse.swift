//
//  NFTResponse.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/24/24.
//

import Foundation

// Model for NFT ID
struct NFTID: Codable {
    let tokenId: String
    let tokenMetadata: TokenMetadata
}

// Model for NFT
struct NFT: Codable {
    let id: NFTID
    let title: String?
    let description: String?
    let contract: Contract?
    let metadata: Metadata?
    let media: [Media]?
}

struct TokenMetadata: Codable {
    let tokenType: String
}

struct Metadata: Codable {
    let name: String?
    let description: String?
    let image: String?
}

struct Contract: Codable {
    let address: String
}

struct Media: Codable {
    let gateway: String?
    let thumbnail: String?
    let raw: String?
    let format: String?
    let bytes: Int?
}

// Model for the API response
struct NFTResponse: Codable {
    let ownedNfts: [NFT]
    let totalCount: Int
    let blockHash: String
}
